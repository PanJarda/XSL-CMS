<?php
$schema = simplexml_load_file("query.xml");

$xslDoc = simplexml_load_file("xml2sql.xsl");

$proc = new XSLTProcessor();
$proc->importStylesheet($xslDoc);
echo $proc->transformToXML($schema);
