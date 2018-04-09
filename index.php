<?php
function assoc2XML($result_assoc, $tableName, $rowName = 'item') {
  $xml = new SimpleXMLElement('<' . $tableName . '/>');
  foreach ($result_assoc as $row) {
    $item = $xml->addChild($rowName);
    foreach ($row as $key => $value) {
      $item->addChild($key, $value);
    }
  }
  return $xml;
}

function mergeXML($arr, $rootName) {
  $dom = new DOMDocument('1.0', 'utf-8');
  $root = $dom->createElement($rootName);
  $dom->appendChild($root);
  foreach ($arr as $xml) {
    $domxml = dom_import_simplexml($xml);
    $root->appendChild($dom->importNode($domxml, true));
  }
  return simplexml_import_dom($root);
}

function sqlQuery($query) {
  $result = $GLOBALS['connection']->query($query);
  return $result ? $result->fetch_all(MYSQLI_ASSOC) : $GLOBALS['connection']->error;
}

function processAllQueries($xmlDoc) {
  $x = $xmlDoc->documentElement;
  $proc = new XSLTProcessor();
  $proc->importStylesheet(simplexml_load_file("lib/xml2sql.xsl"));
  $queries = $x->getElementsByTagNameNS('sql', 'query');
  for ($i = 0; $i < $queries->length; ++$i) {
    $query = new DOMDocument();
    $rowName = $queries->item($i)->attributes['item']->value;
    $query->appendChild($query->importNode($queries->item($i), true));
    $result = assoc2XML(sqlQuery($proc->transformToXML($query)), $queries->item($i)->parentNode->tagName, $rowName ? $rowName : 'item');
    $x->replaceChild($xmlDoc->importNode(dom_import_simplexml($result), true), $queries->item($i)->parentNode);
  }

  $queries = $x->getElementsByTagNameNS('sql', 'import');
  for ($i = 0; $i < $queries->length; ++$i) {
    $query = new DOMDocument();
    $query->load($queries->item($i)->attributes['href']->value);
    $rowName = $query->documentElement->attributes['item']->value;
    $result = assoc2XML(sqlQuery($proc->transformToXML($query)), $queries->item($i)->parentNode->tagName, $rowName ? $rowName : 'item');
    $x->replaceChild($xmlDoc->importNode(dom_import_simplexml($result), true), $queries->item($i)->parentNode);
  }

  $queries = $x->getElementsByTagNameNS('data', 'import');
  for ($i = 0; $i < $queries->length; ++$i) {
    $query = new DOMDocument();
    $query->load($queries->item($i)->attributes['href']->value);
    $x->replaceChild($xmlDoc->importNode($query->documentElement, true), $queries->item($i));
  }

  return $xmlDoc;
}

function applyTemplate($config, $xmlDoc) {
  $data = new DOMDocument();
  $data->appendChild($data->importNode(dom_import_simplexml($config), true));
  $xmlDocChildren = $xmlDoc->documentElement->childNodes;
  for ($i = 0; $i < $xmlDocChildren->length; $i++) {
    $data->documentElement->appendChild($data->importNode($xmlDocChildren->item($i), true));  
  }
  
  $x = $data->documentElement;
  $templateTag = $x->getElementsByTagNameNS('data', 'template')->item(0);
  $templateName = $templateTag->attributes['href']->value;
  $data->documentElement->removeChild($templateTag);

  $xsl = simplexml_load_file($templateName);
  $proc = new XSLTProcessor();
  $proc->importStylesheet($xsl);
  return $proc->transformToXML($data);
}

function test($config, $pathToData) {
  $xmlDoc = new DOMDocument();
  $xmlDoc->load($pathToData);
  echo applyTemplate($config, processAllQueries($xmlDoc));
}
ob_start();
$config = simplexml_load_file("config.xml");
$servername = $config->db['server'];
$username = $config->db['username'];
$password = $config->db['password'];
$db=  $config->db['database'];
$conn = new mysqli($servername, $username, $password);
$GLOBALS['connection'] = $conn;
$GLOBALS['connection']->select_db($db);

if ($GLOBALS['connection']->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$route = $config->xpath("/config/routes/route[@path='". $_SERVER['REQUEST_URI'] . "']")[0];
$pathToData = $route['href'];

if (!$pathToData) {
  $route = $config->xpath("/config/routes/route[@path='*']")[0];
  if ($route['href'])
    $pathToData = $route['href'];
  else
    $pathToData = 'index.xml';
}
$route->addAttribute('active', 'active');
$config->addChild('debug', ob_get_clean());

test($config, $pathToData);
