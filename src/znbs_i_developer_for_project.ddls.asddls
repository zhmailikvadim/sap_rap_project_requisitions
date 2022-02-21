@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Developers BO View'
@ObjectModel.resultSet.sizeCategory: #XS

define view entity ZNBS_I_DEVELOPER_FOR_PROJECT
  as select distinct from znbs_developer  as Dev
    inner join   znbs_i_epic     as Epic on Dev.developeruuid = Epic.Developer
    inner join   znbs_i_projects as Prj  on Prj.ProjectUUID = Epic.ProjectUUID
  association to parent znbs_i_projects as _Projects on $projection.ProjectUUID = _Projects.ProjectUUID

{
      @ObjectModel.text.element: ['DeveloperName']
  key Dev.developeruuid        as DeveloperUUID,
      Dev.developername        as DeveloperName,
      Dev.developerdescription as DeveloperDescription,
      Dev.developeremail       as DeveloperEmail,
      Prj.ProjectUUID          as ProjectUUID,
      _Projects
}
