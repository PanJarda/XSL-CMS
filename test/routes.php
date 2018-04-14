<?php
function flow($obj, $methods) {
  $res;
  array_walk($methods, function($params, $method) use (&$obj, &$res) {
    $res = call_user_func_array([$obj, $method], $params);
  });
  return $res;
}

echo fluent(new XSLTProcessor(), [
  'importStylesheet' => [simplexml_load_file("../lib/route.xsl")],
  'setParameter' => ['', 'path', '/admin/ahoj'],
  'transformToXML' => [simplexml_load_file('../config.xml')]
]);

