<?php
$name = 'education';
$limit = 10;
$where = 'langId';
$equals = 1;

function xmlEntity2sql($name, $limit, $where, $equals) {
  $xsl = simplexml_load_file("../lib/select-entity.xsl");

  $config = simplexml_load_file('../config.xml');
  
  $proc = new XSLTProcessor();
  $proc->setParameter('', 'name', $name);
  $proc->setParameter('', 'limit', $limit);
  $proc->setParameter('', 'where', $where);
  $proc->setParameter('', 'equals', $equals);
  $proc->importStylesheet($xsl);
  return $proc->transformToXML($config);
}

echo xmlEntity2sql($name, $limit, $where, $equals);
