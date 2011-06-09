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
				<cfinclude template="#rc.MFBean.getThemeRootDirectory()#event/e_md_editor_thread.cfm">
				<cfif len(local.eventContent['editor'])>
					#local.eventContent['editor']#
				<cfelse>
					<cfmodule template="module/md_editor_edit_thread.cfm" local="#local#" form="#form#">
				</cfif>
			</cfcase>
			<cfcase value="newpost,editpost">
				<cfinclude template="#rc.MFBean.getThemeRootDirectory()#event/e_md_editor_post.cfm">
				<cfif len(local.eventContent['editor'])>
					#local.eventContent['editor']#
				<cfelse>
					<cfmodule template="module/md_editor_post.cfm" local="#local#" form="#form#">
				</cfif>
			</cfcase>
			<cfcase value="newthread">
				<cfinclude template="#rc.MFBean.getThemeRootDirectory()#event/e_md_editor_thread.cfm">
				<cfif len(local.eventContent['editor'])>
					#local.eventContent['editor']#
				<cfelse>
					<cfmodule template="module/md_editor_thread.cfm" local="#local#" form="#form#">
				</cfif>
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