@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Role projection'
@UI: {
  headerInfo: { typeName: 'Role',
                typeNamePlural: 'Role',
                title: { type: #STANDARD, label: 'Role', value: 'RoleID' } } }
define root view entity ZNBS_C_ROLE
  as projection on ZNBS_I_ROLE
{
      @UI.facet: [ { id:              'Role',
                                     purpose:         #STANDARD,
                                     type:            #IDENTIFICATION_REFERENCE,
                                     label:           'Role',
                                     position:        10 }]

      @UI: {   lineItem:       [ { position: 10 } ],
            identification: [ { position: 10 } ],
            selectionField: [ { position: 10 } ] }
  key RoleID,
      @UI: {   lineItem:       [ { position: 20 } ],
              identification: [ { position: 20 } ],
              selectionField: [ { position: 20 } ] }
      Role
}
