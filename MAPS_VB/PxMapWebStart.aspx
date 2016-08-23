<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PxMapWebStart.aspx.cs" Inherits="PxMapWebCheckSvgSupport" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<% 
    /// <summary>
    /// PxMap 2 for Web - Startpage.
    /// 
    /// This page will check for client SVG-support.
    ///  -> If SVG-support: 
    ///      - Start the application (PxMap 2.0 for Web).
    ///  -> If no SVG-support (possible alternatives):
    ///      - Show an error or redirect to an errorpage.
    ///      - Redirect to an other map-application (e.g. Px-iMap 1.0).
    /// 
    /// Developed by Statistics Norway - www.ssb.no
    /// Oslo, Norway 05 jan. 2007.
    /// </summary>
%>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>PxMapWeb - Check SVG-support...</title>
        
    <script type="text/javascript">
        // Checks the support for SVG in the browser
        function isSVGEnabled(){
	        var boolean = false;

	        if ( window.ActiveXObject ){
		        var p;

		        try{
			        p = new ActiveXObject( "Adobe.SVGCtl" );

		        } catch ( e ){ }

		        if ( p ){
			        boolean = true;
		        }
	        } else {
		        if ( navigator.mimeTypes ){
			        if ( navigator.mimeTypes.length ){
				        if ( navigator.mimeTypes[ "image/svg+xml" ] ){
					        boolean = true;
				        }
			        }
		        } 
	        }
	        // OK, SVG support on client.
	        return boolean;
        } 
      </script>
                  
</head>

<body>
   
    <% // Check client SVG support (generate JavaScript-check).
        string pxMapWebQueryString = Request.QueryString.ToString();
        string redirectPage = "./NoSvgSupport.htm";

        if (Request.QueryString.Get("redirectPage") != null && Request.QueryString.Get("redirectPage").Length > 0){
           redirectPage = Request.QueryString.Get("redirectPage");
        }
        
        Response.Write("<script type=\"text/javascript\">");
        Response.Write("  if ( isSVGEnabled() )");
        Response.Write("  {");
        // OK, SVG-support.
        Response.Write("    location.replace( './PxMapWeb.aspx?" + pxMapWebQueryString + "' );");
        Response.Write("  }");
        Response.Write("  else");
        Response.Write("  {");
        // No SVG-support on client. Show error or redirect to other application.
        Response.Write("    location.replace( '" + redirectPage + "?" + pxMapWebQueryString + "' );");
        //Response.Write("    location.replace( './NoSvgSupport.aspx?" + pxMapWebQueryString + "' );");
        Response.Write("  }");
        Response.Write("</script>");
    %>

</body>
</html>
