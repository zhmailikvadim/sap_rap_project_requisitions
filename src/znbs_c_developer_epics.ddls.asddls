@EndUserText.label: 'Developer epics projection'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Search.searchable: true
define view entity ZNBS_C_DEVELOPER_EPICS
  as projection on ZNBS_I_DEVELOPER_EPICS
{

          @UI.facet: [ { id:  'Epic',
                         purpose:         #STANDARD,
                         type:            #COLLECTION,
                         label:           'Epic',
                         position:        10 },

                       { id: 'General_Data',
                         type: #FIELDGROUP_REFERENCE,
                         label: 'General Data',
                         parentId: 'Epic',
                         targetQualifier: 'General_Data',
                         position: 10 }
                         //,

//                       { id: 'Tasks',
//                      purpose: #STANDARD,
//                      type: #LINEITEM_REFERENCE,
//                      label: 'Tasks',
//                      position: 20,
//                      targetElement: '_Task' }
                      ]
          @UI.hidden: true
  key     EpicUUID,

          @UI: {   lineItem:       [ { position: 5, label:'Project ID' } ],
                identification: [ { position: 5, label:'Project ID'} ],
                fieldGroup: [ { qualifier: 'General_Data', position: 5, label:'Project ID'}],
                selectionField: [ { position: 5 } ] }
          @Consumption.valueHelpDefinition: [{entity: {name: 'ZNBS_VH_PROJECT', element: 'ProjectUUID' }}]
          @Search: { defaultSearchElement: true, fuzzinessThreshold: 0.7 }
          @ObjectModel.text.element:['_Projects.SemanticID']
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
          EpicDescription,

          @UI: {   lineItem:       [ { position: 30, label:'Epic Status' } ],
                identification: [ { position: 30, label:'Epic Status'} ],
                fieldGroup: [ { qualifier: 'General_Data', position: 30, label:'Epic Status'}],
                selectionField: [ { position: 30 } ] }
          @Consumption.valueHelpDefinition: [{entity: {name: 'ZNBS_VH_EPICSTATUS', element: 'Uuid' }}]
          @Search: { defaultSearchElement: true, fuzzinessThreshold: 0.7 }
          @ObjectModel.text.element:['_EpicStatus.Name']
          EpicStatus,


          @UI: {   lineItem:       [ { position: 45 , label: 'Developer' } ],
                identification: [ { position: 45 , label: 'Developer' } ],
                fieldGroup: [ { qualifier: 'General_Data', position: 45 , label: 'Developer'}],
                selectionField: [ { position: 45 } ] }
          @Consumption.valueHelpDefinition: [{entity: {name: 'ZNBS_VH_DEVELOPER', element: 'DeveloperUUID' }}]
          @Search.defaultSearchElement: true
          Developer,

          @UI: {   lineItem:       [ { position: 70 } ],
                identification: [ { position: 70 } ],
                fieldGroup: [ { qualifier: 'General_Data', position: 70}],
                selectionField: [ { position: 70 } ] }
          Dueby,

          @UI: {   lineItem:       [ { position: 50, label:'Created'} ],
                identification: [ { position: 50 , label:'Created'} ],
                fieldGroup: [ { qualifier: 'General_Data', position: 50, label:'Created'}],
                selectionField: [ { position: 50 } ] }
          Created,
          @UI: {   lineItem:       [ { position: 60 , label:'Changed'} ],
                identification: [ { position: 60 , label:'Changed'} ],
                fieldGroup: [ { qualifier: 'General_Data', position: 60, label:'Changed'}],
                selectionField: [ { position: 60 } ] }
          Changed,

          @UI: {   lineItem:       [ { position: 80 } ],
                identification: [ { position: 80 } ],
                fieldGroup: [ { qualifier: 'General_Data', position: 80}],
                selectionField: [ { position: 80 } ] }

          DDNumber,
          @UI: {   lineItem:       [ { position: 100 } ],
                identification: [ { position: 100 } ],
                fieldGroup: [ { qualifier: 'General_Data', position: 100}],
                selectionField: [ { position: 100 } ] }
          FSNumber,


          @ObjectModel.virtualElementCalculatedBy: 'ZCL_CALC_VIRTUALS_EPIC'
  virtual dueby_days             : abap.int4,

          @ObjectModel.virtualElementCalculatedBy: 'ZCL_CALC_VIRTUALS_EPIC'
  virtual dueby_days_criticality : abap.int1,

          @UI: {   lineItem:       [ { position: 5 , criticality: 'dueby_days_criticality', label:'MPT Status'} ],
           identification: [ { position: 170 , criticality: 'dueby_days_criticality', label:'MPT Status'} ],
           fieldGroup: [ { qualifier: 'General_Data', position: 170, criticality: 'dueby_days_criticality', label:'MPT Status'}] }
          @ObjectModel.virtualElementCalculatedBy: 'ZCL_CALC_VIRTUALS_EPIC'
  virtual dueby_char             : abap.char( 25 ),

      /* Associations */
      _DeveloperSeparate : redirected to parent ZNBS_C_DEVELOPER_SEPARATE,
      _EpicStatus,
      _Projects
}
