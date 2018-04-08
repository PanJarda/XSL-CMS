<?php

$data = [
  'articles' => [
    [
      'title' => 'AHoj',
      'content' => 'fassfafsfs',
      'published' => '1132312'
    ],
    [
      'title' => 'AHoj',
      'content' => 'fassfafsfs',
      'published' => '1132312'
    ]
  ]
];

$template = '
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="/">
    <html>
      <Header />
      <body>
        <xsl:include href="menu.xsl" />
        <ul>
          <xsl:for-each />
          </li>
        </ul>
        <Footer />
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>';

$xml = new SimpleXMLElement('<root/>');

array_walk_recursive($data, function($value, $key) use ($xml) {
  if (is_array($value)) {
    $xml->addChild($value);
  } else {
    $xml->addChild($key, $value);
  }
});
$dataXML =  $xml->asXML();

echo $dataXML;

?>
