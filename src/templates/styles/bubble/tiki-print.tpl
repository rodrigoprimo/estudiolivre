{css}
{include file="header.tpl"}{* This must be included as the first thing in a document to be XML compliant *}
<script type="text/javascript" src="lib/js/toggleImage.js"></script>
{* $Header: /home/rodrigo/devel/arca/estudiolivre/src/templates/styles/bubble/Attic/tiki-print.tpl,v 1.1 2006-10-11 02:05:12 rhwinter Exp $ *}
<link rel="StyleSheet"  href="styles/estudiolivre/css/print.css" type="text/css" />

{* Index we display a wiki page here *}
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
