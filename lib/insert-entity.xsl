<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:data="data" version="1.0">

  <xsl:template match="col" mode="insert">
    <xsl:value-of select="."/>
    <xsl:if test="position() != last()">
      <xsl:text>,</xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template match="table" mode="insert">
    <xsl:param name="name"/>
    <xsl:param name="values"/>
    <xsl:param name="cols"/>

    <data:insert>
    <xsl:text>
INSERT INTO </xsl:text><xsl:value-of select="@name"/>
    <xsl:if test="$cols">
      (<xsl:value-of select="$cols"/>)
    </xsl:if>
    <xsl:if test="not($cols)">
      (
        <xsl:apply-templates select="col" mode="insert"/>
      )
    </xsl:if>
    VALUES
    <xsl:value-of select="$values"/>;
    </data:insert>
  </xsl:template>

  <xsl:template name="insert-entity">
    <xsl:param name="name"/>
    <xsl:param name="cols"/>
    <xsl:param name="values"/>
    <xsl:apply-templates select="/config/db/table[@name=$name]" mode="insert">
      <xsl:with-param name="name" select="$name"/>
      <xsl:with-param name="values" select="$values"/>
      <xsl:with-param name="cols" select="$cols"/>
    </xsl:apply-templates>
  </xsl:template>

</xsl:stylesheet>