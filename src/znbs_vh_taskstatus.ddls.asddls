@AbapCatalog.sqlViewName: 'ZNBS_VH_TASKST'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Search Help for Status'
@ObjectModel.resultSet.sizeCategory: #XS
define view ZNBS_VH_TASKSTATUS
  as select from znbs_i_statuses
{
      @UI.hidden: true
      @ObjectModel.text.element: ['Name']
  key Uuid,
      @UI.hidden: true
      Type,
      Name,
      @UI.hidden: true
      Flowposition
}
where
  Type = 'Status'
