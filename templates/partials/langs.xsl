<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:template match="lang">
    <li><xsl:value-of select="name"/></li>
  </xsl:template>

  <xsl:template match="langs">
    <ul>
      <xsl:apply-templates select="lang"/>
    </ul>
  </xsl:template>

</xsl:stylesheet>