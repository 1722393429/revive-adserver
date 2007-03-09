<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
    <!--  -->
<html>
<head>
    <title>Openads Schema</title>

    <link rel="stylesheet" type="text/css" href="css/mdb2_xsl.css"/>

    <script type="text/javascript" src="schema.js"/>
    <script type="text/javascript" src="../lib/xajax/xajax_js/xajax.js"></script>
    <script type="text/javascript">
        window.setTimeout(function () { if (!xajaxLoaded) { alert('Error: the xajax Javascript file could not be included. Perhaps the URL is incorrect?\nURL: ../lib/xajax/xajax_js/xajax.js'); } }, 6000);
    </script>

</head>
<body>
  <div class="bodydiv">
    <div class="heading">
        <xsl:text></xsl:text><xsl:value-of select="//database/name"/>
        <xsl:text> :: version: </xsl:text><xsl:value-of select="//database/version"/>
        <xsl:text> :: status: </xsl:text>
        <!--xsl:variable name="status"><xsl:value-of select="//database/status"/></xsl:variable-->
        <xsl:variable name="status" select="//database/status"></xsl:variable>
        <xsl:text> :: version: </xsl:text><xsl:value-of select="//database/version"/>
        <xsl:text> :: status: </xsl:text>
        <xsl:choose>
            <xsl:when test="$status='final'">
                <span style="font-weight:bold;color:black;"><xsl:value-of select="$status"/></span>
            </xsl:when>
            <xsl:otherwise>
                <span style="font-weight:bold;color:red;"><xsl:value-of select="$status"/></span>
            </xsl:otherwise>
        </xsl:choose>
    </div>
    <!--span class="titlemini"><xsl:value-of select="//database/comments"/></span-->

    <TABLE class="tablemain">
    <tr>
        <td class="tableheader"><xsl:call-template name="showadminmenu"/></td>
    </tr>
    </TABLE>

    <TABLE class="tablemain">
    <tr>
        <td class="tableheader">
            <xsl:variable name="status" select="//database/status"></xsl:variable>
            <xsl:choose>
                <xsl:when test="$status='final'">
                    <xsl:text>readonly</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:call-template name="showtableadd"/>
                </xsl:otherwise>
            </xsl:choose>
        </td>
    </tr>
    </TABLE>
    <xsl:for-each select="//database/table">
        <div class="tablediv">
                <xsl:call-template name="showtable"/>
                <xsl:call-template name="showtableindexes"/>
                <xsl:call-template name="showtableforeignkeys"/>
        </div>
    </xsl:for-each>
    <!-- -->
</div>
</body>
</html>
    <!-- -->
</xsl:template>

<xsl:template name="showtable">
    <TABLE class="tablemain">
        <tr>
            <td class="tableheader" colspan="1">
                <xsl:variable name="status" select="//database/status"></xsl:variable>
                <xsl:choose>
                    <xsl:when test="$status='final'">
                        <xsl:text>readonly</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:call-template name="showtableedit">
                            <xsl:with-param name="tablename"><xsl:value-of select="name"/></xsl:with-param>
                        </xsl:call-template>
                    </xsl:otherwise>
                </xsl:choose>
            </td>
            <td class="tableheader" colspan="7"><span class="titlemini"><xsl:value-of select="name"/></span></td>
        </tr>
        <tr>
            <td class="tableheader"><xsl:text>name</xsl:text></td>
            <td class="tableheader"><xsl:text>type</xsl:text></td>
            <td class="tableheader"><xsl:text>length</xsl:text></td>
            <td class="tableheader"><xsl:text>default</xsl:text></td>
            <td class="tableheader"><xsl:text>autoincrement</xsl:text></td>
            <td class="tableheader"><xsl:text>unsigned</xsl:text></td>
            <td class="tableheader"><xsl:text>notnull</xsl:text></td>
            <td class="tableheader"><xsl:text>comments</xsl:text></td>
        </tr>
        <xsl:for-each select="descendant::declaration/field">
            <xsl:call-template name="showfield"/>
        </xsl:for-each>
    </TABLE>
</xsl:template>


<xsl:template name="showtableindexes">

    <TABLE class="tablemain">
        <tr>
            <td colspan="10" class="tableheader">
                <span class="titlemini">indexes for <xsl:value-of select="name"/></span>
            </td>
        </tr>
        <tr>
            <td class="tableheader">name</td>
            <td class="tableheader">primary</td>
            <td class="tableheader">unique</td>
            <td class="tableheader" colspan="10">fields</td>
        </tr>
        <xsl:for-each select="descendant::declaration/index">
            <xsl:call-template name="showindex"/>
        </xsl:for-each>
    </TABLE>
</xsl:template>

<xsl:template name="showtableforeignkeys">

    <TABLE class="tablemain">
        <tr>
            <td colspan="10" class="tableheader">
                <span class="titlemini">foreign key constraints for <xsl:value-of select="name"/></span>
            </td>
        </tr>
        <tr>
            <td class="tableheader">symbol</td>
            <td class="tableheader">id</td>
            <td class="tableheader" colspan="2">fields</td>
        </tr>
        <xsl:for-each select="descendant::declaration/foreignkey">
            <xsl:call-template name="showforeignkey"/>
        </xsl:for-each>
    </TABLE>
</xsl:template>

<xsl:template name="showfield">
    <tr>
        <td class="tablebody"><span class="textmini"><xsl:value-of select="name"/></span></td>
        <td class="tablebody"><span class="textmini"><xsl:value-of select="type"/></span></td>
        <td class="tablebody"><span class="textmini"><xsl:value-of select="length"/></span></td>
        <td class="tablebody"><span class="textmini"><xsl:value-of select="default"/></span></td>
        <td class="tablebody"><span class="textmini"><xsl:value-of select="autoincrement"/></span></td>
        <td class="tablebody"><span class="textmini"><xsl:value-of select="unsigned"/></span></td>
        <td class="tablebody"><span class="textmini"><xsl:value-of select="notnull"/></span></td>
        <td class="tablebody"><span class="textmini"><xsl:value-of select="comments"/></span></td>
    </tr>
</xsl:template>

<xsl:template name="showindex">
    <tr>
        <td class="tablebody"><span class="textmini"><xsl:value-of select="name"/></span></td>
        <td class="tablebody"><span class="textmini"><xsl:value-of select="primary"/></span></td>
        <td class="tablebody"><span class="textmini"><xsl:value-of select="unique"/></span></td>
        <xsl:for-each select="field">
            <td class="tablebody"><span class="textmini"><xsl:value-of select="name"/> (<xsl:value-of select="sorting"/>)</span></td>
        </xsl:for-each>
    </tr>
</xsl:template>

<xsl:template name="showforeignkey">
    <tr>
        <td class="tablebody"><span class="textmini"><xsl:value-of select="symbol"/></span></td>
        <td class="tablebody"><span class="textmini"><xsl:value-of select="name"/></span></td>
        <xsl:for-each select="field">
            <td class="tablebody"><span class="textmini"><xsl:value-of select="name"/></span></td>
        </xsl:for-each>
    </tr>
</xsl:template>

<xsl:template name="showtableedit">
    <xsl:param name="tablename">unkown</xsl:param>
    <form id="frm_schema" method="POST" action="index.php">
        <button name="btn_table_edit" type="submit" value="{$tablename}">edit this table</button>
        <!--button name="btn_table_edit" type="button" onclick="xajax_testAjax(xajax.getFormValues('frm_schema'));">edit this table</button-->
    </form>
</xsl:template>

<xsl:template name="showtableadd">
    <form name="frm_schema" method="POST" action="index.php">
        <button name="btn_table_new" type="submit">new table</button>
    </form>
</xsl:template>

<xsl:template name="showadminmenu">
    <form name="frm_admin" method="POST" action="index.php">
        <input name="btn_delete_trans" type="submit" value="delete transitional schema"/>
        <input name="btn_copy_final" type="submit" value="copy final schema to transitional" />
    </form>
</xsl:template>

</xsl:stylesheet>
