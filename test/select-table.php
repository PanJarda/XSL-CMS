<?php
$name = 'academic_position';

function xmlEntity2sql($entityName, $limit = NULL) {
  $xsl = simplexml_load_file("../lib/select-table.xsl");

  $table = simplexml_load_file('../db_schema.xml')
            ->xpath("//table[@name='$entityName'][1]")[0];
  
  $proc = new XSLTProcessor();
  $proc->importStylesheet($xsl);
  return $proc->transformToXML(simplexml_load_string($table->asXML())) . ($limit ? ' LIMIT ' . $limit : '');
}

echo xmlEntity2sql($name);
