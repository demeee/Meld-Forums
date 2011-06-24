<cfcomponent extends="controller">

	<cffunction name="before" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">
		<cfset super.before( argumentCollection=arguments ) />
	</cffunction>

	<cffunction name="default" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">
	
		<cfset doGetUser( argumentCollection=arguments ) />
	</cffunction>

	<cffunction name="view" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">
	
		<cfset doGetUser( argumentCollection=arguments ) />
	</cffunction>

	<cffunction name="edit" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">
	
		<cfset doGetUser( argumentCollection=arguments ) />
	</cffunction>

	<cffunction name="doGetUser"  access="private" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfset var settingsManager	= getBeanFactory().getBean("MeldForumsSettingsManager") />
		<cfset var aIntercept		= rc.MFBean.getIntercept() />
		<cfset var userBean			= "" />
		
		<cfif ArrayLen(aIntercept) gte 3 and rc.mmUtility.isUUID( aIntercept[3] )>
			<cfset userBean = rc.MFBean.getUserCache().getUser(aIntercept[3]) />
		<cfelse>
			<cfset userBean = rc.MFBean.getUserCache().getUser("00000000-0000-0000-0000000000000001") />
		</cfif>
		
		<cfset rc.userBean	= userBean />
		<cfset rc.view		= aIntercept[2] />
		<cfset rc.userID	= aIntercept[3] />
	</cffunction>	
</cfcomponent>