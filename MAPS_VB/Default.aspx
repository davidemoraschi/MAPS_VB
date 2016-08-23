<%@ Page Language="VB" %>
  <%@ Import Namespace="MapObjectsLT2" %>
  <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"
  "http://www.w3.org/TR/REC-html40/loose.dtd">
  <HTML>
  <HEAD>
  <TITLE>Developing ASP Components</TITLE>
  </HEAD>
  <BODY>
  <%

      Dim Map1 As New Map
      
      Dim mLayer As New MapLayer
      mLayer.File = "C:\Archivos de programa\PX-Map\Maps\spain_provinces_img_ag_2.shp"
      If Map1.Layers.Add(mLayer) Then
          MsgBox("Map added successfully")
      End If


      '    Dim obj As First
      'obj = new First()

  Dim msg As String
      '  msg = obj.sayHello("World!")

  Response.Write("<h3>" & msg & "</h3>")

  %>
  </BODY>
  </HTML>
