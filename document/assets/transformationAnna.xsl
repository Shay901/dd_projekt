<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.w3.org/1999/xhtml" exclude-result-prefixes="xs tei" version="1.0">
    <xsl:output method="xml" omit-xml-declaration="yes"
        doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
        doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>
    <xsl:template match="/">
        <html lang="sv" xml:lang="sv">
            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
                <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
                <link rel="stylesheet" type="text/css" href="assets/css/poemstyleAnna.css"/>
                <title>
                    <xsl:value-of select="//tei:monogr/tei:title"/>
                </title>
            </head>
            <body>
                <div>
                    <h1>
                        <xsl:apply-templates select="//tei:titleStmt/tei:title"/>
                    </h1>
                    <div class="intro">
                        <ul>
                            <li>En tillfällesdikt från <xsl:value-of select="//tei:pubPlace"
                            />, den <xsl:value-of select="//tei:imprint/tei:date"/>.</li>
                            <li>Dikten har <xsl:value-of select="count(//tei:lg[@type='mainpoem']/tei:lg/tei:l)"/> rader.</li>
                            <li>Författaren är <xsl:value-of select="//tei:author"/>.</li>
                            <li>Transkriberad och kodad av <xsl:value-of
                                    select="//tei:respStmt/tei:name"/> inom arbetsgruppen
                                    <xsl:value-of select="//tei:titleStmt/tei:editor"/>.</li>
                            <li>
                                <xsl:value-of select="//tei:publicationStmt/tei:p[1]"/>
                            </li>
                            <li>
                                <xsl:value-of select="//tei:publicationStmt/tei:p[2]"/>
                            </li>
                        </ul>
                    </div>
                    
                    <main>
                            <table>
                                <tr>
                                    <th>
                                        Faksimil
                                    </th>
                                    <th>
                                        Text
                                    </th>
                                </tr>
                                <xsl:for-each select="//tei:div[@type='page']">
                                    <xsl:variable name="facs" select="@facs"/>
                                <tr>
                                    <td class="faksimil">
                                        <a>
                                            <xsl:attribute name="href">
                                                <xsl:value-of select="//tei:surface[@xml:id=substring-after($facs, '#')]/tei:graphic/@url"/>
                                            </xsl:attribute>
                                            <img class="faksimil" alt="Faksimil av texten till höger">
                                            <xsl:attribute name="src">
                                                <xsl:value-of select="//tei:surface[@xml:id=substring-after($facs, '#')]/tei:graphic/@url"/>
                                                 </xsl:attribute>
                                        </img>
                                        </a>
                                    </td>
                                    <td class="text">
                                        <xsl:apply-templates/>
                                    </td>
                                </tr>
                                </xsl:for-each>
                            </table>
                    </main>
                </div>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="tei:lb">
        <br/>
    </xsl:template>

    <xsl:template match="tei:cb">
        <p/>
    </xsl:template>

    <xsl:template match="tei:name[@type='place']">
        <xsl:variable name="ref" select="@ref"/>
        <span class="plats">
            <xsl:attribute name="title">
                <xsl:value-of select="//tei:listPlace/tei:place[@xml:id=substring-after($ref, '#')]/tei:desc"/>
        </xsl:attribute>
        <xsl:apply-templates/></span>
    </xsl:template>

    <xsl:template match="tei:name[@type='person']">
        <xsl:variable name="ref" select="@ref"/>
        <span class="person">
            <xsl:attribute name="title">
                <xsl:value-of select="//tei:listPerson/tei:person[@xml:id=substring-after($ref, '#')]/tei:p"/>
            </xsl:attribute>
            <xsl:apply-templates/></span>
    </xsl:template>

    <xsl:template match="tei:head/tei:span[@type='bigname']">
        <span class="bigname">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:bibl">
        <xsl:variable name="ref" select="@ref"/>
        <span class="citat">
            <xsl:attribute name="title">
                <xsl:value-of select="//tei:listBibl/tei:bibl[@xml:id=substring-after($ref, '#')]"/>
            </xsl:attribute>
            <xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="tei:head">
        <h2>
            <xsl:apply-templates/>
        </h2>
    </xsl:template>
    
    <xsl:template match="tei:*[@rend='roman']">
        <span class="roman"><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="tei:dateline">
        <div class="front">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="tei:div[@type='printing']">
        <div class="front">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="tei:byline">
        <div class="front">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:expan"/>
        
    <xsl:template match="tei:figure/tei:figDesc">
        <p class="figDesc"><i>(<xsl:apply-templates/>)</i></p>
    </xsl:template>

    <xsl:template match="tei:lg[@type='banners']">
        <div class="banners">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:lg">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <xsl:template match="tei:l">
        <div>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:l[@rend='indent']">
        <div class="indent">
            <xsl:apply-templates/>
        </div>
    </xsl:template>    

    <xsl:template match="tei:l[@rend='longindent']">
        <div class="longindent">
            <xsl:apply-templates/>
        </div>
    </xsl:template>   

    <xsl:template match="tei:fw[@type='catch']">
        <p class="catch">
            <xsl:apply-templates/>
        </p>
    </xsl:template>   

    <xsl:template match="tei:epigraph">
        <div class="front">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="tei:quote/tei:lg/tei:l">
        <div class="bigverse">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="tei:note">
        <div class="note">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="tei:div[@type='3-split']">
        <table class="split">
            <tr>
            <xsl:apply-templates/>
            </tr>
        </table>
    </xsl:template>

    <xsl:template match="tei:div[@type='3-split']/tei:epigraph">
            <td class="smaller">
                <xsl:apply-templates/>
            </td>
    </xsl:template>

    <xsl:template match="tei:div[@type='3-split']/tei:figure">
        <td class="narrow">
            <xsl:apply-templates/>
        </td>
    </xsl:template>

    <xsl:template match="tei:div[@type='2-split']">
        <table class="split">
            <tr>
                <xsl:apply-templates/>
            </tr>
        </table>
    </xsl:template>

    <xsl:template match="tei:div[@type='2-split']/tei:lg/tei:lg">
        <td class="spalt">
            <xsl:apply-templates/>
        </td>
    </xsl:template>

</xsl:stylesheet>
