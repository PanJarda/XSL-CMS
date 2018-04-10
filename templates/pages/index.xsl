<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:include href="../layout.xsl"/>
  <xsl:include href="../partials/academic_positions.xsl"/>
  <xsl:include href="../partials/bio.xsl"/>
  
  <xsl:template name="main">
    <xsl:value-of select="(data/description)[last()]"/>
    <xsl:apply-templates select="data/bio"/>
    <xsl:apply-templates select="data/academic_positions"/>
  </xsl:template>

</xsl:stylesheet>