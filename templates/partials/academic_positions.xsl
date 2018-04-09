<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="position">
    <li>
      <xsl:value-of select="start_year"/> - <xsl:value-of select="end_year"/><br/>
      <strong><xsl:value-of select="name"/></strong><br/>
      <i><xsl:value-of select="university"/></i><br/>
      <xsl:value-of select="department"/>
    </li>
  </xsl:template>

  <xsl:template match="academic_positions">
    <h2><xsl:value-of select="headline"/></h2>
    <ul>
      <xsl:apply-templates select="position">
        <xsl:sort select="start_year" data-type="number" order="descending"/>
      </xsl:apply-templates>
    </ul>
  </xsl:template>
</xsl:stylesheet>