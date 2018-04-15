<?php
function flow(&$obj, $methods) {
  $res;
  array_walk(
    $methods,
    function($params, $method) use (&$obj, &$res) {
      call_user_func_array(
        [$obj, $method],
        $params);});
  return $obj;
}

function assoc2XML($result_assoc, $tableName = 'table', $rowName = 'item') {
  $xml = new SimpleXMLElement('<' . $tableName . '/>');
  foreach ($result_assoc as $row) {
    $item = $xml->addChild($rowName);
    foreach ($row as $key => $value) {
      $item->addChild($key, $value);
    }
  }
  return $xml;
}

function sqlQuery($query) {
  $result = $GLOBALS['connection']->query($query);
  return $result ? $result->fetch_all(MYSQLI_ASSOC) : $GLOBALS['connection']->error;
}

function processSelects($queries, &$doc) {
  foreach ($queries as $q) {
    $result = assoc2XML(
                sqlQuery($q->nodeValue),
                'table',
                $q->firstChild->attributes['name']->value);
    $ch = dom_import_simplexml($result)->childNodes;
    for ($j = 0; $j < $ch->length; $j++) {
      $q->parentNode->appendChild($doc->importNode($ch->item($j), true));
    }
    $q->parentNode->removeChild($q);
  }
  return $doc;
}

function processInserts($queries, &$doc) {
  foreach ($queries as $q) {
    $result = $GLOBALS['connection']->query($q->nodeValue);
    $q->parentNode->removeChild($q);
  }
  return $doc;
}

function processJSONs($queries, &$doc) {
  foreach ($queries as $q) {
    $json = file_get_contents($q->attributes['href']->nodeValue);
    $result = assoc2xml(json_decode($json), 'table', 'coin');
    $ch = dom_import_simplexml($result)->childNodes;
    for ($j = 0; $j < $ch->length; $j++) {
      $q->parentNode->appendChild($doc->importNode($ch->item($j), true));
    }
    $q->parentNode->removeChild($q);
  }
  return $doc;
}

$config = simplexml_load_file("config.xml");
$servername = $config->db['server'];
$username = $config->db['username'];
$password = $config->db['password'];
$db=  $config->db['name'];
$conn = new mysqli($servername, $username, $password);
$GLOBALS['connection'] = $conn;
$GLOBALS['connection']->set_charset('utf8');
$GLOBALS['connection']->select_db($db);

if ($GLOBALS['connection']->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
// routing
$route = $config->xpath("/config/routes/route[@path='". parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH) . "']")[0];
if (!$route) {
  $route = $config->xpath("/config/routes/route[@path='*']")[0];
}

$templatePath = $route['template'] != NULL ? $route['template'] : $route->xpath("..")[0]['template'];

$config->addChild('request_uri', parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH));

$config->addChild('routeName', (string) $route);

foreach($_POST as $key => $val) {
  if (is_array($val)) {
    foreach($val as $v) {
      $tmp = $config->addChild('post', (string) $v);
      $tmp->addAttribute('name', (string) $key);
    }
  } else {
    $tmp = $config->addChild('post', (string) $val);
    $tmp->addAttribute('name', (string) $key);
  }
}

foreach($_GET as $key => $val) {
  if (is_array($val)) {
    foreach($val as $v) {
      $tmp = $config->addChild('get', $GLOBALS['connection']->real_escape_string(htmlspecialchars((string) $v)));
      $tmp->addAttribute('name', $GLOBALS['connection']->real_escape_string(htmlspecialchars((string) $key)));
    }
  } else {
    $tmp = $config->addChild('get', $GLOBALS['connection']->real_escape_string(htmlspecialchars((string) $val)));
    $tmp->addAttribute('name', $GLOBALS['connection']->real_escape_string(htmlspecialchars((string) $key)));
  }
}

$pathToData = $route['data'];

$processor = flow((new XSLTProcessor()), [
  'importStylesheet' => [simplexml_load_file($pathToData)]
]);

$data = $processor->transformToDoc($config);

$selects = $data->getElementsByTagNameNS('data', 'select');
$inserts = $data->getElementsByTagNameNS('data', 'insert');
$jsons = $data->getElementsByTagNameNS('data', 'json');
while ($selects->length || $inserts->length || $jsons->length) {
  processSelects($selects, $data);
  processInserts($inserts, $data);
  processJSONs($jsons, $data);
  $data = $processor->transformToDoc($data);
  $selects = $data->getElementsByTagNameNS('data', 'select');
  $inserts = $data->getElementsByTagNameNS('data', 'insert');
  $jsons = $data->getElementsByTagNameNS('data', 'json');
}

//print_r($data->saveXML());
$processor->importStylesheet(simplexml_load_file((string) $templatePath));
echo $processor->transformToXML($data);
