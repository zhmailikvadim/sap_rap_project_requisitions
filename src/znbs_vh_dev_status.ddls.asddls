@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Value Help for Development Status'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.resultSet.sizeCategory: #XS

define view entity ZNBS_VH_DEV_STATUS
  as select from znbs_prj_status
{
      @ObjectModel.text.element: ['Projectstatus']
  key projectstatusid as ProjectstatusId,
      @UI.hidden: true
      statustype      as Statustype,
      @UI.hidden: true
      flowposition    as Flowposition,
      projectstatus   as Projectstatus
}
where
  statustype = 'Development Status'
