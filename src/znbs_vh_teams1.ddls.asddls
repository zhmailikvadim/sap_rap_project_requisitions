@AbapCatalog.sqlViewName: 'ZNBS_QH_TEAMS1'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value help for teams'
define view ZNBS_VH_TEAMS1
  as select from znbs_i_teams
{
      @UI.hidden: true
      @ObjectModel.text.element: ['Name']
  key Uuid,
      Name,
      Description,
      Role
}
