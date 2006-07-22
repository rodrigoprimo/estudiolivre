var myDelay = 600;

function tooltip (txt)  {
	overlib("<div class=\'tooltipCont\'><div class=\'tooltipTop\'></div>" +
				"<div class=\'tooltipMid\'>" + txt + "</div><div class='tooltipBottom'></div>" +
			"</div>", FULLHTML, DELAY, myDelay);
	myDelay = 0;
}

function fixedTooltip (txt)  {
	overlib("<div class=\'tooltipCont\'><div class=\'tooltipTop\'></div>" +
				"<div class=\'tooltipMid\'>" + txt + "</div><div class='tooltipBottom'></div>" +
			"</div>", FULLHTML,STICKY);
}
