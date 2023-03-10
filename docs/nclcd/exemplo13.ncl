<?xml version="1.0" encoding="ISO-8859-1"?>

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 !   EXEMPLO 13
 !
 !   Objetivo: Reproduzir um v?deo e permitir que o usu?rio
 !             selecione o n?vel de conhecimento sobre um 
 !             t?pico, atrav?s do pressionamento das teclas
 !             vermelha e verde do controle remoto
 !             e com feedback imediato para o usu?rio.
 !             O v?deo "principal" ser? re-usado em 2 contextos:
 !             - contexto b?sico, entrela?ado com v?deos e texto 
 !               explicativo em diversos pontos
 !             - contexto avan?ado, somente com texto
 !               explicativo em alguns pontos (menos do que no
 !               b?sico)
 !
 !   Caracter?sticas:
 !
 !   - sincronismo: simples (de in?cio e t?rmino de m?dias)
 !   - intera??o do usu?rio: sele??o do contexto a ser exibido
 !   - re-uso de n?s de conte?do
 !
 !   Prepara??o:
 !
 !   Para executar este exemplo, ? necess?rio ter as seguintes 
 !   m?dias no subdiret?rio media a partir do caminho do 
 !   arquivo NCL:
 !
 !   1) arquivo de v?deo chamado abertura.mpg
 !   2) arquivo de v?deo chamado rio.mpg
 !   3) arquivos de v?deo chamados video_basico1.mpg, 
 !      video_basico2.mpg, video_basico3.mpg
 !   4) arquivos de texto basico1.html, basico2.html, 
 !      basico3.html
 !   5) arquivos de texto avancado1.html, avancado2.html, 
 !      avancado3.html
 !   6) arquivo de imagem chamado botao_vermelho.gif, 
 !      indicando a a??o do bot?o vermelho
 !   7) arquivo de imagem chamado botao_verde.gif, 
 !      indicando a a??o do bot?o verde
 !
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 !  CABE?ALHO NCL:
 !  define as URIs dos esquemas da NCL
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<ncl id="exemplo13" 
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
   <region id="rgTV" height="100%" width="100%">
      <region id="rgVideo1" height="480" width="640"
              top="0" left="0"/>
      <region id="rgVideo2" left="384" bottom="0" 
              width="640" height="480" />
      <region id="rgTexto1" height="50" width="384" 
              top="480" left="0"/>
      <region id="rgBotaoVermelho" left="200" top="420" 
              width="25" height="25" zIndex="1"/>
      <region id="rgBotaoVerde" left="200" top="470" 
              width="25" height="25" zIndex="1"/>
   </region>
</regionBase>

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 !  BASE DE DESCRITORES:
 !  define como as m?dias s?o apresentadas
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<descriptorBase>
   <descriptor id="dVideo1" region="rgVideo1" />
   <descriptor id="dVideo2" region="rgVideo2" />

   <descriptor id="dTexto1" region="rgTexto1" />

   <descriptor id="dBotaoVermelho" region="rgBotaoVermelho" />
   <descriptor id="dBotaoVerde" region="rgBotaoVerde" />
</descriptorBase>

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 !  BASE DE CONECTORES:
 !  definem o comportamento dos elos
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<connectorBase>
   <importBase alias="connBase" 
               documentURI="composerConnectorBase.conn"/>

   <causalConnector id="onKeySelectionStartNStopNAbortN">
      <connectorParam name="keyCode" />
      <connectorParam name="delay" />

      <simpleCondition role="onSelection" key="$keyCode"/>

      <compoundAction operator="seq">
        <simpleAction role="dstart" delay="$delay"
                      eventType="presentation" actionType="start" 
                      max="unbounded" qualifier="par"/>
        <simpleAction role="dstop" delay="$delay" 
                      eventType="presentation" actionType="stop" 
                      max="unbounded" qualifier="par"/>
        <simpleAction role="dabort" delay="$delay"
                      eventType="presentation" actionType="abort" 
                      max="unbounded" qualifier="par"/>
      </compoundAction>
   </causalConnector>
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
<media type="video/mpeg" id="video1" src="media/abertura.mpg" 
       descriptor="dVideo1" />

<media type="video/mpeg" id="videoPrincipal" 
       src="media/rio.mpg" descriptor="dVideo1" />

<media type="image/gif" id="botaoVermelho" 
       src="media/botao_vermelho.gif" descriptor="dBotaoVermelho"/>
<media type="image/gif" id="botaoVerde" 
       src="media/botao_verde.gif" descriptor="dBotaoVerde" />

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
!  CONTEXTOS:
!  os documentos b?sico e avan?ado
!++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->
<context id="ctxBasico">
   <port id="pBasico" component="videoBasico" />

   <media id="videoBasico" refer="videoPrincipal"
          newInstance="false">
      <!-- ?ncoras no v?deo que devem ser sincronizadas 
           com a legenda -->
      <area id="aVideoBasicoTexto1" begin="1s" end="3s" />
      <area id="aVideoBasicoTexto2" begin="5s" end="15s" />
      <area id="aVideoBasicoTexto3" begin="16s" end="21s" />
      <area id="aVideoBasicoVideo1" begin="2s" end="4s" />
      <area id="aVideoBasicoVideo2" begin="8s" end="10s" />
      <area id="aVideoBasicoVideo3" begin="13s" end="16s" />
   </media>
   <media id="textoBasico1" type="text/html" 
          src="media/basico1.html" descriptor="dTexto1" />
   <media id="textoBasico2" type="text/html" 
          src="media/basico2.html" descriptor="dTexto1" />
   <media id="textoBasico3" type="text/html" 
          src="media/basico3.html" descriptor="dTexto1" />

   <media id="videoBasico1" type="video/mpeg" 
          src="media/video_basico1.mpg" descriptor="dVideo2" />
   <media id="videoBasico2" type="video/mpeg" 
          src="media/video_basico2.mpg" descriptor="dVideo2" />
   <media id="videoBasico3" type="video/mpeg" 
          src="media/video_basico3.mpg" descriptor="dVideo2" />

   <!-- links para sincronizar os textos com o v?deo -->
   <link id="lBasicoTexto1Start" 
         xconnector="connBase#onBeginStartN">
      <bind component="videoBasico" interface="aVideoBasicoTexto1" 
            role="onBegin" />
      <bind component="textoBasico1" role="start" />
   </link>
   <link id="lBasicoTexto2Start" 
         xconnector="connBase#onBeginStartN">
      <bind component="videoBasico" interface="aVideoBasicoTexto2" 
            role="onBegin" />
      <bind component="textoBasico2" role="start" />
   </link>
   <link id="lBasicoTexto3Start" 
         xconnector="connBase#onBeginStartN">
      <bind component="videoBasico" interface="aVideoBasicoTexto3" 
            role="onBegin" />
      <bind component="textoBasico3" role="start" />
   </link>

   <link id="lBasicoTexto1End" xconnector="connBase#onEndStopN">
      <bind component="videoBasico" interface="aVideoBasicoTexto1" 
            role="onEnd" />
      <bind component="textoBasico1" role="stop" />
   </link>
   <link id="lBasicoTexto2End" xconnector="connBase#onEndStopN">
      <bind component="videoBasico" interface="aVideoBasicoTexto2" 
            role="onEnd" />
      <bind component="textoBasico2" role="stop" />
   </link>
   <link id="lBasicoTexto3End" xconnector="connBase#onEndStopN">
      <bind component="videoBasico" interface="aVideoBasicoTexto3" 
            role="onEnd" />
      <bind component="textoBasico3" role="stop" />
   </link>

   <!-- links para sincronizar os v?deos auxiliares com o 
        v?deo principal -->
   <link id="lBasicoVideo1Start" 
         xconnector="connBase#onBeginStartNPauseN">
      <bind component="videoBasico" interface="aVideoBasicoVideo1" 
            role="onBegin" />
      <bind component="videoBasico" role="pause" />
      <bind component="videoBasico1" role="start" />
   </link>
   <link id="lBasicoVideo2Start" 
         xconnector="connBase#onBeginStartNPauseN">
      <bind component="videoBasico" interface="aVideoBasicoVideo2"
         role="onBegin" />
      <bind component="videoBasico" role="pause" />
      <bind component="videoBasico2" role="start" />
   </link>
   <link id="lBasicoVideo3Start" 
         xconnector="connBase#onBeginStartNPauseN">
      <bind component="videoBasico" interface="aVideoBasicoVideo3"
            role="onBegin" />
      <bind component="videoBasico" role="pause" />
      <bind component="videoBasico3" role="start" />
   </link>

   <link id="lBasicoVideo1End" 
         xconnector="connBase#onEndResumeN">
      <bind component="videoBasico1" role="onEnd" />
      <bind component="videoBasico" role="resume" />
   </link>
   <link id="lBasicoVideo2End" 
         xconnector="connBase#onEndResumeN">
      <bind component="videoBasico2" role="onEnd" />
      <bind component="videoBasico" role="resume" />
   </link>
   <link id="lBasicoVideo3End" 
         xconnector="connBase#onEndResumeN">
      <bind component="videoBasico3" role="onEnd" />
      <bind component="videoBasico" role="resume" />
   </link>
</context>

<context id="ctxAvancado">
   <port id="pAvancado" component="videoAvancado" />

   <media id="videoAvancado" refer="videoPrincipal"
          newInstance="false">
      <!-- ?ncoras no v?deo que devem ser sincronizadas com a legenda -->
      <area id="aVideoAvancadoTexto1" begin="5s" end="9s"/>
      <area id="aVideoAvancadoTexto2" begin="10s" end="14s"/>
      <area id="aVideoAvancadoTexto3" begin="15s" end="19s"/>
   </media>
   <media id="textoAvancado1" type="text/html"
          src="media/avancado1.html" descriptor="dTexto1" />
   <media id="textoAvancado2" type="text/html"
          src="media/avancado2.html" descriptor="dTexto1" />
   <media id="textoAvancado3" type="text/html"
          src="media/avancado3.html" descriptor="dTexto1" />

   <!-- links para sincronizar os textos com o v?deo -->
   <link id="lAvancadoTexto1Start" 
         xconnector="connBase#onBeginStartN">
      <bind component="videoAvancado" interface="aVideoAvancadoTexto1"
            role="onBegin" />
      <bind component="textoAvancado1" role="start" />
   </link>
   <link id="lAvancadoTexto2Start" xconnector="connBase#onBeginStartN">
      <bind component="videoAvancado" interface="aVideoAvancadoTexto2"
            role="onBegin" />
      <bind component="textoAvancado2" role="start" />
   </link>
   <link id="lAvancadoTexto3Start" xconnector="connBase#onBeginStartN">
      <bind component="videoAvancado" interface="aVideoAvancadoTexto3"
            role="onBegin" />
      <bind component="textoAvancado3" role="start" />
   </link>

   <link id="lAvancadoTexto1End" xconnector="connBase#onEndStopN">
      <bind component="videoAvancado" interface="aVideoAvancadoTexto1"
            role="onEnd" />
      <bind component="textoAvancado1" role="stop" />
   </link>
   <link id="lAvancadoTexto2End" xconnector="connBase#onEndStopN">
      <bind component="videoAvancado" interface="aVideoAvancadoTexto2" 
            role="onEnd" />
      <bind component="textoAvancado2" role="stop" />
   </link>
   <link id="lAvancadoTexto3End" xconnector="connBase#onEndStopN">
      <bind component="videoAvancado" interface="aVideoAvancadoTexto3"
            role="onEnd" />
      <bind component="textoAvancado3" role="stop" />
   </link>
</context>

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 !  ELOS
 !  define os elos que regem o sincronismo entre as m?dias
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<!-- in?cio do video1 deve exibir bot?es -->
<link id="lVideo1Init" xconnector="connBase#onBeginStartN">
   <bind component="video1" role="onBegin" />
   <bind component="botaoVermelho" role="start" />
   <bind component="botaoVerde" role="start" />
</link>

<!-- t?rmino do video1 deve dispar?-lo novamente
     (deve tocar em loop) -->
<link id="lVideo1Loop" xconnector="connBase#onEndStartN">
   <bind component="video1" role="onEnd" />
   <bind component="video1" role="start" />
</link>

<!-- define n?vel b?sico quando a tecla vermelha ? pressionada -->

<link id="lSelectBotaoVermelho" 
      xconnector="onKeySelectionStartNStopNAbortN">
   <linkParam name="delay" value="0.5s"/>
   <bind component="botaoVermelho" role="onSelection">
      <bindParam name="keyCode" value="RED" />
   </bind>
   <bind component="botaoVerde" role="dstop" />
   <bind component="botaoVermelho" role="dstop">
      <bindParam name="delay" value="5s"/>
   </bind>
   <bind component="video1" role="dabort" />
   <bind component="ctxBasico" interface="pBasico" role="dstart">
      <bindParam name="delay" value="5s"/>
   </bind>
</link>

<!-- define n?vel avan?ado quando a tecla verde ? pressionada -->

<link id="lSelectBotaoVerde" 
      xconnector="onKeySelectionStartNStopNAbortN">
   <linkParam name="delay" value="0.5s"/>
   <bind component="botaoVerde" role="onSelection">
      <bindParam name="keyCode" value="GREEN" />
   </bind>
   <bind component="botaoVerde" role="dstop">
      <bindParam name="delay" value="5s"/>
   </bind>
   <bind component="botaoVermelho" role="dstop" />
   <bind component="video1" role="dabort" />
   <bind component="ctxAvancado" interface="pAvancado" role="dstart">
      <bindParam name="delay" value="5s"/>
   </bind>
</link>

</body>

</ncl>
