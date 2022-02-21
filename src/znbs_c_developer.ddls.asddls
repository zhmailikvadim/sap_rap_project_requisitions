@EndUserText.label: 'Developer projection'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@UI: {
  headerInfo: { typeName: 'Developer',
                typeNamePlural: 'Developer',
                title: { type: #STANDARD, label: 'Developer', value: 'DeveloperUUID' } } }
define root view entity ZNBS_C_DEVELOPER
provider contract transactional_query
  as projection on ZNBS_I_DEVELOPER
{
 @UI.facet: [ { id:              'Developer',
                                     purpose:         #STANDARD,
                                     type:            #IDENTIFICATION_REFERENCE,
                                     label:           'Developer',
                                     position:        10 }]
@UI.hidden: true
  key DeveloperUUID,
  @UI: {   lineItem:       [ { position: 10 } ],
              identification: [ { position: 10 } ],
              selectionField: [ { position: 10 } ] }
      DeveloperName,
      @UI: {   lineItem:       [ { position: 20 } ],
                  identification: [ { position: 20 } ],
                  selectionField: [ { position: 20 } ] }
      DeveloperDescription,
      @UI: {   lineItem:       [ { position: 30 } ],
                  identification: [ { position: 30 } ],
                  selectionField: [ { position: 30 } ] }
      DeveloperEmail
}
