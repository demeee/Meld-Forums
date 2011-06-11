<!---
||MELDFORUMSELICENSE||
--->
<cfcomponent extends="mura.plugin.pluginGenericEventHandler">

	<cffunction name="renderPluginDisplayObject" access="private" returntype="any" output="false">
		<cfargument name="object" type="string" required="true" />
		<cfargument name="event" type="component" required="true" />
		
		<cfset var rValue = super(argumentCollection=arguments) />
		<cfreturn rValue /> 
	</cffunction>

	<cffunction name="onApplicationLoad">
		<cfargument name="$">
		<cfset variables.pluginConfig.addEventHandler(this)>
	</cffunction>

<!---
	<cffunction name="onMeldForumsPostSignatureRender">
		<cfargument name="$">
	
		<cfset var sStr = "" />
		<cfsavecontent variable="sStr">
		<cfoutput>
		<p>This is the signature of #$.currentUser('screenname')#</p>
		#$.currentUser('signature')#
		</cfoutput>			
		</cfsavecontent>
		<cfreturn sStr />
	</cffunction>
--->

<!---
	<cffunction name="onMeldForumsForumThreadIconRender">
		<cfargument name="$">
	
		<cfset var sStr = "" />
		<cfsavecontent variable="sStr">
<cfoutput><div style="width: 30px;height: 30px" class="mf-block-icon type#$.event().getValue('threadBean').getTypeID()#"</div></cfoutput>			
		</cfsavecontent>
		<cfreturn sStr />
	</cffunction>
--->

<!---
	<cffunction name="onMeldForumsAttachmentRender" output="false">
		<cfargument name="$">
		<cfset variables.count = variables.count+1 />
				
		<cfreturn "#createUUID()#<br>"/>		
	</cffunction>
--->
	<!---
	EXAMPLE: 
	
	replaces default image attachment rendering with custom rendering
	--->
	<!---
	<cffunction name="onMeldForumsAttachmentRender">
		<cfargument name="$">
		
		<cfset var attach	= $.event('attachment') />
		<cfset var file		= $.event('file') />
		<cfset var rContent = "" />
		<cfset var image1	= "" />
		<cfset var image2	= "" />

		<cfset variables.count = variables.count+1 />


		<cfif file.contentType eq 'image'>
			<cfset image1 = $.createHREFForImage(siteid=file.siteID,fileid=file.fileID,fileExt=file.fileExt,width=100,height=50) />
			<cfset image2 = $.createHREFForImage(siteid=file.siteID,fileid=file.fileID,fileExt=file.fileExt,width=200,height=100) />
	
			<cfsavecontent variable="rContent">
				<cfoutput><img src="#image1#"><p>[#image1#]</p></cfoutput>
				<cfoutput><img src="#image2#"><p>[#image2#]</p></cfoutput>
			</cfsavecontent>
			<cfreturn rContent />
		</cfif>
		
	</cffunction>
--->
	<cffunction name="onRenderStart">
		<cfargument name="$">

		<cfset var app 					= variables.pluginConfig.getApplication() />
		<cfset var beanFactory			= app.getValue('beanFactory') />
		<cfset var meldForumsManager	= "" />
		<cfset var isForums				= false />

		<cfif isSimpleValue(beanFactory)>
			<cfreturn />
		</cfif>

		<cfset meldForumsManager		= beanFactory.getBean('MeldForumsManager') />
		<cfset isForums					= meldForumsManager.hasForums( $,variables.pluginConfig.getModuleID(),$.content().getContentHistID() ) />

		<cfif not isForums>
			<cfreturn>
		<cfelse>
			<!---<cfset meldForumsManager.setBreadCrumbs( $ ) />--->
		</cfif>				
	</cffunction>

	<cffunction name="getFrameworkConfig" output="false">
		<cfset var framework = StructNew() />

		<cfinclude template="../../frameworkConfig.cfm" />
		<cfreturn framework />		
	</cffunction>
</cfcomponent>