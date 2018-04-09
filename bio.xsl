<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"> 
  <xsl:template match="bio">
    <h2><xsl:value-of select="headline"/></h2>
    <img width="200" src="{photo/@src}"/>
    <p><xsl:value-of select="content"/></p>
  </xsl:template>
</xsl:stylesheet>