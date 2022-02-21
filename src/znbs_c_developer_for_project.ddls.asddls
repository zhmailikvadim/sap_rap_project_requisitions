@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Developers BO View'
@ObjectModel.resultSet.sizeCategory: #XS

define view entity ZNBS_C_DEVELOPER_FOR_PROJECT
provider contract  transactional_query
  as projection on ZNBS_I_DEVELOPER_FOR_PROJECT as Dev
{
      @UI.facet: [ { id:  'Developers',
                         purpose:         #STANDARD,
                         type:            #COLLECTION,
                         label:           'Developers',
                         position:        10 },

                       { id: 'General_Data',
                         type: #FIELDGROUP_REFERENCE,
                         label: 'General Data',
                         parentId: 'Developers',
                         targetQualifier: 'General_Data',
                         position: 20 }]
      @ObjectModel.text.element: ['DeveloperName']
  key Dev.DeveloperUUID        as DeveloperUUID,
  
      @UI: {   lineItem:       [ { position: 10 } ],
            identification: [ { position: 10 } ],
            fieldGroup: [ { qualifier: 'General_Data', position: 10}],
            selectionField: [ { position: 10 } ] }
      Dev.DeveloperName        as DeveloperName,
      
      @UI: {   lineItem:       [ { position: 20 } ],
      identification: [ { position: 20 } ],
      fieldGroup: [ { qualifier: 'General_Data', position: 20}],
      selectionField: [ { position: 20 } ] }
      Dev.DeveloperDescription as DeveloperDescription,
      
      @UI: {   lineItem:       [ { position: 30 } ],
      identification: [ { position: 30 } ],
      fieldGroup: [ { qualifier: 'General_Data', position: 30}],
      selectionField: [ { position: 30 } ] }
      Dev.DeveloperEmail       as DeveloperEmail,
      
      Dev.ProjectUUID          as ProjectUUID,
      _Projects : redirected to  ZNBS_C_PROJECTS
}
