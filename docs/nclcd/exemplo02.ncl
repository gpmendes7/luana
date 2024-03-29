<?xml version="1.0" encoding="ISO-8859-1"?>

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 !   EXEMPLO 02
 !
 !   Objetivo: Reproduzir um t�tulo e um v�deo numa regi�o da 
 !             tela, sincronizados.
 !
 !   Caracter�sticas:
 !
 !   - sincronismo: simples (de in�cio e t�rmino de uma m�dia)
 !   - intera��o do usu�rio: nenhuma
 !
 !   Prepara��o:
 !
 !   Para executar este exemplo, � necess�rio ter as seguintes 
 !   m�dias no subdiret�rio media a partir do caminho do 
 !   arquivo NCL:
 !
 !   1) arquivo HTML com o t�tulo, chamado ginga.html
 !   2) arquivo de v�deo chamado abertura.mpg
 !
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 !  CABE�ALHO NCL:
 !  define as URIs dos esquemas da NCL
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<ncl id="exemplo02" 
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
      <region id="rgTitulo1" left="25%" top="5%" width="50%" height="15%" />
      <region id="rgVideo1" left="25%" top="25%" width="50%" height="50%" />
   </region>
</regionBase>

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 !  BASE DE DESCRITORES:
 !  define como as m�dias s�o apresentadas
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<descriptorBase>
   <descriptor id="dTitulo1" region="rgTitulo1">
      <descriptorParam name="scroll" value="none" />
   </descriptor>
   <descriptor id="dVideo1" region="rgVideo1">
      <descriptorParam name="soundLevel" value="1" />
   </descriptor>
</descriptorBase>

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 !  BASE DE CONECTORES:
 !  definem o comportamento dos elos
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<connectorBase>
   <importBase alias="connectors" documentURI="exemplo02.conn" />
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
 !  define o local dos arquivos de m�dia e as associa com 
 !  seus descritores
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<media type="text/html" id="titulo1" src="media/ginga.html" 
       descriptor="dTitulo1" />
<media type="video/mpeg" id="video1" src="media/abertura.mpg" 
       descriptor="dVideo1" />

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 !  ELOS
 !  define os elos que regem o sincronismo entre as m�dias
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<!-- video1 deve ser iniciado simultaneamente a titulo1 -->

<link id="lVideo1Titulo1Start" xconnector="connectors#onBeginStart">
   <bind component="video1" role="onBegin" />
   <bind component="titulo1" role="start" />
</link>

<!-- titulo1 deve ser terminado simultaneamente a video1 -->

<link id="lVideo1Titulo1Stop" xconnector="connectors#onEndStop">
   <bind component="video1" role="onEnd" />
   <bind component="titulo1" role="stop" />
</link>

</body>

</ncl>
