<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <html>
		<head>
			<head>
				<link rel="stylesheet" type="text/css" href="cart.css"/>
			</head>
			<title>Cart</title>
		</head>
      <body>
        <table border="1">
          <tr>
            <th>Name</th>
            <th>Father's Name</th>
            <th>Mother's Name</th>
          </tr>
          <xsl:for-each select="FamilyTree/Person">
            <tr>
              <td><xsl:value-of select="concat(FirstName, ' ', LastName)"/></td>
              <td>
                <xsl:choose>
                  <xsl:when test="Father">
                    <xsl:value-of select="Father"/>
                  </xsl:when>
                  <xsl:otherwise>Unknown</xsl:otherwise>
                </xsl:choose>
              </td>
              <td>
                <xsl:choose>
                  <xsl:when test="Mother">
                    <xsl:value-of select="Mother"/>
                  </xsl:when>
                  <xsl:otherwise>Unknown</xsl:otherwise>
                </xsl:choose>
              </td>
            </tr>
          </xsl:for-each>
        </table>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
