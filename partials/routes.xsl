<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"> 
  <xsl:template match="route">
    <li><a href="{@href}"><xsl:value-of select="."/></a></li>
  </xsl:template>

  <xsl:template match="routes">
    <nav>
      <ul>
        <xsl:apply-templates select="route">
          <xsl:sort select="@priority" data-type="number" order="descending"/>
        </xsl:apply-templates>
      </ul>
    </nav>
  </xsl:template>
</xsl:stylesheet>