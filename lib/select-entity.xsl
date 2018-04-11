<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="text" indent="no"/>
  <xsl:param name="name"/>
  <xsl:param name="cols"/>
  <xsl:param name="limit"/>
  <xsl:param name="where"/>
  <xsl:param name="orderby"/>
  <xsl:param name="groupby"/>
  <xsl:param name="nojoin"/>

  <xsl:template match="@many-to-many">
    <!-- todo handle junction table -->
  </xsl:template>

  <xsl:template match="@many-to-one">
    LEFT JOIN <xsl:value-of select="."/>
    ON <xsl:value-of select="."/>.id = <xsl:value-of select="../../@name"/>.id
  </xsl:template>

  <xsl:template match="table">
    SELECT
    <xsl:value-of select="$cols"/>
    <xsl:if test="not($cols)">
      *
    </xsl:if>
    FROM `<xsl:value-of select="@name"/>`
    <xsl:if test="not($nojoin)">
      <xsl:apply-templates select="col/@many-to-one"/>
    <xsl:if>
    <xsl:if test="$where">
      WHERE <xsl:value-of select="$where"/>
    </xsl:if>
    <xsl:if test="$limit">
      LIMIT <xsl:value-of select="$limit"/>
    </xsl:if>
    ;
  </xsl:template>

  <xsl:template match="/">
    <xsl:apply-templates select="//db/table[@name=$name]"/>
  </xsl:template>

</xsl:stylesheet>