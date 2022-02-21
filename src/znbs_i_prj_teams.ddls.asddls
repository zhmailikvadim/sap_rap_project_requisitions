@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Teams view'
@Metadata.ignorePropagatedAnnotations: true

define view entity ZNBS_I_PRJ_TEAMS
  as select from znbs_prj_teams as Teams
  association to parent znbs_i_projects as _Projects on $projection.ProjectUUID = _Projects.ProjectUUID
  association [0..1] to znbs_vh_teams        as _Team       on $projection.TeamID = _Team.Uuid

{
  key uuid                       as UUID,
      projectuuid                as ProjectUUID,
      teamid                     as TeamID,
      @Semantics.systemDateTime.createdAt: true
      cast(created as timestamp preserving type) as Created,
      @Semantics.systemDateTime.lastChangedAt: true
      cast(changed as timestamp preserving type) as Changed,

      _Projects,
      _Team
}
