@AbapCatalog.sqlViewName: 'ZNBS_VHQ_REP_BY'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value help for reported by'
define view ZNBS_VH_REPORTED_BY
  as select from znbs_i_partners
{
      @UI.hidden: true
      @ObjectModel.text.element: ['Name']
  key Uuid        as Uuid,
      @UI.hidden: true
      Type        as Type,
      Name        as Name,
      Description as Description,
      Email       as Email
}
