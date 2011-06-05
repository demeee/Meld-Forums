<cfsilent>
	<cfparam name="rc.quote" default="" />
	<cfset rc.mode = "#request.item##request.section#" />
</cfsilent>
<cfoutput>
	<div id="editorblock">
		<div id="title">
			<h3>#rc.mmRBF.key('Editor')#</h3>
		</div>
		<cfswitch expression="#rc.mode#">
			<cfcase value="editthread">
				<cfmodule template="module/editor_edit_thread.cfm" local="#local#" form="#form#">
			</cfcase>
			<cfcase value="newpost,editpost">
				<cfmodule template="module/editor_post.cfm" local="#local#" form="#form#">
			</cfcase>
			<cfcase value="newthread">
				<cfmodule template="module/editor_thread.cfm" local="#local#" form="#form#">
			</cfcase>
			<cfdefaultcase>
				???
			</cfdefaultcase>
		</cfswitch>
	</div>
	<script language="javascript">
	$(document).ready(function()	{
		mySettings.previewParserPath = "#rc.MFBean.getPluginWebRoot()#/?action=forum:preview";

	    $('##txtMessage').markItUp(mySettings);
	});
	</script>
</cfoutput>