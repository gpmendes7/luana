<?xml version="1.0" encoding="ISO-8859-1"?>

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 ! EXEMPLO 06
 !
 ! Objetivo: Reproduzir um v?deo em loop, at? que o usu?rio
 ! pressione a tecla verde para mover para o pr?ximo
 ! v?deo.
 !
 ! Caracter?sticas:
 !
 ! - sincronismo: simples (de in?cio e t?rmino de m?dias)
 ! - intera??o do usu?rio: interrup??o do v?deo para disparar
 !                         outro
 !
 ! Prepara??o:
 !
 ! Para executar este exemplo, ? necess?rio ter as seguintes 
 ! m?dias no subdiret?rio media a partir do caminho do 
 ! arquivo NCL:
 !
 ! 1) arquivo de v?deo chamado abertura.mpg, com uma introdu??o 
 !    em loop
 ! 2) arquivo de v?deo chamado reciclagem.mpg
 ! 3) arquivo de imagem chamado botao_reciclagem.png, indicando
 !    a a??o do bot?o verde
 !
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

 <!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 ! CABE?ALHO NCL:
 ! define as URIs dos esquemas da NCL
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<ncl id="exemplo06" 
     xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 ! CABE?ALHO DO PROGRAMA
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<head>

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 ! BASE DE REGI?ES:
 ! define as regi?es na tela onde as m?dias s?o apresentadas
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<regionBase>
   <region id="rgTV" width="100%" height="100%">
      <region id="rgVideo1" top="25%" left="25%"
              width="50%" height="50%" zIndex="0"/>
      <region id="rgBotaoVerde" left="28%" bottom="28%"
              width="87" height="70" zIndex="1"/>
   </region>
</regionBase>

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 ! BASE DE DESCRITORES:
 ! define como as m?dias s?o apresentadas
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<descriptorBase>
   <descriptor id="dVideo1" region="rgVideo1" />
   <descriptor id="dBotaoVerde" region="rgBotaoVerde" />
</descriptorBase>

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 ! BASE DE CONECTORES:
 ! definem o comportamento dos elos
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<connectorBase>
   <importBase alias="connectors" documentURI="exemplo06.conn"/>
</connectorBase>

</head>

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 ! CORPO DO PROGRAMA:
 ! define as m?dias e estrutura do programa
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<body>

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 ! PONTO DE ENTRADA:
 ! indica o componente onde o programa inicia
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<port id="pInicio" component="video1" />

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 ! M?DIAS:
 ! define o local dos arquivos de m?dia e as associa com seus 
 ! descritores
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<media type="video/mpeg" id="video1" src="media/abertura.mpg" 
       descriptor="dVideo1" />

<media type="video/mpeg" id="video2" src="media/reciclagem.mpg" 
       descriptor="dVideo1" />

<media type="image/png" id="botaoVerde" 
       src="media/botao_reciclagem.png" descriptor="dBotaoVerde"/>

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 ! ELOS
 ! define os elos que regem o sincronismo entre as m?dias
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<!-- in?cio do video1 deve exibir bot?es -->
<link id="lVideo1Init" xconnector="connectors#onBeginStart">
   <bind component="video1" role="onBegin" />
   <bind component="botaoVerde" role="start" />
</link>

<!-- t?rmino do video1 deve dispar?-lo novamente 
     (deve tocar em loop) -->
<link id="lVideo1Loop" xconnector="connectors#onEndStart">
   <bind component="video1" role="onEnd" />
   <bind component="video1" role="start" />
</link>

<!-- cancela a exibi??o do video1 e dispara a exibi??o 
     do video2 quando a tecla verde ? pressionada -->
<link id="lSelectBotaoVerde" 
      xconnector="connectors#onKeySelectionStartStopAbort">
   <bind component="botaoVerde" role="onSelection">
      <bindParam name="keyCode" value="GREEN" />
   </bind>
   <bind component="botaoVerde" role="stop" />
   <bind component="video1" role="abort" />
   <bind component="video2" role="start" />
</link>

</body>
</ncl>
 