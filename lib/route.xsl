<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:param name="path"/>

  <xsl:template name="tokenize">
    <xsl:param name="path"/>
    <xsl:param name="template"/>
    

    <xsl:if test="substring-after($template, '/') and substring-before($template, '/')=substring-before($path, '/') or starts-with(substring-before($template, '/'), ':')">
      <xsl:value-of select="substring-before($template, '/')"/>=<xsl:value-of select="substring-before($path, '/')"/>
      <xsl:text>
      </xsl:text>
      <xsl:call-template name="tokenize">
        <xsl:with-param name="path" select="substring-after($path, '/')"/>
        <xsl:with-param name="template" select="substring-after($template, '/')"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="">
    </xsl:if>

  </xsl:template>

  <xsl:template match="route">
    <xsl:call-template name="tokenize">
      <xsl:with-param name="path" select="substring-after($path, '/')"/>
      <xsl:with-param name="template" select="substring-after(@path, '/')"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="/">
    <xsl:apply-templates select="config/routes/route"/>
  </xsl:template>

</xsl:stylesheet>