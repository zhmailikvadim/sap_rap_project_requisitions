@AbapCatalog.viewEnhancementCategory: [#NONE]
@EndUserText.label: 'Employee view'
@AccessControl.authorizationCheck: #CHECK
define root view entity ZNBS_I_EMPLOYEE
  as select from znbs_employee as Employee
  association [0..1] to ZNBS_I_ROLE as _Role on $projection.RoleID = _Role.RoleID

{
  key employeeid as EmployeeID,
      roleid     as RoleID,
      name       as Name,

      _Role
}
