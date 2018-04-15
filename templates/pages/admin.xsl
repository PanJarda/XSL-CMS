<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:include href="../layout.xsl"/>

  <xsl:template match="many-to-one">
      <th><xsl:value-of select="@table"/>Id</th><xsl:apply-templates select="../../*[@name = current()/@table]/col|../../*[@name = current()/@table]/many-to-one"/>
  </xsl:template>

  <xsl:template match="col">
      <th><xsl:value-of select="."/></th>
  </xsl:template>

  <xsl:template match="table">
    <table>
      <caption><xsl:value-of select="@name"/></caption>
      <tr><th>id</th><xsl:apply-templates select="col|many-to-one"/></tr>
      <xsl:for-each select="/*[local-name()=current()/@name]">
        <tr>
          <xsl:for-each select="*">
            <td>
              <xsl:value-of select="."/>
            </td>
          </xsl:for-each>
        </tr>
      </xsl:for-each>
    </table>
  </xsl:template>

  <xsl:template match="db">
    <xsl:apply-templates select="table"/>
  </xsl:template>

  <xsl:template name="main">
    <xsl:apply-templates select="config/db"/>
  </xsl:template>

</xsl:stylesheet>