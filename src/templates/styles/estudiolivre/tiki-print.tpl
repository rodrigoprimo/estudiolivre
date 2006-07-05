{include file="header.tpl"}{* This must be included as the first thing in a document to be XML compliant *}

{* $Header: /home/rodrigo/devel/arca/estudiolivre/src/templates/styles/estudiolivre/tiki-print.tpl,v 1.3 2006-07-05 23:48:51 rhwinter Exp $ *}

{* Index we display a wiki page here *}

{literal}
<style type="text/css">
html,body,form,table,tr,td {
	padding:5px;
	margin:0 auto;
	background-image:none;
	width:95%;
}

body {
	width:100%;
	margin:0 auto;
	font-family: Garamond, Georgia, New York, Times, Times New Roman;
	background-color:white;
	background-image: none;
	padding:0;
}

#tiki-main {
	width:100%;
}

#tiki-midAudio,#tiki-midVideo, #tiki-midGraf, #tiki-midAcervo, #tiki-mid {
	overflow:visible;
	width: 100%;
	border: 0;
	margin-top:40px;
	font-size:12pt;
	line-height:1.5em;
}

p.editdate {
	float:none;
	margin-top:25px;
}

#printFooter{
	text-align:center;
	
}

#printLogo {
	position:relative;
	left:0;
	top:0;
}

#printSite{
	position:absolute;
	margin:0;
	padding:0;
	right:0px;
	top:0px;
	font-family:arial,verdana,helvetica,lucida,sans-serif;
	font-size:18px;
	margin-top:1em;
}

A.wiki {
	text-decoration:underline;
}

A.external{
	color:blue;
	background: none;
	padding-right: 0px;
}

#wikitext A.external {
	color:blue;
	text-decoration: none;
}

A.external:after {
	color:black;
	/* Expand URLs for printing */
    content: " (" attr(href) ") ";
    text-decoration:none;
}

</style>
{/literal}
<div id="printLogo">
	<img src="styles/estudiolivre/logoTop.png">
</div>

<div id="printSite">
www.estudiolivre.org
</div>

<div id="tiki-clean">
  <div  id="tiki-mid">
    {include file=$mid}
  </div>
</div>
{include file="footer.tpl"}
