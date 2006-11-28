{css}
<!-- content.tpl begin -->

<div id="ajax-contentBubble">


    
    {* Index we display a wiki page here *}
    {* tirei os  onclick="showMenu(event)"> do contextualMenu *}
    {if $category eq "Áudio"}
      <div id="tiki-midAudio">
      {include file="sideContent.tpl"}
    {elseif $category eq "Gráfico"}
       <div id="tiki-midGraf">
       {include file="sideContent.tpl"}
    {elseif $category eq "Vídeo"}
       <div id="tiki-midVideo">
       {include file="sideContent.tpl"}
    {elseif $category eq "gallery"}
    	{include file="sideContent.tpl"}
        <div id="tiki-midAcervo">
    {else}
        <div id="tiki-mid">
        {include file="sideContent.tpl"}
    {/if}
    
<!--HIGHLIGHT BEGIN-->

    {$mid_data}

<!--HIGHLIGHT END-->
<!-- sasquatch -->
    </div>
    

    
</div>
<!-- content.tpl end -->
