@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Developers projection'
@Search.searchable: true
@UI: {
  headerInfo: { typeName: 'Developer',
                typeNamePlural: 'Developers',
                title: { type: #STANDARD, label: 'DeveloperName', value: 'DeveloperName' } },
                 presentationVariant: [{ sortOrder: [{ by: 'DeveloperName', 
                    direction: #ASC }], visualizations: [{type: #AS_LINEITEM}] }]  }
define root view entity ZNBS_C_DEVELOPER_SEPARATE
  provider contract transactional_query
  as projection on ZNBS_I_DEVELOPER_SEPARATE
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
                         position: 10 },
                         
                       { id: 'Epics',
                          purpose: #STANDARD,
                          type: #LINEITEM_REFERENCE,
                          label: 'Epics',
                          position: 20,
                          targetElement: '_DeveloperEpics' },

                       { id: 'Profiles',
                           purpose: #STANDARD,
                           type: #LINEITEM_REFERENCE,
                           label: 'Profiles',
                           position: 30,
                           targetElement: '_DeveloperProfiles' }

      
                           ]

          @UI.hidden: true
  key     DeveloperUUID,

          @UI: {   lineItem:       [ { position: 2 ,criticality: 'criticalityEpics', criticalityRepresentation: #WITHOUT_ICON } ],
                identification: [ { position: 2 ,criticality: 'criticalityEpics'} ],
                fieldGroup: [ { qualifier: 'General_Data', position: 2,criticality: 'criticalityEpics'}],
                selectionField: [ { position: 2 } ] }
          @Search.defaultSearchElement: true
          DeveloperName,

          @UI: {   lineItem:       [ { position: 5 , label:'Epics',criticality: 'criticalityEpics'} ],
          identification: [ { position: 170 , label:'Epics',criticality: 'criticalityEpics'} ],
          fieldGroup: [ { qualifier: 'General_Data', position: 170, label:'Epics',criticality: 'criticalityEpics'}] }
          @ObjectModel.virtualElementCalculatedBy: 'ZCL_FOR_VIRTUALS_DEVELOPER_SEP'
  virtual epics              : znbs_quantity,

          @UI: {   lineItem:       [ { position: 7 , label:'EpicsOverdue',criticality: 'criticalityOverDue'} ],
          identification: [ { position: 180 , label:'EpicsOverdue'} ],
          fieldGroup: [ { qualifier: 'General_Data', position: 180, label:'EpicsOverdue'}] }
          @ObjectModel.virtualElementCalculatedBy: 'ZCL_FOR_VIRTUALS_DEVELOPER_SEP'
  virtual epics_overdue      : znbs_quantity,
  
            @UI: {   lineItem:       [ { position: 9 , label:'Tasks',criticality: 'criticalityEpics'} ],
          identification: [ { position: 190 , label:'Tasks',criticality: 'criticalityEpics'} ],
          fieldGroup: [ { qualifier: 'General_Data', position: 190, label:'Tasks',criticality: 'criticalityEpics'}] }
          @ObjectModel.virtualElementCalculatedBy: 'ZCL_FOR_VIRTUALS_DEVELOPER_SEP'
  virtual tasks              : znbs_quantity,

          @UI: {   lineItem:       [ { position: 11 , label:'TasksOverdue',criticality: 'criticalityTaskOverDue'} ],
          identification: [ { position: 200 , label:'TasksOverdue',criticality: 'criticalityTaskOverDue'} ],
          fieldGroup: [ { qualifier: 'General_Data', position: 200, label:'TasksOverdue',criticality: 'criticalityTaskOverDue'}] }
          @ObjectModel.virtualElementCalculatedBy: 'ZCL_FOR_VIRTUALS_DEVELOPER_SEP'
  virtual tasks_overdue      : znbs_quantity,

          @UI: {   lineItem:       [ { position: 20 } ],
            identification: [ { position: 20 } ],
            fieldGroup: [ { qualifier: 'General_Data', position: 20}],
            selectionField: [ { position: 20 } ] }
          @Search.defaultSearchElement: true
          DeveloperDescription,

          @UI: {   lineItem:       [ { position: 30 } ],
            identification: [ { position: 30 } ],
            fieldGroup: [ { qualifier: 'General_Data', position: 30}],
            selectionField: [ { position: 30 } ] }
          @Search.defaultSearchElement: true
          DeveloperEmail,

          @UI: {   lineItem:       [ { position: 40 , label: 'Created'} ],
            identification: [ { position: 40 , label: 'Created'} ],
            fieldGroup: [ { qualifier: 'General_Data', position: 40, label: 'Created'}] }
          Created,

          @UI: {   lineItem:       [ { position: 50 , label: 'Changed' } ],
            identification: [ { position: 50, label: 'Changed' } ],
            fieldGroup: [ { qualifier: 'General_Data', position: 50, label: 'Changed'}]}
          Changed,

          @ObjectModel.virtualElementCalculatedBy: 'ZCL_FOR_VIRTUALS_DEVELOPER_SEP'
  virtual criticalityOverDue : znbs_quantity,
           @Consumption.valueHelpDefinition: [{entity: {name: 'ZNBS_VH_PROJECT', element: 'ProjectUUID' }}]    
           @ObjectModel.virtualElementCalculatedBy: 'ZCL_FOR_VIRTUALS_DEVELOPER_SEP'
  virtual criticalityEpics : znbs_quantity,
          @ObjectModel.virtualElementCalculatedBy: 'ZCL_FOR_VIRTUALS_DEVELOPER_SEP'
  virtual criticalityTaskOverDue : znbs_quantity,
           @ObjectModel.virtualElementCalculatedBy: 'ZCL_FOR_VIRTUALS_DEVELOPER_SEP'
  virtual criticalityTasks : znbs_quantity,  
  
          /* Associations */
          _DeveloperEpics    : redirected to composition child ZNBS_C_DEVELOPER_EPICS,
          _DeveloperProfiles : redirected to composition child ZNBS_C_DEVELOPER_PROFILES
}
