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

$(document).ready(function() {
	doShowHide('doAddAdminMessage','iMessage');	
});