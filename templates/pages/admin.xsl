<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  
  <xsl:template match="col">
    <td><xsl:value-of select="name"/></td>
  </xsl:col>

  <xsl:template match="row">
    <tr><xsl:template match="col"></tr>
  </xsl:template>

  <xsl:template match="table">
    <table>
      <apply-template match="row"/>
    </table>
  </xsl:template>

  <xsl:template match="db">
    <xsl:template match="table"/>
  </xsl:stylesheet>

  <xsl:apply-templates match="/data/db"/>

</xsl:stylesheet>