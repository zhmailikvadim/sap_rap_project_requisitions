@AbapCatalog.sqlViewName: 'ZNBS_Q_PARTNERS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Partners View'
define view znbs_i_partners as select from znbs_partners {
    key uuid as Uuid,
    type as Type,
    name as Name,
    description as Description,
    email as Email
}
