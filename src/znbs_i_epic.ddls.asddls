@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Epic View'

define view entity znbs_i_epic
  as select from znbs_epic as Epic
  association        to parent znbs_i_projects as _Projects   on $projection.ProjectUUID = _Projects.ProjectUUID
  composition [0..*] of ZNBS_I_TASK            as _Task
  
  association [0..1] to ZNBS_VH_DEVELOPER      as _Developer  on $projection.Developer = _Developer.DeveloperUUID
  association [0..1] to ZNBS_VH_EPICSTATUS     as _EpicStatus on $projection.EpicStatus = _EpicStatus.Uuid
{
  key epicuuid                   as EpicUUID,
      projectuuid                as ProjectUUID,
      semanticid                 as SemanticID,
      epicdescription            as EpicDescription,
      epicstatus                 as EpicStatus,
      @Semantics.systemDateTime.createdAt: true
      cast(created as timestamp preserving type) as Created,
      @Semantics.systemDateTime.lastChangedAt: true
      cast(changed as timestamp preserving type) as Changed,
      dueby                      as Dueby,
      mptstatus                  as MPTStatus,
      ddnumber                   as DDNumber,
      fsnumber                   as FSNumber,
      developer                  as Developer,

      _Projects,
      _Task,
      _Developer,
      _EpicStatus

}
