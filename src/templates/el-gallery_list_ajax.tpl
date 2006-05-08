<div id="elLoading" style="display: none">Carregando...</div>	

<div class="el-tabs">
    <span id="tab-Audio" class={if $cookietab eq 'Audio'}"tabfocused"{else}"tabmark"{/if}><a href="javascript:elTabs['Audio'].focus();" onFocus="this.blur();">{tr}Audio{/tr}</a></span>
    <span id="tab-Video" class={if $cookietab eq 'Video'}"tabfocused"{else}"tabmark"{/if}><a href="javascript:elTabs['Video'].focus();" onFocus="this.blur();">{tr}Video{/tr}</a></span>
    <span id="tab-Imagem" class={if $cookietab eq 'Imagem'}"tabfocused"{else}"tabmark"{/if}><a href="javascript:elTabs['Imagem'].focus();" onFocus="this.blur();">{tr}Imagem{/tr}</a></span>
    <span id="tab-Texto" class={if $cookietab eq 'Texto'}"tabfocused"{else}"tabmark"{/if}><a href="javascript:elTabs['Texto'].focus();" onFocus="this.blur();">{tr}Texto{/tr}</a></span>
</div>

<div id="content">
  <div class="el-tabcontent" id="content-Audio"></div>
  <div class="el-tabcontent" id="content-Video"></div>
  <div class="el-tabcontent" id="content-Imagem"></div>
  <div class="el-tabcontent" id="content-Texto"></div>
</div>

{$xajax_js}
<script language="JavaScript" src="lib/elgal/el-rating.js"></script>
<script language="JavaScript" src="lib/elgal/ui/tab.js"></script>
<script language="JavaScript" src="lib/elgal/acervo.js"></script>
