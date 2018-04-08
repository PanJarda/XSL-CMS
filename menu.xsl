<xsl:template match="/menu">
<menu>
  <xsl:foreach select="menuitem">
    <a href="<xsl:value-of select="@href" />"><xsl:value-of select="." /></a> 
  </xsl:foreach>
</menu>
</xsl:template>