<!--
Duração: <input type="text" name="especificoStub[duracao]" value="{$arquivo.metadata.duracao}" size=5><br />
Tipo do audio: <input type="text" name="especificoStub[tipoDoAudio]" value="{$arquivo.metadata.tipoDoAudio}" size=40/><br />
bpm: <input type="text" name="especificoStub[bpm]" value="{$arquivo.metadata.bpm}" size=5/><br />
Sample Rate: <input type="text" name="especificoStub[sampleRate]" value="{$arquivo.metadata.sampleRate}" size=5/><br />
Bit Rate: <input type="text" name="especificoStub[bitRate]" value="{$arquivo.metadata.bitRate}" size=5/><br />
Gênero: <input type="text" name="especificoStub[genero]" value="{$arquivo.metadata.genero}" size=40/><br />
Álbum: <input type="text" name="especificoStub[album]" value="{$arquivo.metadata.album}" size=40/><br />

<span style="vertical-align:top">Letra:</span>
<textarea name="especificoStub[letra]" cols="50" rows="15">{$arquivo.metadata.letra}</textarea><br />
<span style="vertical-align:top">Ficha Técnica:</span>
<textarea name="especificoStub[fichaTecnica]" cols="50" rows="15">{$arquivo.metadata.fichaTecnica}</textarea><br />
-->
<table class="el-upload-general el-upload-general2">
        
    <tr>
            <td class="el-upload-general-right">
                Duração:
            :</td>
                
            <td>
                <input type="text" name="especificoStub[duracao]" value="{$arquivo.metadata.duracao}" size=5>
            </td>
    </tr>
    <tr>
            <td class="el-upload-general-right">
                Tipo do audio:
            :</td>
                
            <td>
                <input type="text" name="especificoStub[tipoDoAudio]" value="{$arquivo.metadata.tipoDoAudio}" size=40/>
            </td>
    </tr>
    <tr>
            <td class="el-upload-general-right">
               bpm: 
            :</td>
                
            <td>
                <input type="text" name="especificoStub[bpm]" value="{$arquivo.metadata.bpm}" size=5/>
            </td>
    </tr>
    <tr>
            <td class="el-upload-general-right">
                Sample Rate:
            :</td>
                
            <td>
               <input type="text" name="especificoStub[sampleRate]" value="{$arquivo.metadata.sampleRate}" size=5/>
            </td>
    </tr>
    <tr>
            <td class="el-upload-general-right">
                Bit Rate:
            :</td>
                
            <td>
                <input type="text" name="especificoStub[bitRate]" value="{$arquivo.metadata.bitRate}" size=5/>
            </td>
    </tr>
    <tr>
            <td class="el-upload-general-right">
                Gênero:
            :</td>
                
            <td>
                <input type="text" name="especificoStub[genero]" value="{$arquivo.metadata.genero}" size=40/>
            </td>
    </tr>
    <tr>
            <td class="el-upload-general-right">
                Álbum:
            :</td>
                
            <td>
                <input type="text" name="especificoStub[album]" value="{$arquivo.metadata.album}" size=40/>
            </td>
    </tr>
<tr>
            <td colspan="2" >
                Letra:
            <br>
                <textarea name="especificoStub[letra]" cols="50" rows="15">{$arquivo.metadata.letra}</textarea>
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