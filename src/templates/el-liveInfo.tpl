
<ul>

{foreach from=$sources item=source}
  <li>
  {if $source->server_type eq 'audio/mpeg' || ($source->server_type eq 'application/ogg' && $source->subtype eq 'Vorbis')}
  	{tr}Canal de Áudio{/tr}: 
  {else}
  	{assign var=video value=1}
    {tr}Canal de Vídeo{/tr}: 
  {/if}
  <a href="{$source->server_url}">{$source->server_name}</a><br>
  {tr}Description{/tr}: {$source->server_description}<br>
  {tr}Gênero{/tr}: {$source->genre}<br>
  {tr}Visitantes{/tr}: {$source->listeners}<br>
  {tr}Máximo de Visitantes{/tr}: {$source->listener_peak}<br>
  {tr}BitRate{/tr}: {$source->bitrate|default:$source->ice-bitrate}<br>
  {if $video}
  	{tr}Size{/tr}: {$source->frame_size}
	{tr}Frame rate{/tr}: {$source->frame_rate}
  {/if}
  <a href="{$source->listenurl}">{tr}veja aqui{/tr}</a><br>
  </li>
{foreachelse}
  {tr}Nada ao vivo no EL no momento{/tr}! :-(
{/foreach}
</ul>