@EndUserText.label: 'Employee projection'
@AccessControl.authorizationCheck: #CHECK
@UI: {
  headerInfo: { typeName: 'Employee',
                typeNamePlural: 'Employees',
                title: { type: #STANDARD, label: 'Employee', value: 'EmployeeID' } } }
define root view entity ZNBS_C_EMPLOYEE
  as projection on ZNBS_I_EMPLOYEE
{
      @UI.facet: [ { id:              'Employee',
                                                 purpose:         #STANDARD,
                                                 type:            #IDENTIFICATION_REFERENCE,
                                                 label:           'Employee',
                                                 position:        10 }]

      @UI: {   lineItem:       [ { position: 10 } ],
            identification: [ { position: 10 } ],
            selectionField: [ { position: 10 } ] }
  key EmployeeID,
      @UI:{ lineItem:       [ { position: 20, label: 'Role' } ],
         identification:      [ { position: 20, label: 'Role' } ],
         selectionField: [ { position: 20 }]}
      @Consumption.valueHelpDefinition: [{entity: {name: 'ZNBS_I_ROLE', element: 'RoleID' }}]
      @Search: { defaultSearchElement: true, fuzzinessThreshold: 0.7 }
      @ObjectModel.text.element: ['Role']
      RoleID,
      @UI: {   lineItem:       [ { position: 30 } ],
                  identification: [ { position: 30 } ],
                  selectionField: [ { position: 30 } ] }
      Name,
      
      _Role.Role as Role
}
