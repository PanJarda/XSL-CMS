<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">  
  <xsl:template match="position">
    <li>
      <xsl:value-of select="start_year"/> - <xsl:value-of select="end_year"/><br/>
      <strong><xsl:value-of select="name"/></strong><br/>
      <i><xsl:value-of select="university"/></i><br/>
      <xsl:value-of select="department"/>
    </li>
  </xsl:template>
</xsl:stylesheet>