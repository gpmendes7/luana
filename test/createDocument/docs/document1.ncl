<?xml version= "1.0" encoding="ISO-8859-1"?>
<!--Generated by LuaNa-->
<ncl id="document1" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">
 <head>
  <regionBase>
   <region id="rgTV" width="100%" height="100%">
    <region id="rgVideo1" left="25%" width="50%" top="25%" height="50%"/>
   </region>
  </regionBase>
  <descriptorBase>
   <descriptor region="rgVideo1" id="dVideo1"/>
  </descriptorBase>
 </head>
 <body>
  <port id="pInicio" component="video1"/>
  <media src="test/createDocument/media/abertura.mpg" descriptor="dVideo1" id="video1" type="video/mpeg"/>
 </body>
</ncl>