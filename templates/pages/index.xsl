<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:include href="../layout.xsl"/>
  <xsl:decimal-format name="cesky"
     decimal-separator=","
     grouping-separator="."/>

  <xsl:template match="coin" mode="coin">
    <tr>
      <td><input type="checkbox" name="delete[]" value="{id}"/></td>
      <td><xsl:value-of select="name"/></td>
      <td align="right"><xsl:value-of select="format-number(price_czk, '#.###,## Kč', 'cesky')"/></td>
      <td align="right"><xsl:value-of select="format-number(amount, '#.###,##', 'cesky')"/></td>
      <td align="right"><xsl:value-of select="format-number(portfolio, '#.###,## Kč', 'cesky')"/></td>
    </tr>
  </xsl:template>

  <xsl:template match="portfolio_result">
    <form action="/" method="post">
      <fieldset>
      <legend>Coins</legend>
      <table>
        <thead>
          <tr>
            <th></th>
            <th>id</th>
            <th align="right">price for 1</th>
            <th align="right">amount</th>
            <th align="right">sum</th>
          </tr>
        </thead>
          <xsl:apply-templates select="coin" mode="coin"/>
        <tfoot>
          <tr>
            <td></td>
            <td>sum:</td>
            <td></td>
            <td></td>
            <td><xsl:value-of select="format-number(sum(coin/portfolio), '#.###,## Kč', 'cesky')"/></td>
          </tr>
        </tfoot>
      </table>
      <input type="submit" value="Delete"/>
      </fieldset>
    </form>
  </xsl:template>

  <xsl:template match="get">
    <xsl:value-of select="@name"/><xsl:text> - </xsl:text>
    <xsl:value-of select="."/><br/>
  </xsl:template>

  <xsl:template name="main">
    <xsl:apply-templates select="portfolio_result"/>
    <xsl:apply-templates select="config/get"/>
    <xsl:value-of select="description"/>
    <xsl:if test="insert">
      <form action="/" method="post">
        <fieldset>
          <legend>Add coin</legend>
          <table>
            <tr>
              <td><label for="id">coin</label></td>
              <td><input type="text" name="id" id="id"/></td>
            </tr>
            <tr>
              <td><label for="amount">Amount</label></td>
              <td><input type="number" step="0.001" name="amount" id="amount"/></td>
            </tr>
          </table>
          <input type="submit"/>
        </fieldset>
      </form>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>