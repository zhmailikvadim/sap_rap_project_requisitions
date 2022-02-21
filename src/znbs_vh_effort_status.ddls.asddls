@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Value Help for Effort Status'
@Metadata.ignorePropagatedAnnotations: true

define view entity ZNBS_VH_EFFORT_STATUS
  as select from znbs_prj_status
{
      @UI.hidden: true
      @ObjectModel.text.element: ['Projectstatus']
  key projectstatusid as ProjectstatusId,
      @UI.hidden: true  
      statustype      as Statustype,
      @UI.hidden: true
      flowposition    as Flowposition,
      projectstatus   as Projectstatus

}

where
  statustype = 'Effort Status'
