<!-- content.tpl begin -->
<div id="contentBubble">
    {if $feature_usermenu eq 'y'}	
      <div id="usermenu">
        &nbsp;&nbsp;<a href="tiki-usermenu.php?url={$smarty.server.REQUEST_URI|escape:"url"}"><img src='img/icons/add.gif' border='0' alt='{tr}add{/tr}' title='{tr}add{/tr}' /></a>
        {section name=ix loop=$usr_user_menus}
          &nbsp;&nbsp;<img style="vertical-align:bottom;" src="styles/neat/logoIcon.gif" /><a {if $usr_user_menus[ix].mode eq 'n'}target='_blank'{/if} href="{$usr_user_menus[ix].url}" class="tikitopmenu2">{$usr_user_menus[ix].name}</a>
        {/section}
      
      </div>
    {/if}
    
    
    {* Index we display a wiki page here *}
    
    {if $category eq "Áudio"}
      <div id="tiki-midAudio">
    {elseif $category eq "Gráfico"}
       <div id="tiki-midGraf">
    {elseif $category eq "Vídeo"}
       <div id="tiki-midVideo">
    {elseif $style eq "estudiolivre_biblio.css"}
        <div id="tiki-midAcervo">
    {else}
        <div id="tiki-mid">
     {/if}

    {include file=$mid}
    </div>
    
    {include file="sideContent.tpl"}
    
    {*if $style eq "estudiolivre_biblio.css"}
      {include file="el-gallery_sidemenu.tpl"}
    {else}
      {include file="modules/mod-el_menu.tpl"}
    {/if*}
</div>
<!-- content.tpl end -->
