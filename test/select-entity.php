<?php
function flow($obj, $methods) {
  $res;
  array_walk($methods, function($param, $method) use (&$obj, &$res) {
    $res = $obj->{$method}($param);
  });
  return $res;
}

echo flow(new XSLTProcessor(), [
  'importStylesheet' => simplexml_load_file("../data/index.xsl"),
  'transformToXML' => simplexml_load_file('../config.xml')
]);

