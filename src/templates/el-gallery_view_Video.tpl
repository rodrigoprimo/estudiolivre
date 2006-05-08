  <span class="campo">Duração:</span> {$arquivo.metadata.duracao}<br/>
  <span class="campo">Idioma:</span> {$arquivo.metadata.idiomaVideo}<br/>
  {if $arquivo.metadata.legendas eq 1}
  <span class="campo">Legendas:</span> {$arquivo.metadata.idiomaLegenda}<br/>
  {/if}
  <span class="campo">Áudio:</span>
  {if $arquivo.metadata.temAudio eq 1} sim{else} não{/if}<br/>
  <span class="campo">Cor:</span>
  {if $arquivo.metadata.temCor eq 1} sim{else} não{/if}<br/>
  <span class="campo">Formato:</span> {$arquivo.formato}, {$arquivo.metadata.tamanhoImagemX} x {$arquivo.metadata.tamanhoImagemY}<br/>
  <span class="campo">Tamanho:</span> {$arquivo.tamanho|show_filesize}<br/>
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
    <span class="campo">Ficha técnica (diretores, produtores, atores e demais participantes):</span><br/>
    <pre>{$arquivo.metadata.fichaTecnica}</pre>
  </div><br/>

  <div class="campoTexto">
    <span class="campo">Descrição (equipamentos, softwares, samples e processos utilizados):</span><br/>
    <pre>{$arquivo.descricao}</pre>
  </div><br/>

  