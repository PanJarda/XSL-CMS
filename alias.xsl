<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template name="alias">
    <xsl:param name="as" select="../@as"/>
    <xsl:param name="name" select="../@name"/>
    <xsl:choose>
      <xsl:when test="$as">
        <xsl:value-of select="$as" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$name" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>