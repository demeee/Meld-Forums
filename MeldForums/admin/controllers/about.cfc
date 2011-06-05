<!---
||MELDVOLUNTEERLICENSE||
--->
<cfcomponent extends="controller">
	<cffunction name="default" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">
	</cffunction>
</cfcomponent>