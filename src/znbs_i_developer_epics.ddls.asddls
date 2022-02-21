@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Epic View'

define  view entity ZNBS_I_DEVELOPER_EPICS
  as select from znbs_epic as EpicSeparate
  association to parent ZNBS_I_DEVELOPER_SEPARATE   as _DeveloperSeparate  on $projection.Developer = _DeveloperSeparate.DeveloperUUID
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

      _DeveloperSeparate,
      _EpicStatus,
      _Projects

}
