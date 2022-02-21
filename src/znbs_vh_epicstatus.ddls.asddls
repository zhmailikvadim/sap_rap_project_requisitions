@AbapCatalog.sqlViewName: 'ZNBS_VH_EPICST'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Search Help for Status'
@ObjectModel.resultSet.sizeCategory: #XS
define view ZNBS_VH_EPICSTATUS
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
