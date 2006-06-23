var myDelay = 600;

function tooltip (txt)  {
	overlib("<div class=\'tooltipCont\'><img src=\'styles/estudiolivre/tooltipTop.png\'>" +
				"<div class=\'tooltipMid\'>" + txt + "</div><img src=\'styles/estudiolivre/tooltipBottom.png\'>" +
			"</div>", FULLHTML, DELAY, myDelay);
	myDelay = 0;
}

function fixedTooltip (txt)  {
	overlib("<div class=\'tooltipCont\'><img src=\'styles/estudiolivre/tooltipTop.png\'>" +
				"<div class=\'tooltipMid\'>" + txt + "</div><img src=\'styles/estudiolivre/tooltipBottom.png\'>" +
			"</div>", FULLHTML,STICKY);
}
