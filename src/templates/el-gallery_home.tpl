<!-- el-gallery_home.tpl begin -->

<script language="JavaScript" src="lib/elgal/el_home.js"></script>

<!-- Feature Wiki Begin -->
<div id="gHomeWiki" {if $tiki_p_edit eq 'y'} ondblclick="location.href='tiki-editpage.php?page=destak'"{/if}>
  {$destak}
</div>
<!-- Feature Wiki End -->
<!-- List Options Begin -->
<div id="listOptions">

  <!-- Filters Begin -->
  <div id="listFilters">
  
    <ul id="listFiltersButtons">
    
      <img id="listFilterImg0" alt="" src="styles/estudiolivre/bLeftAct.png" />
      <li id="listFilterBut0" class="buttonActive" onClick="toggleFilter(this, 0, 'Audio')">
	  áudio
      </li>
      
      <img id="listFilterImg1" alt="" src="styles/estudiolivre/bAct2Act.png" />
      <li id="listFilterBut1" class="buttonActive" onClick="toggleFilter(this, 1, 'Imagem')">
	  gráfico
      </li>
      
      <img id="listFilterImg2" alt="" src="styles/estudiolivre/bAct2Act.png" />
      <li id="listFilterBut2" class="buttonActive" onClick="toggleFilter(this, 2, 'Video')">
	  vídeo
      </li>
      
      <img id="listFilterImg3" alt="" src="styles/estudiolivre/bAct2Inac.png" />
      <li id="listFilterBut3" class="buttonInactive" onClick="toggleFilter(this, 3, 'Texto')">
	  texto
      </li>
      
      <img id="listFilterImg4" alt="" src="styles/estudiolivre/bRightInac.png" />
      
    </ul>
  
  </div>
  <!-- Filters End -->
  
  <div id="rightContainerTop">
    <div id="listOrder">
      <a href="#"><img alt="" src="styles/estudiolivre/sortArrowDown.png" /></a>
      <select style="decoration:none">
        <option>Data</option>
	<option>Estrelas</option>
	<option>Downloads</option>
      </select>
    </div>
    <div  id="listNav">
      <a href="#">&laquo;</a>
      <a href="#">&lt;</a>
      <a href="#">1</a>,
      <a href="#">2</a>,
      <span class="selected">3</span>
      ...
      <a href="#">12</a>
      <a href="#">&gt;</a>
      <a href="#">&raquo;</a>
    </div>
  </div>
</div>
<!-- List Options End -->
<div id="gListCont">
{foreach from=$arquivos item=p}
  {include file="el-gallery_list_item.tpl" arquivo=$p}
{/foreach}
</div>
<!-- el-gallery_home.tpl end -->

{$search_url}
