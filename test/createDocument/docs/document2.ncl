<?xml version= "1.0" encoding="ISO-8859-1"?>
<!--Generated by LuaNa-->
<ncl id="document1" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">
 <head>
  <regionBase>
   <region id="rgTV" width="100%" height="100%">
    <region id="rgVideo1" left="25%" width="50%" top="25%" height="50%"/>
    <region id="rgTitulo1" left="25%" width="50%" top="5%" height="15%"/>
   </region>
  </regionBase>
  <descriptorBase>
   <descriptor region="rgVideo1" id="dVideo1">
    <descriptorParam name="soundLevel" value="1"/>
   </descriptor>
   <descriptor region="rgTitulo1" id="dTitulo1">
    <descriptorParam name="scroll" value="none"/>
   </descriptor>
  </descriptorBase>
  <connectorBase>
   <importBase documentURI="connectorBase2.conn" alias="connectors"/>
  </connectorBase>
 </head>
 <body>
  <port id="pInicio" component="video1"/>
  <media src="LuaNa(API)/test/createDocument/media/abertura.mpg" descriptor="dVideo1" id="video1" type="video/mpeg"/>
  <media src="LuaNa(API)/test/createDocument/media/ginga.html" descriptor="dTitulo1" id="titulo1" type="text/html"/>
  <link id="lVideo1Titulo1Start" xconnector="connectors#onBeginStart">
   <bind component="video1" role="onBegin"/>
   <bind component="titulo1" role="start"/>
  </link>
  <link id="lVideo1Titulo1Stop" xconnector="connectors#onEndStop">
   <bind component="video1" role="onEnd"/>
   <bind component="titulo1" role="stop"/>
  </link>
 </body>
</ncl>