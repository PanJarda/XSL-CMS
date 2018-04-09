<?php
$name = 'academic_position';

function xmlEntity2sql($entityName, $limit = NULL) {
  $schema = new DOMDocument();
  $schema->load('../db_schema.xml');
  $xsl = simplexml_load_file("../lib/select-table.xsl");

  $xpath = new DOMXPath($schema);
  $table = new DOMDocument();
  $table->appendChild($table->importNode($xpath->query('//table[@name="'.$entityName.'"]')[0], true));

  $proc = new XSLTProcessor();
  $proc->importStylesheet($xsl);
  return $proc->transformToXML($table) . ($limit ? ' LIMIT ' . $limit : '');
}

echo xmlEntity2sql($name);
