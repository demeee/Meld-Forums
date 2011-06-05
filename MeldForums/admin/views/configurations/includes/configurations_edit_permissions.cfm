<cfsilent>
	<cfset local.rc = rc>
</cfsilent>
<cfoutput>
	<div id="msTabs-Permissions">
		<h3>#local.rc.mmRBF.key('permissions')#</h3>
		<ul class="form">
			<li class="first checkbox">
				<input class="checkbox" type="checkbox" name="configurationbean_doClosed" id="configurationbean_doClosed" value="1" <cfif form.configurationbean_doClosed>checked</cfif>/>
				<label for="configurationbean_doClosed">
					<a href="##" class="tooltip"><span>#local.rc.mmRBF.key('doClosed','tip')#</span>#local.rc.mmRBF.key('doClosed')#</a>
				</label>
			</li>
		</ul>
		<ul class="form">
			<li class="first">
				<a href="##" class="tooltip"><span>#local.rc.mmRBF.key('accesspermissions','tip')#</span><strong>#local.rc.mmRBF.key('accesspermissions')#</strong></a>
			</li>
			<li class="checkbox padded">
				<label for="configurationbean_dorestrictread">#local.rc.mmRBF.key('RestrictReadGroups')#</label>
				<div id="showhide-dorestrictread">
				<select name="configurationbean_RestrictReadGroups" size="8" multiple="multiple" class="multiSelect" id="configurationbean_RestrictReadGroups">
				<optgroup label="#htmlEditFormat(local.rc.mmRBF.key('globalconfiguration'))#">
					<option value="RestrictAll" <cfif form.configurationbean_RestrictReadGroups eq 'RestrictAll'>selected</cfif>>#local.rc.mmRBF.key('restrictall')#</option>
					<option value="" <cfif form.configurationbean_RestrictReadGroups eq ''>selected</cfif>>#local.rc.mmRBF.key('allowall')#</option>
				</optgroup>
				<cfif local.rc.qGroupsPublic.recordcount>
					<optgroup label="#local.rc.mmRBF.key('membergroups')#">
						<cfloop query="local.rc.qGroupsPublic">
						<option value="#groupname#" <cfif listfind(form.configurationbean_RestrictReadGroups,groupname)>selected</cfif>>#groupname#</option>
						</cfloop>
					</optgroup>
				</cfif>
				<cfif local.rc.qGroupsPrivate.recordcount>
					<optgroup label="#local.rc.mmRBF.key('admingroups')#">
						<cfloop query="local.rc.qGroupsPrivate">
						<option value="#groupname#" <cfif listfind(form.configurationbean_RestrictReadGroups,groupname)>selected</cfif>>#groupname#</option>
						</cfloop>
					</optgroup>
				</cfif>
				</select>
				</div>
			</li>
			<li class="checkbox padded">
				<label for="configurationbean_dorestrictcontribute">#local.rc.mmRBF.key('RestrictContributeGroups')#</label>
				<div id="showhide-dorestrictcontribute">
				<select name="configurationbean_RestrictContributeGroups" size="8" multiple="multiple" class="multiSelect" id="configurationbean_RestrictContributeGroups">
				<optgroup label="#htmlEditFormat(local.rc.mmRBF.key('globalconfiguration'))#">
					<option value="RestrictAll" <cfif form.configurationbean_RestrictContributeGroups eq 'RestrictAll'>selected</cfif>>#local.rc.mmRBF.key('restrictall')#</option>
					<option value="" <cfif form.configurationbean_RestrictContributeGroups eq ''>selected</cfif>>#local.rc.mmRBF.key('allowall')#</option>
				</optgroup>
				<cfif local.rc.qGroupsPublic.recordcount>
					<optgroup label="#local.rc.mmRBF.key('membergroups')#">
						<cfloop query="local.rc.qGroupsPublic">
						<option value="#groupname#" <cfif listfind(form.configurationbean_RestrictContributeGroups,groupname)>selected</cfif>>#groupname#</option>
						</cfloop>
					</optgroup>
				</cfif>
				<cfif local.rc.qGroupsPrivate.recordcount>
					<optgroup label="#local.rc.mmRBF.key('admingroups')#">
						<cfloop query="local.rc.qGroupsPrivate">
						<option value="#groupname#" <cfif listfind(form.configurationbean_RestrictContributeGroups,groupname)>selected</cfif>>#groupname#</option>
						</cfloop>
					</optgroup>
				</cfif>
				</select>
				</div>
			</li>
			<li class="checkbox padded last">
				<label for="configurationbean_dorestrictmoderate">#local.rc.mmRBF.key('RestrictModerateGroups')#</label>
				<div id="showhide-dorestrictmoderate">
					<select name="configurationbean_RestrictModerateGroups" size="8" multiple="multiple" class="multiSelect" id="configurationbean_RestrictModerateGroups">
					<optgroup label="#htmlEditFormat(local.rc.mmRBF.key('globalconfiguration'))#">
						<option value="RestrictAll" <cfif form.configurationbean_RestrictModerateGroups eq 'RestrictAll'>selected</cfif>>#local.rc.mmRBF.key('restrictall')#</option>
						<option value="" <cfif form.configurationbean_RestrictModerateGroups eq ''>selected</cfif>>#local.rc.mmRBF.key('allowall')#</option>
					</optgroup>
					<cfif local.rc.qGroupsPublic.recordcount>
						<optgroup label="#local.rc.mmRBF.key('membergroups')#">
							<cfloop query="local.rc.qGroupsPublic">
							<option value="#groupname#" <cfif listfind(form.configurationbean_RestrictModerateGroups,groupname)>selected</cfif>>#groupname#</option>
							</cfloop>
						</optgroup>
					</cfif>
					<cfif local.rc.qGroupsPrivate.recordcount>
						<optgroup label="#local.rc.mmRBF.key('admingroups')#">
							<cfloop query="local.rc.qGroupsPrivate">
							<option value="#groupname#" <cfif listfind(form.configurationbean_RestrictModerateGroups,groupname)>selected</cfif>>#groupname#</option>
							</cfloop>
						</optgroup>
					</cfif>
					</select>
				</div>
			</li>
		</ul>
	</div>
</cfoutput>