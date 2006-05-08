  <span class="campo">Formato:</span> {$arquivo.formato}, {$arquivo.metadata.tamanhoImagemX} x {$arquivo.metadata.tamanhoImagemY}<br/>
  <span class="campo">Tamanho:</span> {$arquivo.tamanho|show_filesize}<br/>
  <span class="campo">Resolução:</span> {$arquivo.metadata.dpi} dpi<br/>
  <span class="campo">Contato:</span> {$arquivo.contato}<br/>
  <br/>

  {if $arquivo.iSampled neq null}
  <div class="sample">
    <img src="http://ccmixter.org/cctemplates/ccmixter/downloadicon-big.gif">
    {$arquivo.iSampled}
  </div><br/>
  {/if}{if $arquivo.sampledMe neq null}
  <div class="sample">
    <img src="http://ccmixter.org/cctemplates/ccmixter/uploadicon-big.gif">
    {$arquivo.sampledMe}
  </div><br/>
  {/if}
  
  <div class="campoTexto">
    <span class="campo">Descrição (equipamentos, softwares, samples e processos utilizados):</span><br/>
    <pre>{$arquivo.descricao}</pre>
  </div><br/>

  