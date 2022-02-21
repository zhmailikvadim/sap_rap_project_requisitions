@EndUserText.label: 'Project Status projection'
@AccessControl.authorizationCheck: #CHECK
@UI: {
  headerInfo: { typeName: 'Project Status',
                typeNamePlural: 'Project Statuses',
                title: { type: #STANDARD, label: 'Project Status', value: 'ProjectStatusID' } } }
define root view entity ZNBS_C_PRJ_STATUS
  as projection on ZNBS_I_PRJ_STATUS
{
      @UI.facet: [ { id:              'ProjectStatus',
                                purpose:         #STANDARD,
                                type:            #IDENTIFICATION_REFERENCE,
                                label:           'Project Status',
                                position:        10 }]

      @UI: {   lineItem:       [ { position: 10 } ],
            identification: [ { position: 10 } ],
            selectionField: [ { position: 10 } ] }
  key ProjectStatusID,
  
  
      @UI: {   lineItem:       [ { position: 20 } ],
                    identification: [ { position: 20 } ],
                    selectionField: [ { position: 20 } ] }
      StatusType,
      
      
      @UI: {   lineItem:       [ { position: 30 } ],
                identification: [ { position: 30 } ],
                selectionField: [ { position: 30 } ] }
      ProcessFlowPosition,
      
      
      @UI: {   lineItem:       [ { position: 40 } ],
                identification: [ { position: 40 } ],
                selectionField: [ { position: 40 } ] }      
      ProjectStatus
}
