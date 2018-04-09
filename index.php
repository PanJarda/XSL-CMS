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
    $ch = dom_import_simplexml($result)->childNodes;
    for ($j = 0; $j < $ch->length; $j++) {
      $queries->item($i)->parentNode->appendChild($xmlDoc->importNode($ch->item($j), true));
    }
    $queries->item($i)->parentNode->removeChild($queries->item($i));
  }

  $queries = $x->getElementsByTagNameNS('sql', 'import');
  for ($i = 0; $i < $queries->length; ++$i) {
    $query = new DOMDocument();
    $query->load($queries->item($i)->attributes['href']->value);
    $rowName = $query->documentElement->attributes['item']->value;
    $result = assoc2XML(sqlQuery($proc->transformToXML($query)), 'tmp', $rowName ? $rowName : 'item');
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

function applyTemplate($config, $templatePath, $xmlDoc = NULL) {
  $data = new DOMDocument();
  $data->appendChild($data->importNode(dom_import_simplexml($config), true));
  if ($xmlDoc) {
    $data->documentElement->appendChild($data->importNode($xmlDoc->documentElement, true));
  }
  //print_r($data->saveXML());
  $xsl = simplexml_load_file($templatePath);
  $proc = new XSLTProcessor();
  $proc->importStylesheet($xsl);
  return $proc->transformToXML($data);
}

function run($config, $templatePath, $pathToData = NULL) {
  if ($pathToData) {
    $xmlDoc = new DOMDocument();
    $xmlDoc->load($pathToData);
    echo applyTemplate($config, $templatePath, processAllQueries($xmlDoc));
  } else {
     echo applyTemplate($config, $templatePath);
  }
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
$templatePath = $route['template'];

if (!$templatePath) {
  $route = $config->xpath("/config/routes/route[@path='*']")[0];
  $templatePath = $route['template'];
}
$config->addChild('request_uri', $_SERVER['REQUEST_URI']);
$config->addChild('routeName', (string) $route);
$pathToData = $route['data'];
$output = ob_get_clean();
$config->addChild('debug', $output);

run($config, $templatePath, $pathToData);
