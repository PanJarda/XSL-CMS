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

funciton appendXML($root, $child) {

}

function processQuery($queryXML) {

  return $simpleXMLElement;
}

function processAllQueries($xml) {
  return $outputXMLData;
}

function applyXSLT($data) {
  // find xslt template and process;
  return html;
}

//...................................................
$config = simplexml_load_file("config.xml");
$servername = $config->db['server'];
$username = $config->db['username'];
$password = $config->db['password'];
$db=  $config->db['database'];
$connection = new mysqli($servername, $username, $password);
$connection->select_db($db);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$query = 'SELECT * FROM academic_positions';
$result = $connection->query($query);
$result_assoc = $result->fetch_all(MYSQLI_ASSOC);
mergeXML([assoc2XML($result_assoc, 'academic_positions', 'position')], 'data');

$data = simplexml_load_file("data.xml");

$xsl = simplexml_load_file("About.xsl");

$proc = new XSLTProcessor();
$proc->importStylesheet($xsl);
echo $proc->transformToXML($data);
