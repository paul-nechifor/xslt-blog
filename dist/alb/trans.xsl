<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>

    <xsl:template match="/jurnal">
        <html>
            <head>
                <title><xsl:value-of select="/jurnal/info/titlu"/></title>
                <link href="http://fonts.googleapis.com/css?family=Cardo" rel="stylesheet" type="text/css"/>
                <link href="http://fonts.googleapis.com/css?family=Old+Standard+TT" rel="stylesheet" type="text/css"/>
                <link href="stil.css" rel="stylesheet" type="text/css"/>
            </head>
            <body>
                <div class="antet">
                    <h1><a href="#"><xsl:value-of select="/jurnal/info/titlu"/></a></h1>
                    <p class="descriere"><xsl:value-of select="/jurnal/info/descriere"/></p>
                </div>

                <div class="mijloc">
                    <div class="cuprins">
                        <h2>Cuprins</h2>
                        <ul>
                            <xsl:for-each select="articol">
                                <li>
                                    <a href="#{@data}">
                                        <span class="titlu"><xsl:value-of select="@titlu"/></span>
                                        <span class="sterge">​</span>
                                        <span class="data">
                                            <xsl:call-template name="formatareData">
                                                <xsl:with-param name="data" select="@data"/>
                                            </xsl:call-template>
                                        </span>
                                    </a>
                                </li>
                            </xsl:for-each>
                        </ul>
                    </div>

                    <div class="articole">
                        <xsl:apply-templates/>
                    </div>
                </div>

                <div class="subsol">
                    <div class="separator"></div>
                    <div class="drepturi">
                        <p><xsl:value-of select="/jurnal/info/drepturi"/></p>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="info">
    </xsl:template>

    <!-- Articol -->
    <xsl:template match="articol">
        <div class="articol">
            <a name="{@data}"></a>
            <h2><xsl:value-of select="@titlu"/></h2>
            <p class="data">
                <xsl:call-template name="formatareData">
                    <xsl:with-param name="data" select="@data"/>
                </xsl:call-template>
            </p>

            <div class="text">
                <xsl:apply-templates/>
            </div>

            <xsl:if test=".//notă">
                <div class="separator"></div>
                <div class="textSubsol">
                    <xsl:for-each select=".//notă">
                        <xsl:variable name="număr">
                            <xsl:number level="any"/>
                        </xsl:variable>
                        <p>
                            <a href="#sursa{$număr}" name="nota{$număr}" title="Înapoi la sursă.">
                                <xsl:number level="any"/>
                            </a>.
                            <xsl:value-of select="."/>
                        </p>
                    </xsl:for-each>
                </div>
            </xsl:if>
        </div>
    </xsl:template>

    <xsl:template match="poezie">
        <div class="poezie">
            <h3>
                <a name="{@titlu}"></a>
                <xsl:value-of select="@titlu"/>
            </h3>
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <!-- Paragraf -->
    <xsl:template match="p">
        <p><xsl:apply-templates/></p>
    </xsl:template>

    <xsl:template match="strofă">
        <p class="strofa"><xsl:apply-templates/></p>
    </xsl:template>

    <xsl:template match="citat">
        <p class="citat"><xsl:apply-templates/></p>
    </xsl:template>

    <!-- Notă de subsol -->
    <xsl:template match="notă">
        <xsl:variable name="număr">
            <xsl:number level="any"/>
        </xsl:variable>
        <sup class="nota">
            <a href="#nota{$număr}" name="sursa{$număr}" title="Vezi nota de subsol.">(<xsl:value-of
            select="$număr"/>)</a>
        </sup>
    </xsl:template>

    <!-- Legături -->
    <xsl:template match="l">
        <a href="{@uri}"><xsl:apply-templates/></a>
    </xsl:template>

    <!-- Cursiv -->
    <xsl:template match="c">
        <em><xsl:apply-templates/></em>
    </xsl:template>

    <!-- Aldin -->
    <xsl:template match="a">
        <strong><xsl:apply-templates/></strong>
    </xsl:template>

    <!-- Nouă linie -->
    <xsl:template match="n">
        <br/>
    </xsl:template>

    <!-- Transformă din „2010-05-23“ în „23 mai 2010“. -->
    <xsl:template name="formatareData">
        <xsl:param name="data"/>
        <xsl:variable name="an">
            <xsl:value-of select="substring($data, 1, 4)"/>
        </xsl:variable>
        <xsl:variable name="luna">
            <xsl:value-of select="substring($data, 6, 2)"/>
        </xsl:variable>
        <xsl:variable name="zi">
            <xsl:value-of select="substring($data, 9, 2)"/>
        </xsl:variable>

        <xsl:choose>
            <xsl:when test="substring($zi, 1, 1) = '0'"><xsl:value-of select="substring($zi, 2, 1)"/></xsl:when>
            <xsl:otherwise><xsl:value-of select="$zi"/></xsl:otherwise>
        </xsl:choose>
        <xsl:value-of select="' '"/>
        <xsl:choose>
            <xsl:when test="$luna = '01'">ianuarie</xsl:when>
            <xsl:when test="$luna = '02'">februarie</xsl:when>
            <xsl:when test="$luna = '03'">martie</xsl:when>
            <xsl:when test="$luna = '04'">aprilie</xsl:when>
            <xsl:when test="$luna = '05'">mai</xsl:when>
            <xsl:when test="$luna = '06'">iunie</xsl:when>
            <xsl:when test="$luna = '07'">iulie</xsl:when>
            <xsl:when test="$luna = '08'">august</xsl:when>
            <xsl:when test="$luna = '09'">septembrie</xsl:when>
            <xsl:when test="$luna = '10'">octombrie</xsl:when>
            <xsl:when test="$luna = '11'">noiembrie</xsl:when>
            <xsl:when test="$luna = '12'">decembrie</xsl:when>
        </xsl:choose>
        <xsl:value-of select="' '"/>
        <xsl:value-of select="$an"/>
    </xsl:template>
</xsl:stylesheet>

