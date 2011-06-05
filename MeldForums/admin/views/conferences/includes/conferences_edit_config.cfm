<cfsilent>
	<cfset local.rc = rc>
</cfsilent>
<cfoutput>
	<div id="msTabs-Config">
		<h3>#local.rc.mmRBF.key('configuration')#</h3>
		<ul class="form">
			<li class="first">
				<label for="conferencebean_name">#local.rc.mmRBF.key('configuration')#<a href="##" class="tooltip"><span>#local.rc.mmRBF.key('configuration','tip')#</span>&nbsp;</a></label>
				<select name="conferencebean_configurationid">
					<option value="">#local.rc.mmRBF.key('inherit')#</option>
					<cfloop from="1" to="#ArrayLen(local.rc.aConfiguration)#" index="local.iiX">
						<option value="#local.rc.aConfiguration[local.iiX].getConfigurationID()#" <cfif local.rc.aConfiguration[local.iiX].getConfigurationID() eq form.conferencebean_configurationid>SELECTED</cfif>>#local.rc.aConfiguration[local.iiX].getName()#</option>
					</cfloop>
				</select>
			</li>
		</ul>
	</div>
</cfoutput>