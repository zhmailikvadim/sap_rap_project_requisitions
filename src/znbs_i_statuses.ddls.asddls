@AbapCatalog.sqlViewName: 'ZNBS_Q_STATUSES'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Statuses view'
define view znbs_i_statuses as select from znbs_statuses {
    key uuid as Uuid,
    type as Type,
    name as Name,
    flowposition as Flowposition
}
