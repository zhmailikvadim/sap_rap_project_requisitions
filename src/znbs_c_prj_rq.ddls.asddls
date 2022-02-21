@EndUserText.label: 'Project Req. Projection View'
@AccessControl.authorizationCheck: #CHECK
@Search.searchable: true
@UI: {
  headerInfo: { typeName: 'Project',
                typeNamePlural: 'Projects',
                title: { type: #STANDARD, label: 'Project', value: 'ProjectID' } } }
                           

define root view entity ZNBS_C_PRJ_RQ
  as projection on ZNBS_I_PRJ_RQ
{
      @UI.facet: [ { id:  'Project',
                     purpose:         #STANDARD,
                     type:            #COLLECTION,
                     label:           'Project',
                     position:        10 },

                   { id: 'General_Information',
                     type: #FIELDGROUP_REFERENCE,
                     label: 'General Information',
                     parentId: 'Project',
                     targetQualifier: 'General_Information',
                     position: 10 },

                    { id: 'Management_Team',
                      type: #FIELDGROUP_REFERENCE,
                      label: 'Management Team',
                      parentId: 'Project',
                      targetQualifier: 'Management_Team',
                      position: 10 },

                    { id: 'Efforts_Info',
                      type: #FIELDGROUP_REFERENCE,
                      label: 'Efforts Info',
                      parentId: 'Project',
                      targetQualifier: 'Efforts_Info',
                      position: 20 },

                    { id: 'Statuses',
                      type: #FIELDGROUP_REFERENCE,
                      label: 'Statuses',
                      parentId: 'Project',
                      targetQualifier: 'Statuses',
                      position: 30 },

                     { id:  'Other',
                       purpose:         #STANDARD,
                       type:            #COLLECTION,
                       label:           'Other',
                       position:        10 },

                     { id: 'Milestone',
                       type: #FIELDGROUP_REFERENCE,
                       label: 'Milestone',
                       parentId: 'Other',
                       targetQualifier: 'Milestone',
                       position: 10 },

                     { id: 'Other_Information',
                       type: #FIELDGROUP_REFERENCE,
                       label: 'Other Info',
                       parentId: 'Other',
                       targetQualifier: 'Other_Information',
                       position: 20 },

                     { id: 'Comment',
                       type: #FIELDGROUP_REFERENCE,
                       label: 'Comments',
                       parentId: 'Other',
                       targetQualifier: 'Comment',
                       position: 30 } ]

      @UI.hidden: true
  key ProjectUUID,
        @UI: {   lineItem:       [ { position: 10 } ],
                  identification: [ { position: 10 } ],
                  fieldGroup: [ { qualifier: 'General_Information', position: 10}],
                  selectionField: [ { position: 10 } ] }                  
      ProjectID,    
      
      
      @Search.defaultSearchElement: true
      @UI: {  lineItem:       [ { position: 20 }/* ,
           { type: #FOR_ACTION, dataAction: 'GeneratePDF', label: 'Generate PDF' } */],
          identification: [ { position: 20 }/*,
                            { type: #FOR_ACTION, dataAction: 'GeneratePDF', label: 'Generate PDF' }*/ ],
          selectionField: [ { position: 20 } ],
          fieldGroup: [ { qualifier: 'General_Information', position: 20}] }   
          
            
      ProjectDescription,
      @UI:{ lineItem:       [ { position: 30, label: 'Project Status' } ],
         identification:      [ { position: 30, label: 'Project Status' } ],
         fieldGroup: [ { qualifier: 'Statuses', position: 30, label: 'Project Status' }],
         selectionField: [ { position: 30 }]}
      @Consumption.valueHelpDefinition: [{entity: {name: 'ZNBS_VH_PRJ_STATUS', element: 'ProjectstatusId' }}]
      @Search: { defaultSearchElement: true, fuzzinessThreshold: 0.7 }
      @ObjectModel.text.element:['ProjectStatusName']
      ProjectStatusID,
      @UI: {   identification: [ { position: 40, label: 'Project Start Date' } ]}
      ProjectStartDate,
      @UI: {    identification: [ { position: 50, label: 'Project End Date' } ],
      fieldGroup: [ { qualifier: 'General_Information', position: 40,label: 'Project End Date' }]}
      ProjectEndDate,
      @UI: {   identification: [ { position: 60, label: 'Proposed Development Start Date' } ],
      fieldGroup: [ { qualifier: 'General_Information', position: 50, label: 'Proposed Development Start Date'}]}
      ProposedDevStartDate,
      @UI: { identification: [ { position: 70, label: 'Proposed Development End Date' } ],
      fieldGroup: [ { qualifier: 'General_Information', position: 60, label: 'Proposed Development End Date'}] }
      ProposedDevEndDate,          
      @UI.hidden: false
      @UI: {    lineItem:       [ { position: 85, label: 'Project ManageId' } ],
                identification: [ { position: 85, label: 'Project ManageId' } ],
                fieldGroup: [ { qualifier: 'Management_Team', position: 10, label: 'Project Manager'}]}    
      @Consumption.valueHelpDefinition: [{entity: {name: 'ZNBS_VH_PROJECT_MANAGER', element: 'EmployeeId' }}]         
      @ObjectModel.text.element: ['ProjectManagerTxt']      
      ProjectManagerID,     
      @UI: {    lineItem:       [ { position: 80, label: 'Project Manager' } ],
                identification: [ { position: 80, label: 'Project Manager' } ],
                fieldGroup: [ { qualifier: 'Management_Team', position: 10, label: 'Project Manager'}],
                selectionField: [ { position: 80 } ] }
      @Consumption.valueHelpDefinition: [{entity: {name: 'ZNBS_VH_PROJECT_MANAGER', element: 'Name' },
                                          additionalBinding: [{  element: 'Employeid', localElement: 'ProjectManagerID' }] }]                                  
      /*UI.hidden: true
      @Search.defaultSearchElement: true
      ProjectManager,  */   
      @UI.hidden: true
      TechnicalSMEID,
      @UI: {   lineItem:       [ { position: 90, label: 'Technical SME' } ],
                  identification: [ { position: 90, label: 'Technical SME' } ],
                  fieldGroup: [ { qualifier: 'Management_Team', position: 20, label: 'Technical SME'}],
                  selectionField: [ { position: 90 } ] }
      @Consumption.valueHelpDefinition: [{entity: {name: 'ZNBS_VH_TECHNICAL_SME', element: 'Name' },
                                          additionalBinding: [{  element: 'EmployeeId', localElement: 'TechnicalSMEID' }] }]
      @Search.defaultSearchElement: true
      TechnicalSME,
      @UI.hidden: true
      NovartisSMEID,
      @UI: {   lineItem:       [ { position: 100, label: 'Novartis SME' } ],
                  identification: [ { position: 100, label: 'Novartis SME' } ],
                  fieldGroup: [ { qualifier: 'Management_Team', position: 30, label: 'Novartis SME'}],
                  selectionField: [ { position: 100 } ] }
      @Consumption.valueHelpDefinition: [{entity: {name: 'ZNBS_VH_NOVARTIS_SME', element: 'Name' },
                                          additionalBinding: [{  element: 'EmployeeId', localElement: 'NovartisSMEID' }] }]
      @Search.defaultSearchElement: true
      NovartisSME,
      @UI: { identification: [ { position: 110, label: 'Date of Effort Requested' } ],
      fieldGroup: [ { qualifier: 'Efforts_Info', position: 10, label: 'Date of Effort Requested'}]}
      RqEffortDate,
      @UI: { identification: [ { position: 120, label: 'Date of Effort Submission (SME Review)' } ],
      fieldGroup: [ { qualifier: 'Efforts_Info', position: 20, label: 'Date of Effort Submission (SME Review)'}]}
      SbEffortDate,
      @UI: { identification: [ { position: 130, label: 'Total Approved Effort (MD)' } ],
      fieldGroup: [ { qualifier: 'Efforts_Info', position: 30, label: 'Date of Effort Submission (SME Review)'}]}
      TotalApprovedEffort,
      @UI: { identification: [ { position: 140, label: 'Consumed Effort (MD)' } ],
      fieldGroup: [ { qualifier: 'Efforts_Info', position: 40, label: 'Consumed Effort (MD)'}]}
      ConsumedEffort,
      @UI: { identification: [ { position: 150, label: 'Remaining Efforts' } ],
      fieldGroup: [ { qualifier: 'Efforts_Info', position: 50, label: 'Remaining Efforts'}]}
      RemainingEffort,    
      @UI: { identification: [ { position: 160, label: 'Effort Status' } ],
      fieldGroup: [ { qualifier: 'Efforts_Info', position: 60, label: 'Remaining Efforts'}]}
      @Consumption.valueHelpDefinition: [{entity: {name: 'ZNBS_VH_EFFORT_STATUS', element: 'ProjectstatusId' }}]
      @Search: { defaultSearchElement: true, fuzzinessThreshold: 0.7 }
      @ObjectModel.text.element: ['EffortStatus']
      EffortStatusID,
      @UI:{ lineItem:       [ { position: 170, label: 'Development Status(zhm_li)' } ],
      identification:      [ { position: 170, label: 'Development Status(zhm_id)' } ],
      fieldGroup: [ { qualifier: 'Statuses', position: 20, label: 'Development Status(zhm_fg)'}],
      selectionField: [ { position: 20 }]}
      @Consumption.valueHelpDefinition: [{entity: {name: 'ZNBS_VH_DEV_STATUS', element: 'ProjectstatusId' }}] /*ZHM*/
      @Search: { defaultSearchElement: true, fuzzinessThreshold: 0.7 }
      @ObjectModel.text.element: ['DevStatus']
      @UI.textArrangement: #TEXT_ONLY
      DevStatusID,
      @UI: { identification: [ { position: 170, label: 'SOW/SO Number' } ],
      fieldGroup: [ { qualifier: 'Other_Information', position: 10, label: 'SOW/SO Number'}]}
      SOWNumber,
      @UI.hidden: true
      FunctionalExpertID,
      @UI: { lineItem:       [ { position: 180, label: 'Functional Expert' } ],
             identification: [ { position: 90, label: 'Functional Expert' } ],
             fieldGroup: [ { qualifier: 'Management_Team', position: 40, label: 'Functional Expert'}] }
      @Consumption.valueHelpDefinition: [{entity: {name: 'ZNBS_VH_FUNCTIONAL_EXPERT', element: 'Name' },
                                          additionalBinding: [{  element: 'EmployeeID', localElement: 'FunctionalExpertID' }] }]
      @Search.defaultSearchElement: true
      FunctionalExpert,
      @UI.hidden: true
      TechnicalExpertID,
      @UI: { lineItem:       [ { position: 190, label: 'Technical Expert' } ],
             identification: [ { position: 100, label: 'Technical Expert' } ],
             fieldGroup: [ { qualifier: 'Management_Team', position: 50, label: 'Technical Expert'}] }
      @Consumption.valueHelpDefinition: [{entity: {name: 'ZNBS_VH_TECHNICAL_EXPERT', element: 'Name' },
                                     additionalBinding: [{  element: 'EmployeeID', localElement: 'TechnicalExpertID' }] }]
      @Search.defaultSearchElement: true
      TechnicalExpert,
      @UI: { identification: [ { position: 200, label: 'Milestone 1 (PtQ milestone)' } ],
      fieldGroup: [ { qualifier: 'Milestone', position: 20, label: 'Milestone 1 (PtQ milestone)'}]}
      RtQMilestone,
      @UI: { identification: [ { position: 210, label: 'Milestone 2 (Hyper Care)' } ],
      fieldGroup: [ { qualifier: 'Milestone', position: 30, label: 'Milestone 2 (Hyper Care)'}]}
      HCMilestone,
      @UI: { identification: [ { position: 220, label: 'Comments' } ],
      fieldGroup: [ { qualifier: 'Comment', position: 40, label: 'Comments'}]}
      Comments,
      @UI: { identification: [ { position: 230, label: 'Milestone1 CLS22' } ],
      fieldGroup: [ { qualifier: 'Milestone', position: 50, label: 'Milestone1 CLS22'}]}
      CLS22Milestone1,
      @UI: { identification: [ { position: 240, label: 'Milestone2 CSL21' } ],
      fieldGroup: [ { qualifier: 'Milestone', position: 60, label: 'Milestone2 CSL21'}]}
      CLS21Milestone2,
      @UI: { identification: [ { position: 250, label: 'Milestone2 CLS22' } ],
      fieldGroup: [ { qualifier: 'Milestone', position: 70, label: 'Milestone2 CLS22'}]}
      CLS22Milestone2,
      @UI: { identification: [ { position: 260, label: 'Milestone1 CSL21' } ],
      fieldGroup: [ { qualifier: 'Milestone', position: 80, label: 'Milestone1 CSL21'}]}
      CLS21Milestone1,
      @UI: { identification: [ { position: 270, label: 'CSL 22 Effort Response' } ],
      fieldGroup: [ { qualifier: 'Other_Information', position: 90, label: 'CSL 22 Effort Response'}]}
      EffortResponse,
      @UI: { identification: [ { position: 280, label: 'Efforts type' } ],
      fieldGroup: [ { qualifier: 'Other_Information', position: 100, label: 'Efforts type'}]}
      EffortType,
      @UI: { identification: [ { position: 290, label: 'Requestor Comments' } ],
      fieldGroup: [ { qualifier: 'Comment', position: 110, label: 'Requestor Comments'}]}
      RequestorComments,
      @UI: { identification: [ { position: 300, label: 'Business Partner Comments' } ],
      fieldGroup: [ { qualifier: 'Comment', position: 120, label: 'Business Partner Comments'}]}
      BPComments,
      @UI: { identification: [ { position: 310, label: '1st Notification' } ],
      fieldGroup: [ { qualifier: 'Other_Information', position: 130, label: '1st Notification'}]}
      Notification1,
      @UI: { identification: [ { position: 320, label: '2nd Notification' } ],
      fieldGroup: [ { qualifier: 'Other_Information', position: 140, label: '2nd Notification'}]}
      Notification2,
      @UI: { identification: [ { position: 330, label: 'Modified By' } ],
      fieldGroup: [ { qualifier: 'Other_Information', position: 150, label: 'Modified By'}]}
      ModifiedBy,
      @UI: { identification: [ { position: 340, label: 'Item Type' } ],
      fieldGroup: [ { qualifier: 'Other_Information', position: 160, label: 'Item Type'}]}
      ItemType,
      @UI: { identification: [ { position: 350, label: 'Path' } ],
      fieldGroup: [ { qualifier: 'Other_Information', position: 170, label: 'Path'}]}
      Path,

      _ProjectStatus.Projectstatus as ProjectStatusName,
      _DevStatus.Projectstatus    as DevStatus,
      _EffortStatus.Projectstatus as EffortStatus,
      _ProjectManager.Name as ProjectManagerTxt
}
