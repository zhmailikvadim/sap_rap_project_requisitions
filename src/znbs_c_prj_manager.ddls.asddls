@EndUserText.label: 'Project Manager projection'
@AccessControl.authorizationCheck: #CHECK
@UI: {
  headerInfo: { typeName: 'Project Manager',
                typeNamePlural: 'Project Managers',
                title: { type: #STANDARD, label: 'Project Manager', value: 'ProjectManagerID' } } }
define root view entity ZNBS_C_PRJ_MANAGER
  as projection on ZNBS_I_PRJ_MANAGER
{
      @UI.facet: [ { id:              'ProjectManager',
                                     purpose:         #STANDARD,
                                     type:            #IDENTIFICATION_REFERENCE,
                                     label:           'Project Manager',
                                     position:        10 }]

      @UI: {   lineItem:       [ { position: 10 } ],
            identification: [ { position: 10 } ],
            selectionField: [ { position: 10 } ] }
  key ProjectManagerID,
      @UI: {   lineItem:       [ { position: 20 } ],
                    identification: [ { position: 20 } ],
                    selectionField: [ { position: 20 } ] }
      ProjectManager
}
