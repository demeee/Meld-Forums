<cfsilent>
</cfsilent>
<cfoutput>
<cfdump var="#form#">
<!--- page navigation --->

<!---<cfmodule template="module/md_forum_pagenav.cfm" local="#local#" class="first">--->
search!!!
<!---
<table class="mf-forum-block mf-forum-threads mf-forum-search">
<!--- page navigation --->
	<!--- forum header --->
		<cfinclude template="#rc.MFBean.getThemeRootDirectory()#event/e_md_forum.cfm">
		<cfif len(local.eventContent['forumheader'])>
			#local.eventContent['forumheader']#
		<cfelse>
			<cfmodule template="module/md_forum.cfm" local="#local#">
		</cfif>
	<!--- threads --->
	<cfloop from="1" to="#ArrayLen(local.aThread)#" index="iiY">
		<cfif not local.aThread[iiY].getIsDisabled() or rc.MeldForumsBean.userHasModeratePermissions()>
			<cfset local.threadBean = local.aThread[iiY] />
			<cfinclude template="#rc.MFBean.getThemeRootDirectory()#event/e_md_forum_thread.cfm">
			<cfmodule template="module/md_forum_thread.cfm" local="#local#" count="#ArrayLen(local.aThread)#" row="#iiY#">
		</cfif>
	</cfloop>
</table>
--->

<!--- page navigation --->
<!---<cfmodule template="module/md_forum_pagenav.cfm" local="#local#" class="first">--->
</cfoutput>