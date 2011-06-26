<cfsilent>
	<!--- headers --->
	<cfparam name="rc.panel" default="" />
	<cfset local.sStr = "" />
	<cfinclude template="../../includes/headers/editor.cfm">
	<cfinclude template="../../includes/headers/edit.cfm">
</cfsilent><cfoutput>
<!--- begin content --->

<div id="meld-body">
	<!-- CONTENT HERE -->
	<cfif local.rc.errors.hasErrors()>
		<cfset local.sStr = "" />
		<cfset local.event = rc.mmEvents.createEvent( rc.$ ) />
		<cfset local.event.setValue('errors',rc.errors) />
		<cfset local.sStr = rc.mmEvents.renderEvent( rc.$,"onMeldForumsRenderErrors",local.event ) />
		<cfif len(local.sStr)>
			#local.sStr#
		<cfelse>
			#view("global/inc_errors")#
		</cfif>
	</cfif>

	<cfif len(local.sStr) and rc.MFBean.userHasProfilePermissions(rc.userID)>
		#local.sStr#
	<cfelseif rc.MFBean.userHasProfilePermissions(rc.userID)>
		<div class="error">#rc.mmRBF.key('profilepanelnotfound','error')#</div>
	<cfelse>
		<cflocation url="#rc.MFBean.getProfileLink(rc.userBean)#?ecode=2020" addtoken="false" />
	</cfif>
</div>	
<!--- end content --->
</cfoutput>