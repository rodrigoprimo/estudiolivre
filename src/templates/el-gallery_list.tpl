<script language="JavaScript" src="lib/cpaint/cpaint2.inc.js"></script>
<script language="JavaScript" src="lib/elgal/el-rating.js"></script>

<br/>

{if $feature_tabs eq 'y'}

{cycle name=tabs values="1,2,3,4" print=false advance=false}
<div class="el-tabs">
    <span id="tab{cycle name=tabs assign=tabi}{$tabi}" class="tabmark" style="border-color:{if $cookietab eq $tabi}black{else}silver{/if};"><a href="javascript:tikitabs({$tabi},6);" onFocus="this.blur();">{tr}Audio{/tr}</a></span>
    <span id="tab{cycle name=tabs assign=tabi}{$tabi}" class="tabmark" style="border-color:{if $cookietab eq $tabi}black{else}silver{/if};"><a href="javascript:tikitabs({$tabi},6);" onFocus="this.blur();">{tr}Video{/tr}</a></span>
    <span id="tab{cycle name=tabs assign=tabi}{$tabi}" class="tabmark" style="border-color:{if $cookietab eq $tabi}black{else}silver{/if};"><a href="javascript:tikitabs({$tabi},6);" onFocus="this.blur();">{tr}Imagem{/tr}</a></span>
    <span id="tab{cycle name=tabs assign=tabi}{$tabi}" class="tabmark" style="border-color:{if $cookietab eq $tabi}black{else}silver{/if};"><a href="javascript:tikitabs({$tabi},6);" onFocus="this.blur();">{tr}Texto{/tr}</a></span>
</div>

{cycle name=content values="1,2,3,4" print=false advance=false}
{* ---------------------- Audio -------------------- *}

<div id="content{cycle name=content assign=focustab}{$focustab}" {if $feature_tabs eq 'y'} style="display:{if $focustab eq $cookietab}block{else}none{/if};" class="el-tabcontent"{/if}>
<div class="container"><a class="el-upload_link" href="el-gallery_upload.php?tipo=Audio">subir um arquivo</a></div>
{foreach from=$all item=p}
    {if $p.tipo eq 'Audio'}
      {include file="el-gallery_list_item.tpl" arquivo=$p style="el-list-branco"}
    {/if}
{/foreach}
</div>

{* ---------------------- Video -------------------- *}
<div id="content{cycle name=content assign=focustab}{$focustab}" {if $feature_tabs eq 'y'} style="display:{if $focustab eq $cookietab}block{else}none{/if};" class="el-tabcontent"{/if}>
<div class="container"><a class="el-upload_link" href="el-gallery_upload.php?tipo=Video">subir um arquivo</a></div>
{foreach from=$all item=p}
{if $p.tipo eq 'Video'}
      {include file="el-gallery_list_item.tpl" arquivo=$p style="el-list-branco"}
{/if}
{/foreach}
</div>

{* ---------------------- Imagem -------------------- *}
<div id="content{cycle name=content assign=focustab}{$focustab}" {if $feature_tabs eq 'y'} style="display:{if $focustab eq $cookietab}block{else}none{/if};" class="el-tabcontent"{/if}>
<div class="container"><a class="el-upload_link" href="el-gallery_upload.php?tipo=Imagem">subir um arquivo</a></div>
{foreach from=$all item=p}
{if $p.tipo eq 'Imagem'}
      {include file="el-gallery_list_item.tpl" arquivo=$p style="el-list-branco"}
{/if}
{/foreach}
</div>
{* ---------------------- Texto -------------------- *}
<div id="content{cycle name=content assign=focustab}{$focustab}" {if $feature_tabs eq 'y'} style="display:{if $focustab eq $cookietab}block{else}none{/if};" class="el-tabcontent"{/if}>
<div class="container"><a class="el-upload_link" href="el-gallery_upload.php?tipo=Texto">subir um arquivo</a></div>
{foreach from=$all item=p}
{if $p.tipo eq 'Texto'}
      {include file="el-gallery_list_item.tpl" arquivo=$p style="el-list-branco"}
{/if}
{/foreach}
</div>
{/if}
