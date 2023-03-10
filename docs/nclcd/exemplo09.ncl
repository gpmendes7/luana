<?xml version="1.0" encoding="ISO-8859-1"?>

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 !  EXEMPLO 09
 !
 !  Objetivo: Reproduzir um v?deo e permitir que o usu?rio 
 !            alterne entre dois v?deos, numa mesma regi?o da
 !            tela, atrav?s do pressionamento das teclas
 !            vermelha e verde do controle remoto. Oculta a
 !            imagem correspondente ao bot?o que n?o fizer
 !            efeito no momento.
 !
 !   Caracter?sticas:
 !
 !   - sincronismo: ponto de altern?ncia entre os v?deos
 !   - intera??o do usu?rio: sele??o do v?deo a ser exibido
 !
 !   Prepara??o:
 !
 !   Para executar este exemplo, ? necess?rio ter as seguintes
 !   m?dias no subdiret?rio media a partir do caminho do
 !   arquivo NCL:
 !
 !   1) arquivo de v?deo chamado reciclagem.mpg
 !   2) arquivo de v?deo chamado passaro.mpg
 !   3) arquivo de imagem chamado botao_passaro.gif,
 !      indicando a a??o do bot?o vermelho
 !   4) arquivo de imagem chamado botao_reciclagem.png,
 !      indicando a a??o do bot?o verde
 !
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 !  CABE?ALHO NCL:
 !  define as URIs dos esquemas da NCL
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<ncl id="exemplo09" 
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
      <region id="rgVideo1" width="50%" height="50%" 
              top="25%" left="25%" zIndex="0"/>
      <region id="rgBotaoVermelho" left="28%" bottom="28%" 
              width="87" height="70" zIndex="2" />
      <region id="rgBotaoVerde" right="28%" bottom="28%" 
              width="87" height="70" zIndex="2" />
   </region>
</regionBase>

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 !  BASE DE DESCRITORES:
 !  define como as m?dias s?o apresentadas
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<descriptorBase>
   <descriptor id="dVideo1" region="rgVideo1" />

   <descriptor id="dVideo2" region="rgVideo1">
      <descriptorParam name="visible" value="false" />
      <descriptorParam name="soundLevel" value="0"/>
   </descriptor>

   <descriptor id="dBotaoVermelho" region="rgBotaoVermelho">
      <descriptorParam name="chromaKey" value="white"/>
   </descriptor>
   <descriptor id="dBotaoVerde" region="rgBotaoVerde" />
</descriptorBase>

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 !  BASE DE CONECTORES:
 !  definem o comportamento dos elos
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<connectorBase>
   <importBase alias="connectors" documentURI="exemplo09.conn"/>
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
 !  define o local dos arquivos de m?dia e as associa com
 !  seus descritores
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<media type="video/mpeg" id="video1"
       src="media/reciclagem.mpg" descriptor="dVideo1">
   <property name="visible" />
   <property name="soundLevel" />
</media>

<media type="video/mpeg" id="video2" 
       src="media/passaro.mpg" descriptor="dVideo2">
   <property name="visible" />
   <property name="soundLevel" />
</media>

<media type="image/gif" id="botaoVermelho"
       src="media/botao_passaro.gif" descriptor="dBotaoVermelho" />
<media type="image/png" id="botaoVerde"
       src="media/botao_reciclagem.png" descriptor="dBotaoVerde" />

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
!  ELOS
!  define os elos que regem o sincronismo entre as m?dias
!++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<!-- in?cio do video1 deve disparar a exibi??o do video2, video3 e das imagens dos bot?es -->

<link id="lVideo_Botoes_start" xconnector="connectors#onBeginStartN">
   <bind component="video1" role="onBegin" />
   <bind component="video2" role="start" />
   <bind component="botaoVermelho" role="start" />
</link>


<!-- t?rmino do video1 deve terminar a exibi??o das imagens dos bot?es -->

<link id="lVideo_Botoes_stop" xconnector="connectors#onEndStopN">
   <bind component="video1" role="onEnd" />
   <bind component="video2" role="stop" />
   <bind component="botaoVerde" role="stop" />
   <bind component="botaoVermelho" role="stop" />
</link>


<!-- alterna para v?deo 2 caso a tecla vermelha seja acionada -->

<link id="lSelecionaVideo2" xconnector="connectors#onKeySelectionSetN">
   <bind component="botaoVermelho" role="onSelection">
      <bindParam name="keyCode" value="RED"/>
   </bind>
   <bind component="video1" interface="visible" role="set">
 	  <bindParam name="valueSet" value="false"/>
   </bind>
   <bind component="video1" interface="soundLevel" role="set">
 	  <bindParam name="valueSet" value="0"/>
   </bind>
   <bind component="video2" interface="visible" role="set">
 	  <bindParam name="valueSet" value="true"/>
   </bind>
   <bind component="video2" interface="soundLevel" role="set">
 	  <bindParam name="valueSet" value="1"/>
   </bind>
</link>

<!-- alterna para v?deo 3 caso a tecla verde seja acionada -->

<link id="lSelecionaVideo1" xconnector="connectors#onKeySelectionSetN">
   <bind component="botaoVerde" role="onSelection">
      <bindParam name="keyCode" value="GREEN"/>
   </bind>
   <bind component="video1" interface="visible" role="set">
 	  <bindParam name="valueSet" value="true"/>
   </bind>
   <bind component="video1" interface="soundLevel" role="set">
 	  <bindParam name="valueSet" value="1"/>
   </bind>
   <bind component="video2" interface="visible" role="set">
 	  <bindParam name="valueSet" value="false"/>
   </bind>
   <bind component="video2" interface="soundLevel" role="set">
 	  <bindParam name="valueSet" value="0"/>
   </bind>
</link>

<!-- oculta a tecla vermelha quando ela ? pressionada -->
<link id="lToggleBotaoVermelho" xconnector="connectors#onKeySelectionStartStop">
   <bind component="botaoVermelho" role="onSelection">
      <bindParam name="keyCode" value="RED" />
   </bind>
   <bind component="botaoVerde" role="start" />
   <bind component="botaoVermelho" role="stop" />
 </link>

<!-- oculta a tecla verde quando ela ? pressionada -->
<link id="lToggleBotaoVerde" xconnector="connectors#onKeySelectionStartStop">
   <bind component="botaoVerde" role="onSelection">
      <bindParam name="keyCode" value="GREEN" />
   </bind>
   <bind component="botaoVerde" role="stop" />
   <bind component="botaoVermelho" role="start" />
 </link>

</body>

</ncl>
