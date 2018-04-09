<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href="partials/routes.xsl"/>

  <xsl:template match="/data">
    <html>
      <head>
        <title><xsl:value-of select="title"/> - <xsl:value-of select="brand"/></title>
        <xsl:call-template name="style"/>
      </head>
      <body>
        <h1><xsl:value-of select="title"/></h1>
        <xsl:apply-templates select="routes"/>
        <xsl:call-template name="main"/>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>