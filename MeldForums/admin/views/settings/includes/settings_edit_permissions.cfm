<cfsilent>
	<cfset local.rc = rc>
</cfsilent>
<cfoutput>
	<div id="msTabs-Permissions">
		<h3>#local.rc.mmRBF.key('permissions')#</h3>
		<ul class="form">
			<li class="first">
				<label for="settingsbean_permissiongroups">#local.rc.mmRBF.key('permissiongroups')#<a href="##" class="tooltip"><span>#local.rc.mmRBF.key('permissiongroups','tip')#</span>&nbsp;</a></label>
				<select name="settingsbean_permissiongroups" size="8" multiple="multiple" class="multiSelect" id="settingsbean_permissiongroups">
				<optgroup label="#htmlEditFormat(local.rc.mmRBF.key('globalsettings'))#">
					<option value="RestrictAll" <cfif form.settingsbean_permissiongroups eq 'RestrictAll'>selected</cfif>>#local.rc.mmRBF.key('restrictall')#</option>
				</optgroup>
				<cfif local.rc.qGroupsPublic.recordcount>
					<optgroup label="#local.rc.mmRBF.key('membergroups')#">
						<cfloop query="local.rc.qGroupsPublic">
						<option value="#groupname#" <cfif listfind(form.settingsbean_permissiongroups,groupname)>selected</cfif>>#groupname#</option>
						</cfloop>
					</optgroup>
				</cfif>
				<cfif local.rc.qGroupsPrivate.recordcount>
					<optgroup label="#local.rc.mmRBF.key('admingroups')#">
						<cfloop query="local.rc.qGroupsPrivate">
						<option value="#groupname#" <cfif listfind(form.settingsbean_permissiongroups,groupname)>selected</cfif>>#groupname#</option>
						</cfloop>
					</optgroup>
				</cfif>
			</select>
			</li>
		</ul>
	</div>
</cfoutput>