@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Value Help for Project Manager'
@Metadata.ignorePropagatedAnnotations: true

define view entity ZNBS_VH_PROJECT_MANAGER
  as select from znbs_employee as ProjectManager
{
      @UI.hidden: true
      @ObjectModel.text.element: ['Name']
  key employeeid as EmployeeId,
      @UI.hidden: true
      roleid     as Roleid,
      name       as Name
}
where
  roleid = '00000000000000000001'
