<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="text" indent="no"/>
  <xsl:key name="id" match="col" use="@id"/>
  <xsl:key name="equals" match="col" use="@equals"/>
  
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

  <xsl:template match="col">
    `<xsl:call-template name="alias"/>.<xsl:value-of select="." />`<xsl:if test="@as"> AS `<xsl:value-of select="@as" />`</xsl:if>
  </xsl:template>

  <xsl:template match="select">
    SELECT
    <xsl:for-each select="count">
      count(`<xsl:call-template name="alias" />.<xsl:value-of select="." />`)<xsl:if test="@as"> AS `<xsl:value-of select="@as" />`</xsl:if>
      <xsl:if test="position() != last()">,</xsl:if>
    </xsl:for-each>
    <xsl:for-each select="col[not(@hide)]">
      <xsl:apply-templates select="."/><xsl:if test="position() != last()">,</xsl:if>
    </xsl:for-each>
    <xsl:for-each select="leftjoin">
      <xsl:if test="position() != last() and count(col[not(@hide)]) &gt; 0">,</xsl:if>
      <xsl:for-each select="col[not(@hide)]">
        <xsl:apply-templates select="."/><xsl:if test="position() != last()">,</xsl:if>
      </xsl:for-each>
    </xsl:for-each>
    FROM
    `<xsl:value-of select="@name" />`<xsl:if test="@as"> AS `<xsl:value-of select="@as" />`</xsl:if>
    <xsl:if test="leftjoin">
      <xsl:for-each select="leftjoin">
      LEFT JOIN `<xsl:value-of select="@name" />`<xsl:if test="@as"> AS `<xsl:value-of select="@as" />`</xsl:if>
        ON `<xsl:call-template name="alias">
              <xsl:with-param name="as" select="@as"/>
              <xsl:with-param name="name" select="@name"/>
            </xsl:call-template>.<xsl:value-of select="col[@on]" />` = `<xsl:call-template name="alias">
                                                                      <xsl:with-param name="as" select="key('id', col[@on]/@on)/../@as"/>
                                                                      <xsl:with-param name="name" select="key('id', col[@on]/@on)/../@name"/>
                                                                    </xsl:call-template>.<xsl:value-of select="key('id', col[@on]/@on)" />`</xsl:for-each>
    </xsl:if>
    <xsl:if test="./*/col[@equals]">
      WHERE <xsl:for-each select="//col[@equals]">`<xsl:call-template name="alias"/>.<xsl:value-of select="." />` = '<xsl:value-of select="@equals" />' <xsl:if test="position() != last()">AND </xsl:if></xsl:for-each>
    </xsl:if>
    <xsl:if test="@groupby">
      GROUP BY `<xsl:call-template name="alias">
                  <xsl:with-param name="as" select="key('id', @groupby)/../@as"/>
                  <xsl:with-param name="name" select="key('id', @groupby)/../@name"/>
                </xsl:call-template>.<xsl:value-of select="key('id', @groupby)" />`
    </xsl:if>
    <xsl:if test="@orderby">
      ORDER BY `<xsl:call-template name="alias">
                  <xsl:with-param name="as" select="key('id', @orderby)/../@as"/>
                  <xsl:with-param name="name" select="key('id', @orderby)/../@name"/>
                </xsl:call-template>.<xsl:value-of select="key('id', @orderby)" />`
    </xsl:if>
    <xsl:if test="@limit">LIMT <xsl:value-of select="@limit" />
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>