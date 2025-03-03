using db.documento as my from '../db/Documento';

@path : '/DocumentoService'
// @(requires : 'system-user')
service DocumentoService {
   entity Documento as projection on my.Documento;
   entity EtapaDocumento as projection on my.EtapaDocumento;
   entity ProcessamentoEtapa as projection on my.ProcessamentoEtapa;
   entity TipoProcessamento as projection on my.TipoProcessamento;
   entity Etapa2Tipo as projection on my.Etapa2Tipo;
  //  entity ManagerOrdemVenda as projection on my.ManagerDocumento;

  @cds.redirection.target : false
    view qtdPorStatusDocumento as 
      select from my.Documento distinct {
        COUNT(
          *
        )as qtdPorStatus : Integer,
        status,
      }
      group by
        status;

  @cds.redirection.target : false
    view qtdPorStatusProcessamentoEtapa as 
      select from my.ProcessamentoEtapa distinct {
        COUNT(
          *
        )as qtdPorStatus : Integer,
        status,
      }
      group by
        status;


    action IniciaSchedulerEtapa(
        ID: String,
        cronExpression: String,
        etapa_ID : String,
        qtd_a_processar: Integer,
        limite_reproc: Integer,
        status_scheduler: String
        )
        returns String;
}
