@AbapCatalog.sqlViewName: 'ZNBS_Q_SYSTEMS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Systems View'
define view ZNBS_I_SYSTEMS as select from znbs_systems {
    key uuid as Uuid,
    systemids as Systemids
}
