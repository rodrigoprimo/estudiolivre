
<ul>

{foreach from=$sources item=source}
  <li>
  {if $source->SERVER_TYPE eq 'audio/mpeg'}
  	Canal de Rádio: 
  {else}
    Canal de Vídeo: 
  {/if}
  <a href="{$source->LISTENURL}">{$source->SERVER_NAME}</a><br>
  Descrição: {$source->SERVER_DESCRIPTION}<br>
  Gênero: {$source->GENRE}<br>
  Visitantes: {$source->LISTENERS}<br>
  Máximo de Visitantes: {$source->LISTENER_PEAK}<br>
  BitRate: {$source->BITRATE}<br>
  <a href="{$source->LISTENURL}">link para ouvir</a><br>
  </li>
{foreachelse}
  Nada ao vivo no EL no momento! :-(
{/foreach}
</ul>