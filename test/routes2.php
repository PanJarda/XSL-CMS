<?php

$config = simplexml_load_file("../config.xml");

$routes = $config->xpath('/config/routes/route');

array_walk($routes, function($r) {
  echo $r['path'];
});
