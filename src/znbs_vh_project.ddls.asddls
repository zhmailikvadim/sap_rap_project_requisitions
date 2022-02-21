@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value help for Category1'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZNBS_VH_PROJECT
  as select from znbs_i_projects
{
      @UI.hidden: true
      @ObjectModel.text.element: ['SemanticID', 'Description']
  key ProjectUUID,
      SemanticID,
      Description,
      Projectstatus
}
where _Statuses.Name <> 'Closed'
