@AccessControl.authorizationCheck: #CHECK
@Search.searchable: true
@EndUserText.label: 'Project Req. View'

define root view entity ZNBS_I_PRJ_RQ
  as select from znbs_prj_rq as ProjectReq

  association [0..1] to ZNBS_VH_PRJ_STATUS        as _ProjectStatus    on $projection.ProjectStatusID = _ProjectStatus.ProjectstatusId

  association [0..1] to ZNBS_VH_DEV_STATUS        as _DevStatus        on $projection.DevStatusID = _DevStatus.ProjectstatusId

  association [0..1] to ZNBS_VH_EFFORT_STATUS     as _EffortStatus     on $projection.EffortStatusID = _EffortStatus.ProjectstatusId

  association [0..1] to ZNBS_VH_PROJECT_MANAGER   as _ProjectManager   on $projection.ProjectManagerID = _ProjectManager.EmployeeId

  association [0..1] to ZNBS_VH_TECHNICAL_SME     as _TechnicalSME     on $projection.TechnicalSMEID = _TechnicalSME.EmployeeId

  association [0..1] to ZNBS_VH_NOVARTIS_SME      as _NovartisSME      on $projection.NovartisSMEID = _NovartisSME.EmployeeId

  association [0..1] to ZNBS_VH_FUNCTIONAL_EXPERT as _FunctionalExpert on $projection.FunctionalExpertID = _FunctionalExpert.EmployeeId

  association [0..1] to ZNBS_VH_TECHNICAL_EXPERT  as _TechnicalExpert  on $projection.TechnicalExpertID = _TechnicalExpert.EmployeeId
  
{
  key projectuuid                  as ProjectUUID,
      projectid                    as ProjectID,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      projectdescription           as ProjectDescription,
      projectstatusid              as ProjectStatusID,
      _ProjectStatus.Projectstatus as ProjectStatus,
      projectstartdate             as ProjectStartDate,
      projectenddate               as ProjectEndDate,
      proposeddevstartdate         as ProposedDevStartDate,
      proposeddevenddate           as ProposedDevEndDate,
      projectmanagerid             as ProjectManagerID,
      projectmanager               as ProjectManager,
      technicalsmeid               as TechnicalSMEID,
      technicalsme                 as TechnicalSME,
      novartissmeid                as NovartisSMEID,
      novartissme                  as NovartisSME,
      rqeffortdate                 as RqEffortDate,
      sbeffortdate                 as SbEffortDate,
      totalapprovedeffort          as TotalApprovedEffort,
      effortstatusid               as EffortStatusID,
      _EffortStatus.Projectstatus  as EffortStatus,
      consumedeffort               as ConsumedEffort,
      remainingeffort              as RemainingEffort,
      devstatusid                  as DevStatusID,
      _DevStatus.Projectstatus     as DevStatus,
      sownumber                    as SOWNumber,
      functionalexpertid           as FunctionalExpertID,
      functionalexpert             as FunctionalExpert,
      technicalexpertid            as TechnicalExpertID,
      technicalexpert              as TechnicalExpert,
      rtqmilestone                 as RtQMilestone,
      hcmilestone                  as HCMilestone,
      comments                     as Comments,
      cls22milestone1              as CLS22Milestone1,
      cls21milestone2              as CLS21Milestone2,
      cls22milestone2              as CLS22Milestone2,
      cls21milestone1              as CLS21Milestone1,
      effortresponse               as EffortResponse,
      efforttype                   as EffortType,
      requestorcomments            as RequestorComments,
      bpcomments                   as BPComments,
      notification1                as Notification1,
      notification2                as Notification2,
      modifiedby                   as ModifiedBy,
      itemtype                     as ItemType,
      path                         as Path,

      _ProjectStatus,
      _DevStatus,
      _EffortStatus,
      _ProjectManager,
      _TechnicalSME,
      _NovartisSME,
      _FunctionalExpert,
      _TechnicalExpert


}
