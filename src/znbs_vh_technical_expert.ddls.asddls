@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Value Help for Tecgnical Expert'
@Metadata.ignorePropagatedAnnotations: true

define view entity ZNBS_VH_TECHNICAL_EXPERT
  as select from znbs_employee
{
      @UI.hidden: true
  key employeeid as EmployeeId,
      @UI.hidden: true
      roleid     as RoleId,
      name       as Name
}
where
  roleid = '00000000000000000005'
