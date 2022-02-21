@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Role view'
@ObjectModel.resultSet.sizeCategory: #XS

define root view entity ZNBS_I_ROLE
  as select from znbs_prj_role as Role
{
      @ObjectModel.text.element: ['Role']
  key roleid as RoleID,
      role   as Role
}
