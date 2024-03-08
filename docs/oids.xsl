<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" version="5.0" indent="yes" doctype-system="about:legacy-compat"/>

<xsl:template match="/">
  <html>
    <head>
      <style>
/********************/
/* EXPANDABLE LIST  */
/********************/
#listContainer{
  margin-top:15px;
}
table, th, td {
  border: 1px solid black;
  border-collapse: collapse;
  align: center;
}
h1 {
  font-family: courier;
  font-size: 300%;
}
h2 {
  font-family: courier;
  font-size: 150%;
}
h3 {
  font-family: courier;
  font-size: 125%;
  color: red;
}
red {
  font-family: courier;
  font-size: 100%;
  color: red;
}
#expList ul, li {
    list-style: none;
    margin:0;
    padding:0;
    cursor: pointer;
    font-family:courier;
}
#expList p {
    margin:0;
    display:block;
    font-family:courier;
}
#expList p:hover {
    background-color:#121212;
    font-family:courier;
}
#expList li {
    line-height:140%;
    text-indent:0px;
    background-position: 1px 8px;
    padding-left: 20px;
    background-repeat: no-repeat;
    font-family:courier;
}

/* Collapsed state for list element */
#expList .collapsed {
    background-image: url(./collapsed.png);
}
/* Expanded state for list element
/* NOTE: This class must be located UNDER the collapsed one */
#expList .expanded {
    background-image: url(./expanded.png);
}
#expList {
    clear: both;
}

.listControl{
  margin-bottom: 15px;
}
.listControl a {
    border: 1px solid #555555;
    color: #555555;
    cursor: pointer;
    height: 1.5em;
    line-height: 1.5em;
    margin-right: 5px;
    padding: 4px 10px;
    font-family:courier;
}
.listControl a:hover {
    background-color:#555555;
    color:#222222;
    font-weight:normal;
    font-family:courier;
}
      </style>
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
      <script>
/**************************************************************/
/* Prepares the cv to be dynamically expandable/collapsible   */
/**************************************************************/
function prepareList() {
    $('#expList').find('li:has(ul)')
    .click( function(event) {
        if (this == event.target) {
            $(this).toggleClass('expanded');
            $(this).children('ul').toggle('medium');
        }
        return false;
    })
    .addClass('collapsed')
    .children('ul').hide();

    //Create the button funtionality
    $('#expandList')
    .unbind('click')
    .click( function() {
        $('.collapsed').addClass('expanded');
        $('.collapsed').children().show('medium');
    })
    $('#collapseList')
    .unbind('click')
    .click( function() {
        $('.collapsed').removeClass('expanded');
        $('.collapsed').children().hide('medium');
    })

};

/**************************************************************/
/* Functions to execute on loading the document               */
/**************************************************************/
$(document).ready( function() {
    prepareList()
});
      </script>
      <title>The OID Directory - Registered OIDs</title>
    </head>
    <body>
      <h3>The OID Directory - Registered OIDs</h3>
      <xsl:apply-templates/>
    </body>
  </html>
</xsl:template>

<xsl:template match="OIDBranch">
        <div id="listContainer">
            <div class="listControl">
                <a id="expandList">Expand</a>
                <a id="collapseList">Collapse</a>
            </div>
            <ul id="expList">
              <li>The OID Directory (1.3.6.1.4.1.56521.101)
                 <xsl:apply-templates select="Arc"/>
              </li>
            </ul>
         </div>
</xsl:template>

<xsl:template match="Arc">
  <ul>
    <li><xsl:value-of select="@ID | @OID"/>
      <ul>
        <xsl:apply-templates select="Arc|AttributeType|ObjectClass|NameForm|Model"/>
      </ul>
    </li>
  </ul>
</xsl:template>

<xsl:template match="AttributeType">
   <table>
   <tr>
      <th>Identifier</th>
      <th>Arc</th>
      <th>URL</th>
   </tr>
  <xsl:apply-templates select="Row"/>
  </table>
</xsl:template>

<xsl:template match="ObjectClass">
   <table>
   <tr>
      <th>Identifier</th>
      <th>Arc</th>
      <th>URL</th>
   </tr>
  <xsl:apply-templates select="Row"/>
  </table>
</xsl:template>

<xsl:template match="NameForm">
   <table>
   <tr>
      <th>Identifier</th>
      <th>Arc</th>
      <th>URL</th>
   </tr>
  <xsl:apply-templates select="Row"/>
  </table>
</xsl:template>

<xsl:template match="Model">
   <table>
   <tr>
      <th>Identifier</th>
      <th>Arc</th>
      <th>URL</th>
   </tr>
  <xsl:apply-templates select="Row"/>
  </table>
</xsl:template>

<xsl:template match="Row">
   <tr>
     <td><xsl:value-of select="@ID"/></td>
     <td><xsl:value-of select="@N"/></td>
     <td><a href="https://datatracker.ietf.org/doc/html/draft-coretta-oiddir-{@SRC}#section-{@SECTION}{@N}">🔗</a></td>
   </tr>
</xsl:template>

</xsl:stylesheet>
