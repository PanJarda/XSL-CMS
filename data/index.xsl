<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:data="data" version="1.0">
  <xsl:include href="../lib/select-entity.xsl"/>
  <xsl:include href="../lib/insert-entity.xsl"/>

  <xsl:template match="post" mode="coin">
    '<xsl:value-of select="."/>'
    <xsl:if test="position() != last()">,</xsl:if>
  </xsl:template>

  <xsl:template match="post[@name='delete']" mode="delete">
    '<xsl:value-of select="."/>'
    <xsl:if test="position() != last()">,</xsl:if>
  </xsl:template>

  <xsl:template match="config[not(../insert)]">
    <delete>
      <xsl:if test="post[@name='delete']">
        <data:insert>
          DELETE FROM `coin` WHERE coinId in (<xsl:apply-templates select="post" mode="delete"/>);
        </data:insert>
      </xsl:if>
    </delete>
    <insert>
      <xsl:call-template name="insert-entity">
        <xsl:with-param name="name">coin</xsl:with-param>
        <xsl:with-param name="values">
          (<xsl:apply-templates select="post" mode="coin"/>)
        </xsl:with-param>
      </xsl:call-template>
    </insert>
  </xsl:template>

  <xsl:template match="insert[not(../coins)]">
    <coins>
      <data:json href="https://api.coinmarketcap.com/v1/ticker/?convert=CZK" rowname="coin"/>
    </coins>
    <portfolio>
      <xsl:call-template name="select-entity">
        <xsl:with-param name="name">coin</xsl:with-param>
      </xsl:call-template>
    </portfolio>
  </xsl:template>

  <xsl:template match="coin" mode="coin">
    <xsl:variable name="id" select="coinId" />
    <xsl:variable name="amount" select="amount" />
    <coin>
      <xsl:for-each select="/coins/coin[id=$id]">
        <xsl:copy-of select="./*"/>
        <amount><xsl:value-of select="$amount"/></amount>
        <portfolio><xsl:value-of select="floor(price_czk * $amount)"/></portfolio>
      </xsl:for-each>
    </coin>
  </xsl:template>

  <xsl:template match="portfolio">
    <portfolio_result>
      <xsl:apply-templates select="coin" mode="coin"/>
    </portfolio_result>
  </xsl:template>

  <xsl:template match="/">
    <xsl:copy-of select="."/>
    <xsl:apply-templates />
  </xsl:template>

</xsl:stylesheet>