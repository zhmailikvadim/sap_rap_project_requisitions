@EndUserText.label: 'Task Projection'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@Search.searchable: true
@UI: {
  headerInfo: { typeName: 'Task',
                typeNamePlural: 'Tasks',
                title: { type: #STANDARD, label: 'Task', value: 'TaskUUID' } } }

define view entity ZNBS_C_TASK_SEPARATE
  as projection on ZNBS_I_TASK_SEPARATE
{


          @UI.facet: [ { id:  'Task',
                             purpose:         #STANDARD,
                             type:            #COLLECTION,
                             label:           'Task',
                             position:        10 },

                           { id: 'General_Data',
                             type: #FIELDGROUP_REFERENCE,
                             label: 'General Data',
                             parentId: 'Task',
                             targetQualifier: 'General_Data',
                             position: 10 }]
          @UI.hidden: true
  key     TaskUUID,
          @UI.hidden: true
          EpicUUID,
          //@UI.hidden: true
          ProjectUUID,
          @UI: {   lineItem:       [ { position: 10 } ],
                identification: [ { position: 10 } ],
                fieldGroup: [ { qualifier: 'General_Data', position: 10}],
                selectionField: [ { position: 10 } ] }
          SemanticID,
          @UI: {   lineItem:       [ { position: 20 } ],
                identification: [ { position: 20 } ],
                fieldGroup: [ { qualifier: 'General_Data', position: 20}],
                selectionField: [ { position: 20 } ] }
          TaskDescription,
          
          @UI: {   lineItem:       [ { position: 30, label:'Status'  } ],
                identification: [ { position: 30, label:'Status' } ],
                fieldGroup: [ { qualifier: 'General_Data', position: 30, label:'Status'}],
                selectionField: [ { position: 30 } ] }
          @Consumption.valueHelpDefinition: [{entity: {name: 'ZNBS_VH_EPICSTATUS', element: 'Uuid' }}]
          @Search: { defaultSearchElement: true, fuzzinessThreshold: 0.7 }
          @ObjectModel.text.element:['TaskStatus_Name']
          TaskStatus,
          
          @UI: {   lineItem:       [ { position: 40 , label:'Created'} ],
                identification: [ { position: 40 , label:'Created'} ],
                fieldGroup: [ { qualifier: 'General_Data', position: 40,  label:'Created'}],
                selectionField: [ { position: 40 } ] }
          Created,
          @UI: {   lineItem:       [ { position: 50, label:'Changed' } ],
                identification: [ { position: 50 , label:'Changed'} ],
                fieldGroup: [ { qualifier: 'General_Data', position: 50, label:'Changed'}],
                selectionField: [ { position: 50 } ] }
          Changed,
          @UI: {   lineItem:       [ { position: 60 } ],
                identification: [ { position: 60 } ],
                fieldGroup: [ { qualifier: 'General_Data', position: 60}],
                selectionField: [ { position: 60 } ] }
          DueBy,

          @ObjectModel.virtualElementCalculatedBy: 'ZCL_CALC_VIRTUALS_TASK'
  virtual dueby_days             : abap.int4,

          @ObjectModel.virtualElementCalculatedBy: 'ZCL_CALC_VIRTUALS_TASK'
  virtual dueby_days_criticality : abap.int1,

          @UI: {   lineItem:       [ { position: 5 , criticality: 'dueby_days_criticality', label:'MPT Status'} ],
           identification: [ { position: 170 , criticality: 'dueby_days_criticality', label:'MPT Status'} ],
           fieldGroup: [ { qualifier: 'General_Data', position: 170, criticality: 'dueby_days_criticality', label:'MPT Status'}] }
          @ObjectModel.virtualElementCalculatedBy: 'ZCL_CALC_VIRTUALS_TASK'
  virtual dueby_char             : abap.char( 25 ),


          _EpicSeparate     : redirected to parent ZNBS_C_EPIC_SEPARATE,
 //         _Projects : redirected to ZNBS_C_PROJECTS,
          _TaskStatus.Name as TaskStatus_Name
}
