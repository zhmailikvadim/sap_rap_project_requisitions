@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Project Manager view'

define root view entity ZNBS_I_PRJ_MANAGER
  as select from znbs_prj_manager
{
  key projectmanagerid as ProjectManagerID,
      projectmanager   as ProjectManager
}
