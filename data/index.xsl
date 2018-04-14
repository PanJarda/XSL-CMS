<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:data="data" version="1.0">
  <xsl:import href="../lib/select-entity.xsl"/>

  <xsl:template match="config">
    <xsl:if test="not(../user_found)">
      <user_found>
        <data:query>
          <xsl:call-template name="select-entity">
            <xsl:with-param name="name">lang</xsl:with-param>
          </xsl:call-template>
        </data:query>
      </user_found>
    </xsl:if>
  </xsl:template>

  <xsl:template match="user_found">
    <xsl:if test="not(../langs)">
      <langs>
        <data:query>
          <xsl:call-template name="select-entity">
            <xsl:with-param name="name">lang</xsl:with-param>
          </xsl:call-template>
        </data:query>
      </langs>
    </xsl:if>
  </xsl:template>

  <xsl:template match="/">
    <xsl:copy-of select="."/>
    <xsl:apply-templates />
  </xsl:template>

</xsl:stylesheet>