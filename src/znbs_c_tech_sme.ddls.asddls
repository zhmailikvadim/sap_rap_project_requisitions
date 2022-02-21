@EndUserText.label: 'Technical SME projection'
@AccessControl.authorizationCheck: #CHECK
@UI: {
  headerInfo: { typeName: 'Technical SME',
                typeNamePlural: 'Technical SME',
                title: { type: #STANDARD, label: 'Technical SME', value: 'TechnicalSMEID' } } }
define root view entity ZNBS_C_TECH_SME
  as projection on ZNBS_I_TECH_SME
{
      @UI.facet: [ { id:              'TechnicalSME',
                                           purpose:         #STANDARD,
                                           type:            #IDENTIFICATION_REFERENCE,
                                           label:           'Technical SME',
                                           position:        10 }]

      @UI: {   lineItem:       [ { position: 10 } ],
            identification: [ { position: 10 } ],
            selectionField: [ { position: 10 } ] }
  key TechnicalSMEID,
      @UI: {   lineItem:       [ { position: 20 } ],
                  identification: [ { position: 20 } ],
                  selectionField: [ { position: 20 } ] }
      TechnicalSME
}
