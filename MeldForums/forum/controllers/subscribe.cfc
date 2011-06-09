<cfcomponent extends="controller">

	<cffunction name="before" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">
		<cfset super.before( argumentCollection=arguments ) />
	</cffunction>

	<cffunction name="default" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfset var subscribeService	= getBeanFactory().getBean('subscribeService') />
		<cfset var mmUtility		= getBeanFactory().getBean("mmUtility") />
		<cfset var aIntercept		= rc.MFBean.getIntercept() />
		<cfset var subType			= aIntercept[2] />
		<cfset var subMode			= aIntercept[3] />
		<cfset var beanID			= aIntercept[4] />

		<cfif not mmUtility.isUUID(beanID)>
			<cflocation url="#rc.MFBean.getForumWebRoot()#?ecode=2501" addtoken="false" />
		<cfelseif not $.currentUser().isLoggedIn()>
			<cflocation url="#rc.MFBean.getForumWebRoot()##$.siteConfig('loginURL')#&returnUrl=#cgi.http_referer#" addtoken="false" />
		</cfif>
	
		<cfswitch expression="#subType#">
			<cfcase value="forum">
				<cfif subMode eq "remove">
					<cfset subscribeService.doUnSubscribeToForum( $.currentUser().getUserID(),beanID ) />
				<cfelse>
					<cfset subscribeService.doSubscribeToForum( $.currentUser().getUserID(),beanID ) />
				</cfif>
			</cfcase>
			<cfcase value="thread">
				<cfif subMode eq "remove">
					<cfset subscribeService.doUnSubscribeToThread( $.currentUser().getUserID(),beanID ) />
				<cfelse>
					<cfset subscribeService.doSubscribeToThread( $.currentUser().getUserID(),beanID ) />
				</cfif>
			</cfcase>
			<cfcase value="post">
				<cfif subMode eq "remove">
					<cfset subscribeService.doUnSubscribeToThread( $.currentUser().getUserID(),beanID ) />
				<cfelse>
					<cfset subscribeService.doSubscribeToThread( $.currentUser().getUserID(),beanID ) />
				</cfif>
			</cfcase>
		</cfswitch>
		
		<cflocation url="#cgi.http_referer#" addtoken="false" />
	</cffunction>
</cfcomponent>