@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Developer Profiles view'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZNBS_I_DEVELOPER_PROFILES
  as select from znbs_dev_profs
  association to parent ZNBS_I_DEVELOPER_SEPARATE as _DeveloperSeparate on $projection.Developeruuid = _DeveloperSeparate.DeveloperUUID
  association[0..1] to znbs_i_profiles as _Profile on $projection.Profileuuid = _Profile.Profileuuid
{

  key uuid                                       as Uuid,
      developeruuid                              as Developeruuid,
      profileuuid                                as Profileuuid,
      @Semantics.systemDateTime.createdAt: true
      cast(created as timestamp preserving type) as Created,
      @Semantics.systemDateTime.lastChangedAt: true
      cast(changed as timestamp preserving type) as Changed,

      _DeveloperSeparate,
      _Profile

}
