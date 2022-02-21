@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Value Help for Technical SME'
@Metadata.ignorePropagatedAnnotations: true

define view entity ZNBS_VH_TECHNICAL_SME
  as select from znbs_employee as TechnicalSME
{
      @UI.hidden: true
  key employeeid as EmployeeId,
      @UI.hidden: true
      roleid     as Roleid,
      name       as Name
}
where
  roleid = '00000000000000000002'
