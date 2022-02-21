@AbapCatalog.sqlViewName: 'ZNBS_Q_CATEG'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Categories View'
define view znbs_i_categories as select from znbs_categories {
    key uuid as Uuid,
    type as Type,
    name as Name
}
