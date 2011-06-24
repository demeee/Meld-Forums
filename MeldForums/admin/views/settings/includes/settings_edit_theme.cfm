<cfsilent>
	<cfset local.rc = rc>
</cfsilent>
<cfoutput>
	<div id="msTabs-Theme">
		<h3>#local.rc.mmRBF.key('theme')#</h3>
		<ul class="form">
			<li class="first">
				<label for="settingsbean_themeID">
					<a href="##" class="tooltip"><span>#local.rc.mmRBF.key('theme','tip')#</span>#local.rc.mmRBF.key('theme')#</a>
				</label>
				<select name="settingsbean_themeID" id="settingsbean_themeID">
				<cfloop from="1" to="#arrayLen(local.rc.aThemes)#" index="local.iiX">
					<option value="#local.rc.aThemes[local.iiX].getThemeID()#"<cfif local.rc.aThemes[local.iiX].getThemeID() eq form.settingsbean_themeID> SELECTED</cfif>>#local.rc.aThemes[local.iiX].getName()#</option>
				</cfloop>
				</select>
			</li>
		</ul>
	</div>
</cfoutput>