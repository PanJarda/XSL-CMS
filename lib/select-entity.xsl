<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:template match="many-to-many">
    LEFT JOIN `<xsl:value-of select="../@name"/>_x_<xsl:value-of select="@table"/>`
    ON id = `<xsl:value-of select="../@name"/>_x_<xsl:value-of select="@table"/>.<xsl:value-of select="../@name"/>_id
  </xsl:template>

  <xsl:template match="many-to-one">
    LEFT JOIN <xsl:value-of select="@table"/>
    ON <xsl:value-of select="@table"/>_id = <xsl:value-of select="@table"/>.id
  </xsl:template>

  <xsl:template match="table">
    <xsl:param name="name"/>
    <xsl:param name="cols"/>
    <xsl:param name="limit"/>
    <xsl:param name="where"/>
    <xsl:param name="orderby"/>
    <xsl:param name="groupby"/>
    <xsl:param name="nojoin"/>

    <row name="{$name}"/>
    <xsl:text>
SELECT </xsl:text>
    <xsl:value-of select="$cols"/>
    <xsl:if test="not($cols)">*</xsl:if>
      <xsl:text> FROM </xsl:text>`<xsl:value-of select="@name"/><xsl:text>`</xsl:text>
    <xsl:if test="not($nojoin)">
      <xsl:apply-templates select="many-to-one"/>
      <xsl:apply-templates select="many-to-many"/>
    </xsl:if>
    <xsl:if test="$where">
      <xsl:text> WHERE </xsl:text><xsl:value-of select="$where"/>
    </xsl:if>
    <xsl:if test="$limit">
      <xsl:text> LIMIT </xsl:text><xsl:value-of select="$limit"/>
    </xsl:if>
    <xsl:text>;</xsl:text>
  </xsl:template>

  <xsl:template name="select-entity">
    <xsl:param name="name"/>
    <xsl:param name="cols"/>
    <xsl:param name="limit"/>
    <xsl:param name="where"/>
    <xsl:param name="orderby"/>
    <xsl:param name="groupby"/>
    <xsl:param name="nojoin"/>
    <xsl:apply-templates select="/config/db/table[@name=$name]">
      <xsl:with-param name="name" select="$name"/>
      <xsl:with-param name="cols" select="$cols"/>
      <xsl:with-param name="limit" select="$limit"/>
      <xsl:with-param name="where" select="$where"/>
      <xsl:with-param name="orderby" select="$orderby"/>
      <xsl:with-param name="groupby" select="$groupby"/>
      <xsl:with-param name="nojoin" select="$nojoin"/>
    </xsl:apply-templates>
  </xsl:template>

</xsl:stylesheet>