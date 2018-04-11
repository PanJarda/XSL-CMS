<?php
$proc = new XSLTProcessor();

$proc->importStylesheet(
  simplexml_load_file("../lib/create-db.xsl"));

echo $proc->transformToXML(
  simplexml_load_file('../config.xml'));