@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projects projection'
@Search.searchable: true
@UI: {
  headerInfo: { typeName: 'Project',
                typeNamePlural: 'Projects',
                title: { type: #STANDARD, label: 'Project', value: 'SemanticID' } } ,
                
                presentationVariant: [{ sortOrder: [{ by: 'SemanticID', 
                    direction: #DESC }], visualizations: [{type: #AS_LINEITEM}] }]}

define root view entity ZNBS_C_PROJECTS
  provider contract transactional_query
  as projection on znbs_i_projects
{


          @UI.facet: [ { id:  'Project',
                         purpose:         #STANDARD,
                         type:            #COLLECTION,
                         label:           'Project',
                         position:        10 },

                       { id: 'General_Data',
                         type: #FIELDGROUP_REFERENCE,
                         label: 'General Data',
                         parentId: 'Project',
                         targetQualifier: 'General_Data',
                         position: 20 },

                        { id: 'Category',
                          type: #FIELDGROUP_REFERENCE,
                          label: 'Category',
                          parentId: 'Project',
                          targetQualifier: 'Category',
                          position: 30 },

                        { id: 'Processing_Data',
                          type: #FIELDGROUP_REFERENCE,
                          label: 'Processing Data',
                          parentId: 'Project',
                          targetQualifier: 'Processing_Data',
                          position: 40 },

                        { id: 'Project_Control',
                          type: #FIELDGROUP_REFERENCE,
                          label: 'Project Control',
                          parentId: 'Project',
                          targetQualifier: 'Project_Control',
                          position: 50 },

                        { id: 'Dates',
                          type: #FIELDGROUP_REFERENCE,
                          label: 'Dates',
                          parentId: 'Project',
                          targetQualifier: 'Dates',
                          position: 60 },

                        { id: 'ReferenceObjects',
                          type: #FIELDGROUP_REFERENCE,
                          label: 'Reference Objects',
                          parentId: 'Project',
                          targetQualifier: 'ReferenceObjects',
                          position: 70 },

                        { id: 'Epics',
                           purpose: #STANDARD,
                           type: #LINEITEM_REFERENCE,
                           label: 'Epics',
                           position: 80,
                           targetElement: '_Epic' },
                        { id: 'Teams',
                          purpose: #STANDARD,
                          type: #LINEITEM_REFERENCE,
                          label: 'Teams',
                          position: 80,
                          targetElement: '_Teams' }
                          ,

                        { id: 'Developers',
                          purpose: #STANDARD,
                          type: #LINEITEM_REFERENCE,
                          label: 'Developers',
                          position: 90,
                          targetElement: '_Devs' }
                           ]

          @UI.hidden: true
  key     ProjectUUID,


          @UI: {   lineItem:       [ { position: 10 } ],
                  identification: [ { position: 10 } ],
                  fieldGroup: [ { qualifier: 'General_Data', position: 10}],
                  selectionField: [ { position: 10 } ] }
          @Search.defaultSearchElement: true
          SemanticID,

          @UI: {   lineItem:       [ { position: 20 } ],
                  identification: [ { position: 20 } ],
                  fieldGroup: [ { qualifier: 'General_Data', position: 20}],
                  selectionField: [ { position: 20 } ] }
          @Search: { defaultSearchElement: true, fuzzinessThreshold: 0.7 }
          Description,


          @UI: {   lineItem:       [ { position: 22 , criticality: 'dueby_days_criticality', label:'MPT Status'} ],
           identification: [ { position: 170 , criticality: 'dueby_days_criticality', label:'MPT Status'} ],
           fieldGroup: [ { qualifier: 'Dates', position: 170, criticality: 'dueby_days_criticality', label:'MPT Status'}] }
          @ObjectModel.virtualElementCalculatedBy: 'ZCL_CALC_VIRTUALS_PROJECT'
  virtual dueby_char             : abap.char( 25 ),

          @UI: {   lineItem:       [ { position: 23 , label:'Epics',criticality: 'criticalityEpics'} ],
          identification: [ { position: 170 , label:'Epics',criticality: 'criticalityEpics'} ],
          fieldGroup: [ { qualifier: 'Project_Control', position: 170, label:'Epics',criticality: 'criticalityEpics'}] }
          @ObjectModel.virtualElementCalculatedBy: 'ZCL_CALC_VIRTUALS_PROJECT'
  virtual epics                  : znbs_quantity,

          @UI: {   lineItem:       [ { position: 24 , label:'EpicsOverdue',criticality: 'criticalityOverDue'} ],
          identification: [ { position: 180 , label:'EpicsOverdue'} ],
          fieldGroup: [ { qualifier: 'Project_Control', position: 180, label:'EpicsOverdue'}] }
          @ObjectModel.virtualElementCalculatedBy: 'ZCL_CALC_VIRTUALS_PROJECT'
  virtual epics_overdue          : znbs_quantity,

          @UI: {   lineItem:       [ { position: 25 , label:'No Developers',criticality: 'criticalityDevelopers'} ],
          identification: [ { position: 190 , label:'No Developers',criticality: 'criticalityDevelopers'} ],
          fieldGroup: [ { qualifier: 'Project_Control', position: 190, label:'No Developers',criticality: 'criticalityDevelopers'}] }
          @ObjectModel.virtualElementCalculatedBy: 'ZCL_CALC_VIRTUALS_PROJECT'
  virtual NoDevelopers           : znbs_quantity,


          @UI: {   lineItem:       [ { position: 26 , label:'Tasks',criticality: 'criticalityEpics',criticalityRepresentation: #WITHOUT_ICON} ],
          identification: [ { position: 190 , label:'Tasks',criticality: 'criticalityEpics',criticalityRepresentation: #WITHOUT_ICON} ],
          fieldGroup: [ { qualifier: 'Project_Control', position: 190, label:'Tasks',criticality: 'criticalityEpics',criticalityRepresentation: #WITHOUT_ICON}] }
          @ObjectModel.virtualElementCalculatedBy: 'ZCL_CALC_VIRTUALS_PROJECT'
  virtual tasks                  : znbs_quantity,

          @UI: {   lineItem:       [ { position: 27 , label:'TasksOverdue',criticality: 'criticalityTaskOverDue'} ],
          identification: [ { position: 200 , label:'TasksOverdue',criticality: 'criticalityTaskOverDue'} ],
          fieldGroup: [ { qualifier: 'Project_Control', position: 200, label:'TasksOverdue',criticality: 'criticalityTaskOverDue'}] }
          @ObjectModel.virtualElementCalculatedBy: 'ZCL_CALC_VIRTUALS_PROJECT'
  virtual tasks_overdue          : znbs_quantity,

          @UI: {   lineItem:       [ { position: 28 } ],
          identification: [ { position: 170 } ],
          fieldGroup: [ { qualifier: 'Dates', position: 170}] }
          Dueby,

          @UI: {   lineItem:       [ { position: 29 , label:'Status'} ],
          identification: [ { position: 130, label:'Status' } ],
          fieldGroup: [ { qualifier: 'Processing_Data', position: 130, label:'Status'}],
          selectionField: [ { position: 130 } ] }
          @Consumption.valueHelpDefinition: [{entity: {name: 'ZNBS_VH_STATUSES', element: 'Uuid' }}]
          @Search: { defaultSearchElement: true, fuzzinessThreshold: 0.7 }
          @ObjectModel.text.element:['StatusName']
          Projectstatus,

          @UI: {   lineItem:       [ { position: 140, label:'Sub Status' } ],
            identification: [ { position: 140 , label:'Sub Status'} ],
            fieldGroup: [ { qualifier: 'Processing_Data', position: 140, label:'Sub Status'}],
            selectionField: [ { position: 140 } ] }
          @Consumption.valueHelpDefinition: [{entity: {name: 'ZNBS_VH_SUBSTATUSES', element: 'Uuid' }}]
          @Search: { defaultSearchElement: true, fuzzinessThreshold: 0.7 }
          @ObjectModel.text.element:['SubStatusName']
          Projectsubstatus,

          @UI: {   lineItem:       [ { position: 30 } ],
                  identification: [ { position: 30 } ],
                  fieldGroup: [ { qualifier: 'General_Data', position: 30}],
                  selectionField: [ { position: 30 } ] }
          Effort,


          @UI: {   lineItem:       [ { position: 40 , label:'Reported by'} ],
                  identification: [ { position: 40 , label:'Reported by'} ],
                  fieldGroup: [ { qualifier: 'General_Data', position: 40, label:'Reported by' }],
                  selectionField: [ { position: 40 } ] }

          @Consumption.valueHelpDefinition: [{entity: {name: 'ZNBS_VH_REPORTED_BY', element: 'Uuid' }}]
          @Search: { defaultSearchElement: true, fuzzinessThreshold: 0.7 }
          @ObjectModel.text.element:['ReportedByName']
          Reportedby,

          @UI: {   lineItem:       [ { position: 45, label:'Ticket Owner' } ],
            identification: [ { position: 45, label:'Ticket Owner' } ],
            fieldGroup: [ { qualifier: 'General_Data', position: 45, label:'Ticket Owner' }],
            selectionField: [ { position: 45 } ] }
          @Consumption.valueHelpDefinition: [{entity: {name: 'ZNBS_VH_TICKET_OWNER', element: 'Uuid' }}]
          @Search: { defaultSearchElement: true, fuzzinessThreshold: 0.7 }
          @ObjectModel.text.element:['Ticket_Owner']
          Ticketowner,

          @UI: {   lineItem:       [ { position: 50 , label:'Catecory 1'} ],
            identification: [ { position: 50 , label:'Catecory 1'} ],
            fieldGroup: [ { qualifier: 'Category', position: 50, label:'Catecory 1' }]}
          @Search.defaultSearchElement: true
          @Consumption.valueHelpDefinition: [{entity: {name: 'ZNBS_VH_CATEGORY1', element: 'Uuid' }}]
          @ObjectModel.text.element:['Category1_Name']
          Category1,

          @UI: {   lineItem:       [ { position: 60 , label:'Catecory 2'} ],
            identification: [ { position: 60 , label:'Catecory 2'} ],
            fieldGroup: [ { qualifier: 'Category', position: 60, label:'Catecory 2'}]}
          @Search.defaultSearchElement: true
          @Consumption.valueHelpDefinition: [{entity: {name: 'ZNBS_VH_CATEGORY1', element: 'Uuid' }}]
          @ObjectModel.text.element:['Category2_Name']
          Category2,

          @UI: {   lineItem:       [ { position: 70, label:'Catecory 3' } ],
            identification: [ { position: 70, label:'Catecory 3' } ],
            fieldGroup: [ { qualifier: 'Category', position: 70, label:'Catecory 3'}] }
          @Search.defaultSearchElement: true
          @Consumption.valueHelpDefinition: [{entity: {name: 'ZNBS_VH_CATEGORY1', element: 'Uuid' }}]
          @ObjectModel.text.element:['Category3_Name']
          Category3,

          @UI: {   lineItem:       [ { position: 80, label:'Catecory 4' } ],
            identification: [ { position: 80, label:'Catecory 4' } ],
            fieldGroup: [ { qualifier: 'Category', position: 80, label:'Catecory 4'}]}
          @Search.defaultSearchElement: true
          @Consumption.valueHelpDefinition: [{entity: {name: 'ZNBS_VH_CATEGORY1', element: 'Uuid' }}]
          @ObjectModel.text.element:['Category4_Name']
          Category4,

          @UI: {   lineItem:       [ { position: 150 , label:'Created'} ],
            identification: [ { position: 150 , label:'Created'} ],
            fieldGroup: [ { qualifier: 'Dates', position: 150, label:'Created'}] }
          Created,

          @UI: {   lineItem:       [ { position: 160 , label:'Changed'} ],
            identification: [ { position: 160 , label:'Changed'} ],
            fieldGroup: [ { qualifier: 'Dates', position: 160, label:'Changed'}] }
          Changed,

          @ObjectModel.virtualElementCalculatedBy: 'ZCL_CALC_VIRTUALS_PROJECT'
  virtual dueby_days             : abap.int4,
          @ObjectModel.virtualElementCalculatedBy: 'ZCL_CALC_VIRTUALS_PROJECT'
  virtual dueby_days_criticality : abap.int1,
          @ObjectModel.virtualElementCalculatedBy: 'ZCL_CALC_VIRTUALS_PROJECT'
  virtual criticalityOverDue     : znbs_quantity,
          @ObjectModel.virtualElementCalculatedBy: 'ZCL_CALC_VIRTUALS_PROJECT'
  virtual criticalityEpics       : znbs_quantity,
          @ObjectModel.virtualElementCalculatedBy: 'ZCL_CALC_VIRTUALS_PROJECT'
  virtual criticalityTaskOverDue : znbs_quantity,
          @ObjectModel.virtualElementCalculatedBy: 'ZCL_CALC_VIRTUALS_PROJECT'
  virtual criticalityTasks       : znbs_quantity,
          @ObjectModel.virtualElementCalculatedBy: 'ZCL_CALC_VIRTUALS_PROJECT'
  virtual criticalityDevelopers  : znbs_quantity,

          @UI: {   lineItem:       [ { position: 180 , label:'Configuration Item'} ],
            identification: [ { position: 180 , label:'Configuration Item'} ],
            fieldGroup: [ { qualifier: 'ReferenceObjects', position: 180, label:'Configuration Item'}],
            selectionField: [ { position: 180 } ] }
          @Consumption.valueHelpDefinition: [{entity: {name: 'ZNBS_VH_SYSTEMS', element: 'Uuid' }}]
          @Search: { defaultSearchElement: true, fuzzinessThreshold: 0.7 }
          @ObjectModel.text.element:['System_Name']
          Configurationitem,



          _ReportedBy.Name   as ReportedByName,
          _TicketOwner.Name  as Ticket_Owner,
          _Statuses.Name     as StatusName,
          _SubStatuses.Name  as SubStatusName,
          _Systems.Systemids as System_Name,
          _Category1.Name    as Category1_Name,
          _Category2.Name    as Category2_Name,
          _Category3.Name    as Category3_Name,
          _Category4.Name    as Category4_Name,

          _Epic  : redirected to composition child ZNBS_C_EPIC,
          _Teams : redirected to composition child ZNBS_C_PRJ_TEAMS,
          _Devs  : redirected to ZNBS_C_DEVELOPER_FOR_PROJECT

}
