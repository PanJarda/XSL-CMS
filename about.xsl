<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="html" />
  <xsl:include href="{layout/@href}"/>
  <xsl:include href="partials/academic_positions.xsl"/>
  <xsl:include href="partials/bio.xsl"/>
  
  <xsl:template name="style">
  </xsl:template>

  <xsl:template name="main">
    <xsl:apply-templates select="bio"/>
    <xsl:apply-templates select="academic_positions"/>
  </xsl:template>

</xsl:stylesheet>