<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:include href="position.xsl"/>

  <xsl:template match="academic_positions">
    <h2><xsl:value-of select="headline"/></h2>
    <ul>
      <xsl:apply-templates select="position">
        <xsl:sort select="start_year" data-type="number" order="descending"/>
      </xsl:apply-templates>
    </ul>
  </xsl:template>
</xsl:stylesheet>