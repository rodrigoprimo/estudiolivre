{* $Header$ *}

{if $feature_ajax eq 'y'}
{* <script src="lib/cpaint/cpaint2.inc.compressed.js" type="text/javascript"></script>
 <script src="lib/freetag/freetag_ajax.js" type="text/javascript"></script> *}
{/if}

{if $feature_morcego eq 'y' and $freetags_feature_3d eq 'y'}
<h1>{tr}Browse related tags{/tr}</h1>

<div class="morcego_embedded">
<h2>{tr}Network of Tags related to{/tr}: <span id="currentTag1">{$tag}</span></h2>
<applet codebase="./lib/wiki3d" archive="morcego-0.4.0.jar" code="br.arca.morcego.Morcego" width="{$freetags_3d_width}" height="{$freetags_3d_height}">
      <param name="serverUrl" value="{$base_url}/tiki-freetag3d_xmlrpc.php">
      <param name="startNode" value="{$tag}">
      <param name="windowWidth" value="{$freetags_3d_width}">
      <param name="windowHeight" value="{$freetags_3d_height}">
      <param name="viewWidth" value="{$freetags_3d_width}">
      <param name="viewHeight" value="{$freetags_3d_height}">
      <param name="navigationDepth" value="{$freetags_3d_navigation_depth}">
      <param name="feedAnimationInterval" value="{$freetags_3d_feed_animation_interval}">
      <param name="controlWindowName" value="tiki">
      
      <param name="showArcaLogo" value="false">
      <param name="showMorcegoLogo" value="false">

      <param name="loadPageOnCenter" value="{$freetags_3d_autoload|default:"true"}">
      
      <param name="cameraDistance" value="{$freetags_3d_camera_distance|default:"200"}">
      <param name="adjustCameraPosition" value="{$freetags_3d_adjust_camera|default:"true"}">

      <param name="fieldOfView" value="{$freetags_3d_fov|default:"250"}">
      <param name="nodeSize" value="{$freetags_3d_node_size|default:"30"}">
      <param name="textSize" value="{$freetags_3d_text_size|default:"40"}">

      <param name="frictionConstant" value="{$freetags_3d_friction_constant|default:"0.4f"}">
      <param name="elasticConstant" value="{$freetags_3d_elastic_constant|default:"0.5f"}">
      <param name="eletrostaticConstant" value="{$freetags_3d_eletrostatic_constant|default:"1000f"}">
      <param name="springSize" value="{$freetags_3d_spring_size|default:"100"}">
      <param name="nodeMass" value="{$freetags_3d_node_mass|default:"5"}">
      <param name="nodeCharge" value="{$freetags_3d_node_charde|default:"1"}">

</applet>
</div>
{/if}

<h2>{tr}Tag {/tr}<span id="currentTag2">{$tag}</span></h2>

<div class="navbar">
<a class="linkbut {if $type eq ''} highlight{/if}"  href="tiki-browse_freetags.php?tag={$tag}" id="typeAll">{tr}All{/tr}</a>
{if $feature_wiki eq 'y'}
<a class="linkbut {if $type eq "wiki page"} highlight{/if}"  href="tiki-browse_freetags.php?tag={$tag}&amp;type=wiki" id="typeWikiPage">{tr}Wiki pages{/tr}</a>
{/if}
  <a class="linkbut" href="tiki-browse_freetags.php?tag={$tag}&amp;type=gallery">{if $type eq 'gallery'}<span class="highlight">{/if}{tr}Acervo{/tr}{if $type eq 'gallery'}</span>{/if}</a>
</div>

<div id="objectList"></div>

<h3>{$cantobjects} resultado{if $cantobjects != 1}s{/if}</h3>
{if $cantobjects > 0}
  <table class="normal">
  {cycle values="odd,even" print=false}
  {section name=ix loop=$objects}
  <tr class="{cycle}">
    {if $objects[ix].type eq 'gallery'}
      <td colspan="3">{el_gallery_item id=$objects[ix].itemId}</td>
    {else}

  <td>{tr}{$objects[ix].type|replace:"wiki page":"Wiki"|replace:"article":"Article"|replace:"gallery":"Acervo"|regex_replace:"/tracker [0-9]*/":"tracker item"}{/tr}</td>
  <td><a href="{$objects[ix].href}" class="catname">{$objects[ix].name}</a></td>
  <td>{$objects[ix].description}&nbsp;</td>
    {/if}
  </tr>
  {/section}

  </table>
  <br />   

  <div align="center">
    <div class="mini">
      {if $prev_offset >= 0}
        [<a class="prevnext" href="tiki-browse_freetags.php?find={$find}&amp;type={$type}&amp;offset={$prev_offset}">{tr}prev{/tr}</a>]&nbsp;
      {/if}
      {tr}Page{/tr}: {$actual_page}/{$cant_pages}
      {if $next_offset >= 0}
        &nbsp;[<a class="prevnext" href="tiki-browse_freetags.php?find={$find}&amp;type={$type}&amp;offset={$next_offset}">{tr}next{/tr}</a>]
      {/if}
      {if $direct_pagination eq 'y'}
        <br />
        {section loop=$cant_pages name=foo}
          {assign var=selector_offset value=$smarty.section.foo.index|times:$maxRecords}
          <a class="prevnext" href="tiki-browse_freetags.php?find={$find}&amp;type={$type}&amp;offset={$selector_offset}">
            {$smarty.section.foo.index_next}
          </a>&nbsp;
        {/section}
      {/if}
   </div>
  </div>
  {/if}

