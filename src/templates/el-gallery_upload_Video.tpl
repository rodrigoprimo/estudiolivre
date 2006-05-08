<!--
Duração: <input type="text" name="especificoStub[duracao]" value="{$arquivo.metadata.duracao}" size=5/><br />
Largura:<input type="text" name="especificoStub[tamanhoImagemX]" value="{$arquivo.metadata.tamanhoImagemX}" size=5/><br />
Altura:<input type="text" name="especificoStub[tamanhoImagemY]" value="{$arquivo.metadata.tamanhoImagemY}" size=5/><br />
Audio: <select name="especificoStub[temAudio]">
        <option value="1" {if $arquivo.metadata.temAudio eq 1}selected{/if}>Sim</option>
        <option value="0" {if $arquivo.metadata.temAudio eq 0}selected{/if}>Não</option>
       </select> <br />
Cor: <select name="especificoStub[temCor]">
        <option value="1" {if $arquivo.metadata.temCor eq 1}selected{/if}>Sim</option>
        <option value="0" {if $arquivo.metadata.temCor eq 0}selected{/if}>Não</option>
       </select> <br />

Idioma do Vídeo: <input type="text" name="especificoStub[idiomaVideo]" value="{$arquivo.metadata.idiomaVideo}" size=20/><br />
Legenda: <select name="especificoStub[legendas]">
          <option value="1" {if $arquivo.metadata.legendas eq 1}selected{/if}>Sim</option>
          <option value="0" {if $arquivo.metadata.legendas eq 0}selected{/if}>Não</option>
         </select> <br />
Idioma da Legenda: <input type="text" name="especificoStub[idiomaLegenda]" value="{$arquivo.metadata.idiomaLegenda}" size=20/>
<br />
<span style="vertical-align:top">Ficha Técnica:</span>
<textarea name="especificoStub[fichaTecnica]" cols="50" rows="15">{$arquivo.metadata.fichaTecnica}</textarea><br />

-->

<table class="el-upload-general el-upload-general2">
        
    <tr>
            <td class="el-upload-general-right">
                Duração:
            </td>
                
            <td>
                <input type="text" name="especificoStub[duracao]" value="{$arquivo.metadata.duracao}" size=5/>
            </td>
    </tr>
    <tr>
            <td class="el-upload-general-right">
               Largura:
            </td>
                
            <td>
                <input type="text" name="especificoStub[tamanhoImagemX]" value="{$arquivo.metadata.tamanhoImagemX}" size=5/>
            </td>
    </tr>
    <tr>
            <td class="el-upload-general-right">
              Altura:
            </td>
                
            <td>
                <input type="text" name="especificoStub[tamanhoImagemY]" value="{$arquivo.metadata.tamanhoImagemY}" size=5/>
            </td>
    </tr>
    <tr>
            <td class="el-upload-general-right">
               Audio:
            :</td>
                
            <td>
               <select name="especificoStub[temAudio]">
                    <option value="1" {if $arquivo.metadata.temAudio eq 1}selected{/if}>Sim</option>
                    <option value="0" {if $arquivo.metadata.temAudio eq 0}selected{/if}>Não</option>
                </select>
            </td>
    </tr>
    <tr>
            <td class="el-upload-general-right">
               Cor:
            </td>
                
            <td>
                <select name="especificoStub[temCor]">
                    <option value="1" {if $arquivo.metadata.temCor eq 1}selected{/if}>Sim</option>
                    <option value="0" {if $arquivo.metadata.temCor eq 0}selected{/if}>Não</option>
                </select>
            </td>
    </tr>
    <tr>
            <td class="el-upload-general-right">
                Idioma do Vídeo:
            </td>
                
            <td>
                <input type="text" name="especificoStub[idiomaVideo]" value="{$arquivo.metadata.idiomaVideo}" size=20/>
            </td>
    </tr>
    <tr>
            <td class="el-upload-general-right">
               Legenda:
            </td>
                
            <td>
                <select name="especificoStub[legendas]">
                    <option value="1" {if $arquivo.metadata.legendas eq 1}selected{/if}>Sim</option>
                    <option value="0" {if $arquivo.metadata.legendas eq 0}selected{/if}>Não</option>
                    </select>
            </td>
    </tr>
    <tr>
            <td class="el-upload-general-right">
                Idioma da Legenda:
            </td>
                
            <td>
                <input type="text" name="especificoStub[idiomaLegenda]" value="{$arquivo.metadata.idiomaLegenda}" size=20/>
            </td>
    </tr>

    <tr>
            <td colspan="2">
                Ficha Técnica:
           <br>
                <textarea name="especificoStub[fichaTecnica]" cols="50" rows="15">{$arquivo.metadata.fichaTecnica}</textarea>
            </td>
    </tr>
    


		
</table>