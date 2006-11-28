{css}

{if $category eq "Áudio"}
	{assign var="midId" value="tiki-midAudio"}
{elseif $category eq "Gráfico"}
	{assign var="midId" value="tiki-midGraf"}
{elseif $category eq "Vídeo"}
	{assign var="midId" value="tiki-midVideo"}
{elseif $category eq "gallery"}
	{assign var="midId" value="tiki-midAcervo"}
{elseif $section eq "wiki"}
	{assign var="midId" value="tiki-mid"}
{else}
	{assign var="midId" value="tiki-midNaoWiki"}
{/if}

<!-- content.tpl begin -->
<div id="ajax-contentBubble">
	{if $section neq "wiki"}{include file="sideContent.tpl"}{/if}
	<div id="{$midId}">
		{if $section eq "wiki"}{include file="sideContent.tpl"}{/if}
	    {$mid_data}
    </div>
</div>
<!-- content.tpl end -->
