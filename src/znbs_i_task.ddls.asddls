@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Task BO View'
@Metadata.ignorePropagatedAnnotations: true

define view entity ZNBS_I_TASK
  as select from znbs_task as Task

  association        to parent znbs_i_epic as _Epic       on $projection.EpicUUID = _Epic.EpicUUID

  association [1..1] to znbs_i_projects    as _Projects   on $projection.ProjectUUID = _Projects.ProjectUUID

  association [0..1] to ZNBS_VH_TASKSTATUS as _TaskStatus on $projection.TaskStatus = _TaskStatus.Uuid


{
  key taskuuid                                   as TaskUUID,
      epicuuid                                   as EpicUUID,
      projectuuid                                as ProjectUUID,
      semanticid                                 as SemanticID,
      taskdescription                            as TaskDescription,
      taskstatus                                 as TaskStatus,
      @Semantics.systemDateTime.createdAt: true
      cast(created as timestamp preserving type) as Created,
      @Semantics.systemDateTime.lastChangedAt: true
      cast(changed as timestamp preserving type) as Changed,
      dueby                                      as DueBy,

      _Epic,
      _Projects,
      _TaskStatus


}
