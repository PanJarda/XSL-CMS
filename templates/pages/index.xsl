<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:include href="../layout.xsl"/>
  <xsl:include href="../partials/langs.xsl"/>

  <xsl:template name="main">
    <xsl:apply-templates select="langs"/>
  </xsl:template>

</xsl:stylesheet>