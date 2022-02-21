@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Value Help for Functional Expert'
@Metadata.ignorePropagatedAnnotations: true

define view entity ZNBS_VH_FUNCTIONAL_EXPERT
  as select from znbs_employee
{
      @UI.hidden: true
  key employeeid as EmployeeId,
      @UI.hidden: true
      roleid     as Roleid,
      name       as Name
}
where
  roleid = '00000000000000000004'
