function doShowHide( src,tgt ) {
	if ( $("#"+src).is(':checked') ) {
		$("#"+tgt).show();
	}
	else {
		$("#"+tgt).hide();
	}
}
function doConfirmDelete( frm,msg,tgt,val ) {
	var $form	= $("#"+frm);
	var $tgt	= $("#"+tgt);
	
	if( confirm(msg) ) {
		$tgt.val( val );
		$form.submit();
		return true;
	}
	return false;
}
function doSetAction(act) {
	$("#action").val(act);
	return true;
}
$(document).ready(function() {
	doShowHide('doAddAdminMessage','iMessage');
	
	$('#doAddAdminMessage').click(function() {
		if ( $(this).is(':checked') ) {
			$("#iMessage").show();
		}
		else {
			$("#iMessage").hide();
		}
	});
	
});