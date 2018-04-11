<?php
$proc = new XSLTProcessor();

$proc->importStylesheet(
  simplexml_load_file("../lib/gen-db.xsl"));

print_r($proc->hasExsltSupport());
echo $proc->transformToXML(
  simplexml_load_file('../config.xml'));