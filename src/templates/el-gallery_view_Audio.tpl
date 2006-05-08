  <span class="campo">Duração:</span> {$arquivo.metadata.duracao}<br/>
  <span class="campo">Álbum:</span> {$arquivo.metadata.album}<br/>
  <span class="campo">Bpm:</span> {$arquivo.metadata.bpm}<br/>
  <span class="campo">Gênero:</span> {$arquivo.metadata.genero}<br/>
  <span class="campo">Formato:</span> {$arquivo.formato}, {$arquivo.metadata.sampleRate}Hz, {$arquivo.metadata.bitRate}kbps<br/>
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
    <span class="campo">Ficha técnica (músicos, produtores, arranjadores e demais participantes):</span><br/>
    {$arquivo.metadata.fichaTecnica|nl2br}
  </div><br/>

  <div class="campoTexto">
    <span class="campo">Descrição (equipamentos, softwares, samples e processos utilizados):</span><br/>
    {$arquivo.descricao|nl2br}
  </div><br/>
  
  <div class="campoTexto">
    <span class="campo">Letra:</span><br/>
    {$arquivo.metadata.letra|nl2br}
  </div><br/>

  