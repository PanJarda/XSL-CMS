<?php
$proc = new XSLTProcessor();

$proc->importStylesheet(
  simplexml_load_file("../lib/gen-db.xsl"));
if ($argv[1] == '--drop') {
  $proc->setParameter('', 'drop', '1');
}
echo $proc->transformToXML(
  simplexml_load_file('../config.xml'));