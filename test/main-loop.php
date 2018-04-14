<?php

function getRoute($config) {
  if (!($route = $config->xpath("/config/routes/route[@path='". $_SERVER['REQUEST_URI'] . "']")[0])) {
    return $config->xpath("/config/routes/route[@path='*']")[0];
  }
  return $route;
}

/*
 * main programm philosophy
 */
$config = simplexml_load_file("config.xml");
$GLOBALS['connection'] = new mysqli(
  $config->db['server'],
  $config->db['username'],
  $config->db['password']);
$GLOBALS['connection']->select_db($config->db['name']);

if ($GLOBALS['connection']->connect_error) {
    die("Connection failed: " . $GLOBALS['connection']->connect_error);
}

$route = getRoute($config);
$templatePath = $route['template'] != NULL ? $route['template'] : $route->xpath("..")[0]['template'];

resolve_route()

add_request_params($xml);

while($xml->query) {
  replaceAllQueriesWithResults($xml);
}

echo render($xml, $template);
