@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Epic View'

define root view entity ZNBS_I_EPIC_SEPARATE
  as select from znbs_epic as EpicSeparate
  composition [0..*] of ZNBS_I_TASK_SEPARATE as _TaskSeparate
  association [0..1] to ZNBS_VH_DEVELOPER    as _Developer  on $projection.Developer = _Developer.DeveloperUUID
  association [0..1] to ZNBS_VH_EPICSTATUS   as _EpicStatus on $projection.EpicStatus = _EpicStatus.Uuid
  association [1] to znbs_i_projects   as _Projects on $projection.ProjectUUID = _Projects.ProjectUUID
{
  key epicuuid                                   as EpicUUID,
      projectuuid                                as ProjectUUID,
      semanticid                                 as SemanticID,
      epicdescription                            as EpicDescription,
      epicstatus                                 as EpicStatus,
      @Semantics.systemDateTime.createdAt: true
      cast(created as timestamp preserving type) as Created,
      @Semantics.systemDateTime.lastChangedAt: true
      cast(changed as timestamp preserving type) as Changed,
      dueby                                      as Dueby,
      mptstatus                                  as MPTStatus,
      ddnumber                                   as DDNumber,
      fsnumber                                   as FSNumber,
      developer                                  as Developer,

      _TaskSeparate,
      _Developer,
      _EpicStatus,
      _Projects

}
