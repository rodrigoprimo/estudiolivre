<iframe name="uploadTarget{$i}" style="display:none" onLoad="finishUpload({$i});"></iframe>
	
<form name="uploadForm{$i}" target="uploadTarget{$i}" action="el-gallery_upload_file.php" method="post" enctype="multipart/form-data">
	<input type="hidden" name="UPLOAD_IDENTIFIER" value="">
	<input type="hidden" name="arquivoId" value="{$arquivoId}">
	<input type="file" name="arquivo" onChange="fileSelected(this.value);">
</form>

<div id="browseCont">
	<div id="js-statusBar{$i}" class="statusBar statusBarGoing"></div>
	<div id="js-percent{$i}" class="percent"></div>
</div>

<h4 id="js-cancel{$i}" class="pointer"></h4>