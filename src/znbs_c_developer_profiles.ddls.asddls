@EndUserText.label: 'Developer profiles Projection'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Search.searchable: true
define view entity ZNBS_C_DEVELOPER_PROFILES
  as projection on ZNBS_I_DEVELOPER_PROFILES
{
      @UI.facet: [ { id:  'Developer',
                     purpose:         #STANDARD,
                     type:            #COLLECTION,
                     label:           'Developer',
                     position:        10 },

                   { id: 'General_Data',
                     type: #FIELDGROUP_REFERENCE,
                     label: 'General Data',
                     parentId: 'Developer',
                     targetQualifier: 'General_Data',
                     position: 10 }]
      @UI.hidden: true
  key Uuid,
      @UI.hidden: true
      Developeruuid,

      @UI: {   lineItem:       [ { position: 10 } ],
            identification: [ { position: 10 } ],
            fieldGroup: [ { qualifier: 'General_Data', position: 10}],
            selectionField: [ { position: 10 } ] }
      @Consumption.valueHelpDefinition: [{entity: {name: 'ZNBS_VH_PROFILES', element: 'Profileuuid' }}]
      @ObjectModel.text.element: ['_Profile.Name']
      @Search: { defaultSearchElement: true, fuzzinessThreshold: 0.7 }
      Profileuuid,
      
      @UI: {   lineItem:       [ { position: 20 } ],
      identification: [ { position: 20 } ] }
      _Profile.Name,      
      
      @UI: {   lineItem:       [ { position: 30 , label:'Created'} ],
      identification: [ { position: 30, label:'Created' } ] }
      Created,
      @UI: {   lineItem:       [ { position: 40, label:'Changed' } ],
      identification: [ { position: 40 , label:'Changed'} ] }
      Changed,
      /* Associations */
      _DeveloperSeparate : redirected to parent ZNBS_C_DEVELOPER_SEPARATE,

      _Profile
}
