/*
<!---
||MELDFORUMSLICENSE||
--->
*/
function doShowHide( src,tgt ) {
	if ( $("#"+src).is(':checked') ) {
		$("#"+tgt).show();
	}
	else {
		$("#"+tgt).hide();
	}
}
function doClickShowHide( tgt,act,editor ) {
	if ( $("#"+tgt).is(':hidden') || act == true ) {
		$("#"+tgt).show();
		if( editor.length ) {
			jQuery('#'+editor).ckeditor({
				toolbar:'Summary',
				height:'120',
	     		customConfig : 'config.js.cfm'},
	     		htmlEditorOnComplete
	     	);
		}
	}
	else {
		$("#"+tgt).hide();
	}
}

$(document).ready(function() {

	var doVal = true;

	meldvalidate = function( frm ) {
		if(!doVal) {
			return true;
		}
		else if (validate(frm)) {
			return true;
		}
		else {
			return false;
		}
	}

/*
	jQuery.each(jQuery("#friendlyShowHide .text"), function() {
		if(jQuery(this).val().length > 0) {
			jQuery(this).parent().show();
		}		
	});
*/

	$(":submit","#meld-edit-form").click(function() {

		if($(this).attr('id') == 'btsave') {
		}
		else if($(this).attr('id') == 'btupdate') {
			doVal=true;
		}
		else if ($(this).attr('id') == 'btcancel') {
			doVal=false;
			return true;			
		}
		else if ($(this).attr('id') == 'btdelete') {
			var $dialog = $("<div>" + $(this).attr('data-message') + "</div>");
			doVal=false;

			$dialog.dialog("destroy");

			$dialog.dialog({
				resizable: false,
				height: 140,
				modal: true,
				dialogClass: 'ui-state-highlight',
				title: $(this).attr('data-title'),
				buttons: {
					"Cancel": function(){
						$(this).dialog('close');
					},
					"Delete": function(){
						$('#btdeleteconfirm').val('delete');
						$('#meld-edit-form').submit();
					}
				}
			});
			return false;
		}
	});
});
