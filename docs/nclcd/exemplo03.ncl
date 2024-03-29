<?xml version="1.0" encoding="ISO-8859-1"?>

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 !   EXEMPLO 03
 !
 !   Objetivo: Reproduzir dois v�deos em seq��ncia, numa mesma 
 !             regi�o da tela.
 !
 !   Caracter�sticas:
 !
 !   - sincronismo: t�rmino de uma m�dia -> in�cio de outra
 !   - intera��o do usu�rio: nenhuma
 !
 !   Prepara��o:
 !
 !   Para executar este exemplo, � necess�rio ter as seguintes 
 !   m�dias no subdiret�rio media a partir do caminho do 
 !   arquivo NCL:
 !
 !   1) arquivo de v�deo chamado abertura.mpg
 !   2) arquivo de v�deo chamado paubrasil.mpg
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 !  CABE�ALHO NCL:
 !  define as URIs dos esquemas da NCL
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<ncl id="exemplo03" 
     xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">


<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 !  CABE�ALHO DO PROGRAMA
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

   <head>

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 !  BASE DE REGI�ES:
 !  define as regi�es na tela onde as m�dias s�o apresentadas
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<regionBase>
   <region id="rgTV" width="100%" height="100%"> 
      <region id="rgVideo1" top="25%" left="25%"
              width="50%" height="50%" />
   </region>
</regionBase>

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 !  BASE DE DESCRITORES:
 !  define como as m�dias s�o apresentadas
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<descriptorBase>
   <descriptor id="dVideo1" region="rgVideo1">
      <descriptorParam name="soundLevel" value="1" />
   </descriptor>
</descriptorBase>

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 !  BASE DE CONECTORES:
 !  definem o comportamento dos elos
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<connectorBase>
   <importBase alias="connectors" documentURI="exemplo03.conn"/>
</connectorBase>

</head>

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 !  CORPO DO PROGRAMA:
 !   define as m�dias e estrutura do programa
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<body>

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 !  PONTO DE ENTRADA:
 !  indica o componente onde o programa inicia
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<port id="pInicio" component="video1" />

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 !  M�DIAS:
 !  define o local dos arquivos de m�dia e as associa com seus 
 !  descritores
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<media type="video/mpeg" id="video1" src="media/abertura.mpg" 
       descriptor="dVideo1" />
<media type="video/mpeg" id="video2" src="media/passaro.mpg" 
       descriptor="dVideo1" />

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 !  ELOS
 !  define os elos que regem o sincronismo entre as m�dias
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<!-- video2 deve ser iniciado quando video1 terminar -->

<link id="lVideo1Video2Start" xconnector="connectors#onEndStart">
   <bind component="video1" role="onEnd" />
   <bind component="video2" role="start" />
</link>

</body>

</ncl>
