<cfsilent>
	<cfset local.rc = rc>
</cfsilent>
<cfoutput>
	<div id="msTabs-Config">
		<h3>#local.rc.mmRBF.key('configuration')#</h3>
		<ul class="form">
			<li class="first">
				<label for="forumbean_name">#local.rc.mmRBF.key('configurationname')#<a href="##" class="tooltip"><span>#local.rc.mmRBF.key('configurationname','tip')#</span>&nbsp;</a></label>
				<select name="forumbean_configurationid">
					<option value="">#local.rc.mmRBF.key('inherit')#</option>
					<cfloop from="1" to="#ArrayLen(local.rc.aConfiguration)#" index="local.iiX">
						<option value="#local.rc.aConfiguration[local.iiX].getConfigurationID()#"<cfif local.rc.aConfiguration[local.iiX].getConfigurationID() eq form.forumbean_configurationid>SELECTED</cfif>>#local.rc.aConfiguration[local.iiX].getName()#</option>
					</cfloop>
				</select>
			</li>
		</ul>
	</div>
</cfoutput>