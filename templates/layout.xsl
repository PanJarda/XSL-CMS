<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href="partials/routes.xsl"/>

  <xsl:template match="/config">
    <html>
      <head>
        <title><xsl:value-of select="routeName"/> - <xsl:value-of select="brand"/></title>
      </head>
      <body>
        <pre>
          <xsl:value-of select="debug"/>
        </pre>
        <h1><xsl:value-of select="routeName"/></h1>
        <xsl:apply-templates select="routes"/>
        <xsl:call-template name="main"/>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>