class Incidente {

  String titulo;
  String descricao;
  String morada;
  String dataHora;
  String estado = 'Aberto';

  @override
  String toString() {
    return '$titulo|$descricao|$morada|$dataHora|$estado';
  }
}