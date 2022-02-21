@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Project Status'
@ObjectModel.resultSet.sizeCategory: #XS

define root view entity ZNBS_I_PRJ_STATUS
  as select from znbs_prj_status as ProjectStatus
{
      @ObjectModel.text.element: ['ProjectStatus']
  key projectstatusid as ProjectStatusID,
      statustype      as StatusType,
      flowposition    as ProcessFlowPosition,
      projectstatus   as ProjectStatus
}
