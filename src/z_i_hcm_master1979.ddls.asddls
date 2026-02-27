@AbapCatalog.sqlViewName: 'ZV_HCM_1979LOG'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'HCM - Master'
//@Metadata.ignorePropagatedAnnotations: true
define root view Z_I_HCM_MASTER1979
  as select from zhcm_master1979 as HCMMaster
{
  key e_number       as ENumber,
      e_name         as EName,
      e_department   as EDepartment,
      status         as Status,
      job_tittle     as JobTittle,
      start_date     as StartDate,
      end_date       as EndDate,
      email          as Email,
      m_number       as MNumber,
      m_name         as MName,
      m_department   as MDepartment,
      crea_date_time as CreaDateTime,
      crea_uname     as CreaUname,
      lchg_date_time as LchgDateTime,
      lchg_uname     as LchgUname
}
