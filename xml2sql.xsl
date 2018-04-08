<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="text"/>
  <xsl:key name="id" match="col" use="@id"/>
  <xsl:key name="equals" match="col" use="@equals"/>
  <xsl:template match="col">
    `<xsl:value-of select="../@name" />.<xsl:value-of select="text()" />`<xsl:if test="@as"> AS `<xsl:value-of select="@as" />`</xsl:if>
  </xsl:template>
  <xsl:template match="table">
    SELECT
    <xsl:for-each select="col">
      <xsl:apply-templates select="."/><xsl:if test="position() != last()">,</xsl:if>
    </xsl:for-each>
    <xsl:if test="leftjoin">,</xsl:if>
    <xsl:for-each select="leftjoin">
      <xsl:for-each select="col">
        `<xsl:value-of select="../@name" />.<xsl:value-of select="text()"/>`<xsl:if test="position() != last()">,</xsl:if>
      </xsl:for-each>
      <xsl:if test="position() != last()">,</xsl:if>
    </xsl:for-each>
    FROM
    `<xsl:value-of select="@name" />`<xsl:if test="@as"> AS `<xsl:value-of select="@as" />`</xsl:if>
    <xsl:if test="leftjoin">
      <xsl:for-each select="leftjoin">
      LEFT JOIN `<xsl:value-of select="@name" />`
        ON `<xsl:value-of select="@name" />.<xsl:value-of select="col[@on]" />` = `<xsl:value-of select="key('id', col[@on]/@on)/../@name" />.<xsl:value-of select="key('id', col[@on]/@on)" />`</xsl:for-each>
    </xsl:if>
    <xsl:if test="./*/col[@equals]">
      WHERE <xsl:for-each select="//col[@equals]">`<xsl:value-of select="../@name" />.<xsl:value-of select="text()" />` = '<xsl:value-of select="@equals" />' <xsl:if test="position() != last()">AND </xsl:if></xsl:for-each>
    </xsl:if>
    <xsl:if test="@groupby">
      GROUP BY `<xsl:value-of select="key('id', @groupby)/../@name" />.<xsl:value-of select="key('id', @groupby)" />`
    </xsl:if>
    <xsl:if test="@orderby">
      ORDER BY `<xsl:value-of select="key('id', @orderby)/../@name" />.<xsl:value-of select="key('id', @orderby)" />`
    </xsl:if>
    <xsl:if test="@limit">LIMT <xsl:value-of select="@limit" />
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>