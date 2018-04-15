<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:data="data" version="1.0">
  <xsl:include href="../lib/select-entity.xsl"/>

  <xsl:template match="table" mode="admin">
    <xsl:call-template name="select-entity">
      <xsl:with-param name="name" select="@name"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="/">
    <xsl:copy-of select="."/>
    
    <xsl:if test="not(selected)">
      <selected></selected>
      <xsl:apply-templates select="config/db/table" mode="admin"/>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>