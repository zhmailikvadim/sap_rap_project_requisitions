@AbapCatalog.sqlViewName: 'ZNBS_Q_PARTNRERS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Partners Consumption View'
define view ZNBS_C_PARTNRERS
  as select from znbs_i_partners
{
      @UI.hidden: true
  key Uuid,
      @UI: {   lineItem:       [ { position: 10 } ],
              identification: [ { position: 10 } ],
              selectionField: [ { position: 10 } ] }
      @Search: { defaultSearchElement: true, fuzzinessThreshold: 0.7 }
      Type,

      @UI: {   lineItem:       [ { position: 20 } ],
          identification: [ { position: 20 } ]
      }
      @Search: { defaultSearchElement: true, fuzzinessThreshold: 0.7 }
      Name,
      @UI: {   lineItem:       [ { position: 30 } ],
          identification: [ { position: 30 } ] }
      @Search: { defaultSearchElement: true, fuzzinessThreshold: 0.7 }
      Description,
      @UI: {   lineItem:       [ { position: 40 } ],
          identification: [ { position: 40 } ] }
      @Search: { defaultSearchElement: true, fuzzinessThreshold: 0.7 }
      Email
}
