<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href="../lib/select-entity.xsl"/>

  <xsl:template match="config">
    <user_found>
      <query>
        <xsl:call-template name="select-entity">
          <xsl:with-param name="name">user</xsl:with-param>
          <xsl:with-param name="where">session = <xsl:value-of select="get[@cookie]"/> AND group = 'admin'</xsl:with-param>
          <xsl:with-param name="cols">count(*)</xsl:with-param>
        </xsl:call-template>
      </query>
    </user_found>
  </xsl:template>

  <xsl:template match="user_found">
    <query>
      <xsl:call-template name="select-entity">
        <xsl:with-param name="name">product</xsl:with-param>
        <xsl:with-param name="where">name = <xsl:value-of select="config/get[@name='product_id']"/></xsl:with-param>
      </xsl:call-template>
    </query>
  </xsl:template>

  <xsl:template match="/">
    <xsl:copy-of select="."/>
    <xsl:apply-templates/>
  </xsl:template>

</xsl:stylesheet>