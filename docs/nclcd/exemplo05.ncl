<?xml version="1.0" encoding="ISO-8859-1"?>

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 !   EXEMPLO 05
 !
 !   Objetivo: Reproduzir um v?deo numa regi?o da tela, 
 !   sincronizando com trechos de legenda.
 !
 !   Caracter?sticas:
 !
 !   - sincronismo: simples (de in?cio e t?rmino de m?dias)
 !   - intera??o do usu?rio: nenhuma
 !
 !   Prepara??o:
 !
 !   Para executar este exemplo, ? necess?rio ter as seguintes 
 !   m?dias no subdiret?rio m?dia a partir do caminho do arquivo 
 !   NCL:
 !
 !   1) arquivo de v?deo chamado rio.mpg
 !   2) um ?nico arquivo HTML chamado legendas.html, com tr?s 
 !      legendas, cada qual num elemento DIV (com IDs legenda01,
 !      legenda02 e legenda03, respectivamente)
 !
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 !  CABE?ALHO NCL:
 !  define as URIs dos esquemas da NCL
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<ncl id="exemplo04" 
     xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">


<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 !  CABE?ALHO DO PROGRAMA
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<head>

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 !  BASE DE REGI?ES:
 !  define as regi?es na tela onde as m?dias s?o apresentadas
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<regionBase>
   <region id="rgTV" width="100%" height="100%"> 
      <region id="rgVideo1" left="25%" top="25%" 
              width="50%" height="50%" />
      <region id="rgLegenda" left="25%" top="75%" 
              width="50%" height="5%" />
   </region>
</regionBase>

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 !  BASE DE DESCRITORES:
 !  define como as m?dias s?o apresentadas
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<descriptorBase>
   <descriptor id="dVideo1" region="rgVideo1" />
   <descriptor id="dLegenda" region="rgLegenda">
      <descriptorParam name="border" value="none" />
   </descriptor>
</descriptorBase>

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 !  BASE DE CONECTORES:
 !  definem o comportamento dos elos
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<connectorBase>
   <importBase alias="connectors" documentURI="exemplo04.conn"/>
</connectorBase>

</head>

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 !  CORPO DO PROGRAMA:
 !   define as m?dias e estrutura do programa
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<body>

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 !  PONTO DE ENTRADA:
 !  indica o componente onde o programa inicia
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<port id="pInicio" component="video1" />

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 !  M?DIAS:
 !  define o local dos arquivos de m?dia e as associa com seus 
 !  descritores
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<media type="video/mpeg" id="video1" src="media/rio.mpg"
       descriptor="dVideo1">
   <!-- ?ncoras no v?deo que devem ser sincronizadas 
        com a legenda -->
   <area id="aVideoLegenda01" begin="5s" end="9s"/>
   <area id="aVideoLegenda02" begin="10s" end="14s"/>
   <area id="aVideoLegenda03" begin="15s" end="19s"/>
</media>

<media type="text/html" id="legenda01" 
       src="media/legendas.html#legenda01" descriptor="dLegenda"/>
<media type="text/html" id="legenda02" 
       src="media/legendas.html#legenda02" descriptor="dLegenda"/>
<media type="text/html" id="legenda03" 
       src="media/legendas.html#legenda03" descriptor="dLegenda"/>

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 !  ELOS
 !  define os elos que regem o sincronismo entre as m?dias
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<!-- in?cio da legenda 01 -->

<link id="lLegenda01_start" xconnector="connectors#onBeginStart">
   <bind component="video1" interface="aVideoLegenda01" 
         role="onBegin" />
   <bind component="legenda01" role="start" />
</link>

<!-- t?rmino da legenda 01 -->

<link id="lLegenda01_stop" xconnector="connectors#onEndStop">
   <bind component="video1" interface="aVideoLegenda01" 
         role="onEnd" />
   <bind component="legenda01" role="stop" />
</link>

<!-- in?cio da legenda 02 -->

<link id="lLegenda02_start" xconnector="connectors#onBeginStart">
   <bind component="video1" interface="aVideoLegenda02" 
         role="onBegin" />
   <bind component="legenda02" role="start" />
</link>

<!-- t?rmino da legenda 02 -->

<link id="lLegenda02_stop" xconnector="connectors#onEndStop">
   <bind component="video1" interface="aVideoLegenda02" 
         role="onEnd" />
   <bind component="legenda02" role="stop" />
</link>

<!-- in?cio da legenda 03 -->

<link id="lLegenda03_start" xconnector="connectors#onBeginStart">
   <bind component="video1" interface="aVideoLegenda03" 
         role="onBegin" />
   <bind component="legenda03" role="start" />
</link>

<!-- t?rmino da legenda 03 -->

<link id="lLegenda03_stop" xconnector="connectors#onEndStop">
   <bind component="video1" interface="aVideoLegenda03" 
         role="onEnd" />
   <bind component="legenda03" role="stop" />
</link>

</body>

</ncl>
