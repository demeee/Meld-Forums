/*
<!---
||MELDFORUMSLICENSE||
--->
*/

$(document).ready(function() {
	var uiShowTabArray = [];

	$(function() {
		$resized = false;
		
		$("#msTabs").tabs();
		$("#msTabs-side").tabs().addClass('ui-tabs-vertical ui-helper-clearfix');
		$("#msTabs-side li").removeClass('ui-corner-top').addClass('ui-corner-left');
		$("#msTabs-side div").removeClass('ui-corner-bottom');
		$("#msTabs-side li").removeClass('ui-corner-top').addClass('ui-corner-left');
	});
	
} );

// cEf4FD7aE2