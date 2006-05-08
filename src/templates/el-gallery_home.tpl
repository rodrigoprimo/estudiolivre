<!-- el-gallery_home.tpl begin -->

<script language="JavaScript" src="lib/cpaint/cpaint2.inc.js"></script>
<script language="JavaScript" src="lib/elgal/el-rating.js"></script>


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
    
      <img alt="" src="styles/estudiolivre/bLeftAct.png" />
      <li id="buttonActive">
	  audio
      </li>
      
      <img alt="" src="styles/estudiolivre/bAct2Act.png" />
      <li id="buttonActive">
	  gráfico
      </li>
      
      <img alt="" src="styles/estudiolivre/bAct2Act.png" />
      <li id="buttonActive">
	  vídeo
      </li>
      
      <img alt="" src="styles/estudiolivre/bAct2Inac.png" />
      <li id="buttonInactive">
	  texto
      </li>
      
      <img alt="" src="styles/estudiolivre/bRightInac.png" />
      
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
{foreach from=$all item=p}
  {include file="el-gallery_list_item.tpl" arquivo=$p}
{/foreach}
</div>
<!-- el-gallery_home.tpl end -->

{$search_url}
