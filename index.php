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

function applyTemplate($xmlDoc) {
  $data = new DOMDocument();
  $data->load("config.xml");
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
  //print_r($data->saveXML());
  return $proc->transformToXML($data);
}

function test() {
  $xmlDoc = new DOMDocument();
  $xmlDoc->load("data.xml");
  echo applyTemplate(processAllQueries($xmlDoc));
}

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

test();
