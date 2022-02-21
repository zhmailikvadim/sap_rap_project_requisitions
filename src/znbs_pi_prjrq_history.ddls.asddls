@AbapCatalog.sqlViewName: 'ZNBSIPRJRQH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Project Requesition History'
define view ZNBS_PI_PRJRQ_HISTORY as select from ZNBS_I_PRJ_RQ 
  association [0..1] to ZNBS_I_PRJ_STATUS as _ProjectSt on  $projection.ProjectStatusID = _ProjectSt.ProjectStatusID
                                                        and $projection.EffortStatusID  = _ProjectSt.ProjectStatusID
  association [0..1] to ZNBS_I_EMPLOYEE   as _Employee  on  $projection.ProjectManagerID = _Employee.EmployeeID
                                                        and $projection.TechnicalSMEID   = _Employee.EmployeeID
                                                        and $projection.NovartisSMEID    = _Employee.EmployeeID
                                                        and $projection.FunctionalExpertID = _Employee.EmployeeID
                                                        and $projection.TechnicalExpertID = _Employee.EmployeeID
  association [0..*] to ZNBS_I_PRJ_RQ_CHDO as _ProjectChangeDocument
                                                        on $projection.ProjectID = _ProjectChangeDocument.projectid                                          
{
    key ProjectUUID,
    ProjectID,
    ProjectDescription,
    ProjectStatusID,
    ProjectStatus,
    ProjectStartDate,
    ProjectEndDate,
    ProposedDevStartDate,
    ProposedDevEndDate,
    ProjectManagerID,
    ProjectManager,
    TechnicalSMEID,
    TechnicalSME,
    NovartisSMEID,
    NovartisSME,
    RqEffortDate,
    SbEffortDate,
    TotalApprovedEffort,
    ConsumedEffort,
    RemainingEffort,
    EffortStatusID,
    DevStatusID,
    SOWNumber,
    FunctionalExpertID,
    FunctionalExpert,
    TechnicalExpertID,
    TechnicalExpert,
    RtQMilestone,
    HCMilestone,
    Comments,
    CLS22Milestone1,
    CLS21Milestone2,
    CLS22Milestone2,
    CLS21Milestone1,
    EffortResponse,
    EffortType,
    RequestorComments,
    BPComments,
    Notification1,
    Notification2,
    ModifiedBy,
    ItemType,
    Path,
    
//    _ProjectChangeDocument.f_old,
//    _Employee.Name,
    
    /* Associations */
    _Employee,
    _ProjectSt,
    _ProjectChangeDocument
}
