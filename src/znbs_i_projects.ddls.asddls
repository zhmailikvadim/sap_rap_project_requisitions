@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projects View'
define root view entity znbs_i_projects
  as select from znbs_projects

  composition [0..*] of znbs_i_epic          as _Epic
  composition [0..*] of ZNBS_I_PRJ_TEAMS     as _Teams
  association [0..*] to ZNBS_I_DEVELOPER_FOR_PROJECT    as _Devs on $projection.ProjectUUID = _Devs.ProjectUUID

  association [0..1] to ZNBS_VH_REPORTED_BY  as _ReportedBy  on $projection.Reportedby = _ReportedBy.Uuid
  association [0..1] to ZNBS_VH_TICKET_OWNER as _TicketOwner on $projection.Ticketowner = _TicketOwner.Uuid
  association [0..1] to ZNBS_VH_STATUSES     as _Statuses    on $projection.Projectstatus = _Statuses.Uuid
  association [0..1] to ZNBS_VH_SUBSTATUSES  as _SubStatuses on $projection.Projectsubstatus = _SubStatuses.Uuid
  association [0..1] to ZNBS_VH_CATEGORY1    as _Category1   on $projection.Category1 = _Category1.Uuid
  association [0..1] to ZNBS_VH_CATEGORY1    as _Category2   on $projection.Category2 = _Category2.Uuid
  association [0..1] to ZNBS_VH_CATEGORY1    as _Category3   on $projection.Category3 = _Category3.Uuid
  association [0..1] to ZNBS_VH_CATEGORY1    as _Category4   on $projection.Category4 = _Category4.Uuid
  association [0..1] to ZNBS_VH_SYSTEMS      as _Systems     on $projection.Configurationitem = _Systems.Uuid


{
  key uuid                       as ProjectUUID,
      semanticid                 as SemanticID,
      description                as Description,
      effort                     as Effort,
      reportedby                 as Reportedby,
      ticketowner                as Ticketowner,
      projectstatus              as Projectstatus,
      projectsubstatus           as Projectsubstatus,
      configurationitem          as Configurationitem,
      category1                  as Category1,
      category2                  as Category2,
      category3                  as Category3,
      category4                  as Category4,

      @Semantics.systemDateTime.createdAt: true
      cast(created as timestamp preserving type) as Created,

      @Semantics.systemDateTime.lastChangedAt: true
      cast(changed as timestamp preserving type) as Changed,
      
      dueby                      as Dueby,
      

      _Epic,
      _ReportedBy,
      _TicketOwner,
      _Statuses,
      _SubStatuses,
      _Category1,
      _Category2,
      _Category3,
      _Category4,
      _Systems,
      _Teams,
      _Devs


}
