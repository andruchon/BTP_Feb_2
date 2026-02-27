@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'HCM - Master'
@Metadata.allowExtensions: true
define root view entity Z_C_HCM_MASTER1979
  as projection on Z_I_HCM_MASTER1979
{
      @ObjectModel.text.element: [ 'EmployeeName' ]
  key ENumber      as EmployeeNumber,
      EName        as EmployeeName,
      EDepartment  as EmployeeDepartment,
      Status       as EmployeeStatus,
      JobTittle,
      StartDate,
      EndDate,
      Email,
      @ObjectModel.text.element: [ 'ManagerName' ]
      MNumber      as ManagerNumber,
      MName        as ManagerName,
      MDepartment  as ManagerDepartment,
      @Semantics.systemDateTime.createdAt: true
      CreaDateTime as CreatedOn,
      @Semantics.user.createdBy: true
      CreaUname    as CreatedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      LchgDateTime as ChangedOn,
      @Semantics.user.lastChangedBy: true
      LchgUname    as ChangedBy
}
