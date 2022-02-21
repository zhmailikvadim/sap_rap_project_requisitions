@EndUserText.label: 'Teams PROJECTION'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@Search.searchable: true

define view entity ZNBS_C_PRJ_TEAMS
  as projection on ZNBS_I_PRJ_TEAMS
{
      @UI.facet: [ { id:  'Team',
                         purpose:         #STANDARD,
                         type:            #COLLECTION,
                         label:           'Team',
                         position:        10 },

                       { id: 'General_Data',
                         type: #FIELDGROUP_REFERENCE,
                         label: 'General Data',
                         parentId: 'Team',
                         targetQualifier: 'General_Data',
                         position: 10 }]
      @UI.hidden: true
  key UUID,
      @UI.hidden: true
      ProjectUUID,
      @UI: {   lineItem:       [ { position: 10, label:'Team' } ],
            identification: [ { position: 10 , label:'Team'} ],
            fieldGroup: [ { qualifier: 'General_Data', position: 10}]}
      @Search.defaultSearchElement: true
      @Consumption.valueHelpDefinition: [{entity: {name: 'ZNBS_VH_TEAMS', element: 'Uuid' }}]
      @ObjectModel.text.element:['Team_Name','Team_Role']
      TeamID,
  
      @UI: {   lineItem:       [ { position: 15 } ],
      identification: [ { position: 15 } ],
      fieldGroup: [ { qualifier: 'General_Data', position: 15}]}
      _Team.Role,
      
      @UI: {   lineItem:       [ { position: 20, label:'Created' } ],
      identification: [ { position: 20, label:'Created' } ],
      fieldGroup: [ { qualifier: 'General_Data', position: 20, label:'Created'}]}
      Created,
      @UI: {   lineItem:       [ { position: 30, label:'Changed' } ],
      identification: [ { position: 30, label:'Changed' } ],
      fieldGroup: [ { qualifier: 'General_Data', position: 30, label:'Changed'}]}
      Changed,
      /* Associations */
      _Projects : redirected to parent ZNBS_C_PROJECTS,
      _Team.Name as Team_Name,
      _Team.Role as Team_Role
}
