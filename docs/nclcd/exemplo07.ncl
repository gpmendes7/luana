<?xml version="1.0" encoding="ISO-8859-1"?>

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 !   EXEMPLO 07
 !
 !   Objetivo: Reproduzir um v?deo numa regi?o da tela e 
 !             redimension?-lo num momento de sincroniza??o 
 !             com uma imagem
 !
 !   Caracter?sticas:
 !
 !   - sincronismo: simples (de in?cio e t?rmino de uma m?dia)
 !   - intera??o do usu?rio: nenhuma
 !
 !   Prepara??o:
 !
 !   Para executar este exemplo, ? necess?rio ter as seguintes 
 !   m?dias no subdiret?rio media a partir do caminho do
 !   arquivo NCL:
 !
 !   1) arquivo de v?deo, chamado reciclagem.mpg
 !   2) arquivo de imagem, chamado imagem1.png
 !
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 !  CABE?ALHO NCL:
 !  define as URIs dos esquemas da NCL
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<ncl id="exemplo07" 
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
      <region id="rgVideo" left="11%" top="15%" 
              width="75%" height="70%" />
      <region id="rgImagem1" left="50%" top="50%" 
              width="40%" height="40%" />
   </region>
</regionBase>

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 !  BASE DE DESCRITORES:
 !  define como as m?dias s?o apresentadas
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<descriptorBase>
   <descriptor id="dVideo" region="rgVideo">
      <descriptorParam name="soundLevel" value="1" />
   </descriptor>
   <descriptor id="dImagem1" region="rgImagem1" />
</descriptorBase>

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 !  BASE DE CONECTORES:
 !  definem o comportamento dos elos
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<connectorBase>
   <importBase alias="connectors" documentURI="exemplo07.conn"/>
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

<port id="pInicio" component="video" />

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 !  M?DIAS:
 !  define o local dos arquivos de m?dia e as associa com 
 !  seus descritores
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<media type="video/mpeg" id="video" src="media/reciclagem.mpg" 
       descriptor="dVideo">
   <!-- ?ncora no v?deo que deve sincronizar a imagem -->
   <area id="aVideoImagem1" begin="3s" end="8s"/>

   <!-- atributo que ser? manipulado pelos elos -->
   <property name="bounds" />
</media>

<media type="image/png" id="imagem1" src="media/imagem1.png" 
       descriptor="dImagem1" />

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 !  ELOS
 !  define os elos que regem o sincronismo entre as m?dias
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<!-- ?ncora do v?deo deve iniciar a exibi??o da imagem -->
<link id="Video1Imagem1_start" 
      xconnector="connectors#onBeginSetStart">
   <bind component="video" interface="aVideoImagem1" 
         role="onBegin" />
   <bind component="video" interface="bounds" role="set">
   <!-- As dimens?es de bounds s?o: left, top, width, height -->
      <bindParam name="bounds" value="8%,8%,40%,40%" />
   </bind>
   <bind component="imagem1" role="start" />
</link>

<!-- ?ncora do v?deo deve terminar a exibi??o da imagem -->
<link id="VideoImagem1_stop" 
      xconnector="connectors#onEndSetStop">
   <bind component="video" interface="aVideoImagem1"
         role="onEnd" />
   <bind component="video" interface="bounds" role="set">
      <bindParam name="bounds" value="11%,15%,75%,70%" />
   </bind>
   <bind component="imagem1" role="stop" />
</link>

</body>

</ncl>
