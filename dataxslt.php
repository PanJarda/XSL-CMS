<?php
$schemaXML = '<data>
  <table name="articles" limit="10" orderby="published">
    <col as="title">Title</col>
    <col equals="Ahoj">Content</col>
    <col id="published">Published</col>
    <col id="userId" hide="true">UserId</col>
    <col id="categoryId" hide="true">CategoryId</col>
    <leftjoin name="users">
      <col on="userId">id</col>
      <col>Name</col>
    </leftjoin>
    <leftjoin name="categories">
      <col on="categoryId" hide="true">id</col>
      <col equals="research" hide="true">Name</col>
    </leftjoin>
  </table>
</data>';

$schema = simplexml_load_string($schemaXML);

$xslDoc = simplexml_load_file("xml2sql.xsl");

$proc = new XSLTProcessor();
$proc->importStylesheet($xslDoc);
echo $proc->transformToXML($schema);
