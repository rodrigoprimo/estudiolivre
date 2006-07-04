{include file="header.tpl"}{* This must be included as the first thing in a document to be XML compliant *}

{* $Header: /home/rodrigo/devel/arca/estudiolivre/src/templates/styles/estudiolivre/tiki-print.tpl,v 1.1 2006-07-04 23:26:46 rhwinter Exp $ *}

{* Index we display a wiki page here *}

{literal}
<style type="text/css">
html,body,form,table,tr,td {
	padding:0px;
	margin:0px;
	background-image:none;
	width:100%;
}

body {
	width:95%;
	margin:0 auto;
	font-family: Garamond, Georgia, New York, Times, Times New Roman;
	background-color:white;
	background-image: none;
}

#tiki-main {
	width:100%;
}

#tiki-midAudio,#tiki-midVideo, #tiki-midGraf, #tiki-midAcervo, #tiki-mid {
	width:100%;
	border: 0;
}
</style>
{/literal}

<div id="tiki-clean">
  <div  id="tiki-mid">
    {include file=$mid}
  </div>
</div>

{include file="footer.tpl"}
