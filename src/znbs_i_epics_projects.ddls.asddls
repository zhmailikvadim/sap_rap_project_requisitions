@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Epic developers'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZNBS_I_EPICS_PROJECTS
  as select from znbs_i_epic     as ep
    inner join   znbs_i_projects as prj on ep.ProjectUUID = prj.ProjectUUID
{
  key ep.ProjectUUID  as ProjectUUID,
  key ep.EpicUUID     as EpicUUID,
      prj.SemanticID  as ProjectSemanticID,
      prj.Description as ProjectDescription
}
