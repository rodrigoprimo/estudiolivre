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
      <div id="tiki-midAudio" onclick="showMenu(event)">
    {elseif $category eq "Gráfico"}
       <div id="tiki-midGraf" onclick="showMenu(event)">
    {elseif $category eq "Vídeo"}
       <div id="tiki-midVideo" onclick="showMenu(event)">
    {elseif $category eq "gallery"}
        <div id="tiki-midAcervo">
    {else}
        <div id="tiki-mid">
    {/if}

    {include file=$mid}
    </div>
    
    {include file="sideContent.tpl"}
    
</div>
<!-- content.tpl end -->
