@AbapCatalog.sqlViewName: 'ZNBS_Q_TEAMS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Teams View'
define view znbs_i_teams as select from znbs_teams {
    key uuid as Uuid,
    name as Name,
    description as Description,
    role as Role
}
