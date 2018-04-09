<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="text" indent="no"/>
  <xsl:key name="id" match="col" use="@id"/>

  <xsl:template match="table">
    SELECT
    <xsl:for-each select="col[not(@hide)]">
      `<xsl:value-of select="." />`<xsl:if test="position() != last()">,</xsl:if>
    </xsl:for-each>
    FROM
    `<xsl:value-of select="@name" />`
    <xsl:if test="@groupby">
      GROUP BY `<xsl:value-of select="key('id', @groupby)" />`
    </xsl:if>
    <xsl:if test="@orderby">
      ORDER BY `<xsl:value-of select="key('id', @orderby)" />`
    </xsl:if>
    <xsl:if test="@limit">LIMT <xsl:value-of select="@limit" /></xsl:if>
  </xsl:template>

  <xsl:apply-templates />
</xsl:stylesheet>