<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="PxMapWeb.aspx.cs" Inherits="_Default" %>

    <% 
        /// <summary>
        /// PxMap 2 for Web.
        /// Developed by Bjørn Roar Joneid, Statistics Norway - www.ssb.no
        /// Oslo, Norway 13 feb. 2007.
        /// 
        /// For starting/testing this application you can use the following url:
        ///   http://[myhost]:[myport]/PxMapWeb2/PxMapWebStart.aspx?datafile=pxdata/Euro_demoIndicators.px&language=en
        /// </summary>
        
        // TODO: Implement url-parameter "RedirectPage" for redirect to other application when no svg support? 

                
                // Test/debugging...
                // Response.Write((Request.Url).ToString()); ==> http://localhost:1099/PxMapWeb2/PxMapWeb.aspx
                // Response.Write(Request.PhysicalPath); ==> C:\PC\Skrivebord\SVGLIB\DotNet2005\PxMapWeb2\PxMapWeb.aspx
                // Response.Write(Request.Path); ==> /PxMapWeb2/PxMapWeb.aspx
                // Response.Write(Request.MapPath(Request.Path)); ==> C:\PC\Skrivebord\SVGLIB\DotNet2005\PxMapWeb2\PxMapWeb.aspx
                // Response.Write(Server.MapPath(@"")); ==> C:\PC\Skrivebord\SVGLIB\DotNet2005\PxMapWeb2
                // Response.Write(Server.MapPath(@"/")); ==> c:\inetpub\wwwroot\  (???ERROR: Failed to map the path '/' ???)
                // Response.Write();
                // Response.End();

       try
       {
          // Find and set the parameter for the data file (.px or .txt/sdv).
          string pxMapWebDataFile = Request.QueryString.Get("Datafile");
          if (pxMapWebDataFile == null || pxMapWebDataFile == "")
          {
             // ERROR: "No datafile / datafile missing ..."
             Response.Write("PxMapWeb ERROR: URL-parameter \"Datafile=\" missing (or wrong filename)! <br>");
             Response.End();
          }
          else
          {
             // OK, set full path for datafile.
             //pxMapWebDataFile = Request.PhysicalApplicationPath + "/pxdata/" + pxMapWebDataFile;
             // Find the physical path for this datafile (.px-file).
             pxMapWebDataFile = Server.MapPath(@pxMapWebDataFile);
          }

          // Find and set the parameter for HTML-template file.
          string pxMapWebHtmlTemplateFile = Request.QueryString.Get("Template");
          if (pxMapWebHtmlTemplateFile == null || pxMapWebHtmlTemplateFile == "")
          {
             // No HTML-template specified, use default HTML-template file.
             pxMapWebHtmlTemplateFile = Request.PhysicalApplicationPath + "/template/template.html";
          }
          else
          {
             // ... HTML-template is specified as url-parameter (overridden).
             pxMapWebHtmlTemplateFile = Request.PhysicalApplicationPath + "/template/" + pxMapWebHtmlTemplateFile;
          }

          // Find and set the parameter for application language (language code).
          // If not specified the default-language code in config.xml will be used by the PxMapLib2.dll.
          string pxMapWebLanguage = Request.QueryString.Get("Language");

          // Call PxMapLib constructor (in the common PX-Map DLL).
          PxMapLib2.PxData pxd = new PxMapLib2.PxData(pxMapWebDataFile, pxMapWebHtmlTemplateFile);

          // Set language property for PxMapLib.
          if (pxMapWebLanguage != null || pxMapWebLanguage != "")
          {
             // Default language is defined in config.xml, but this can be overridden with "Language=xx" in the URL. 
             pxd.languageTranslation = pxMapWebLanguage;
          }

          // Set property for the application URL.
          //pxd.relativeHtmlPath = @"http://localhost:1099/PxMapWeb2";
          pxd.relativeHtmlPath = (Request.Url).ToString();
          pxd.relativeHtmlPath = pxd.relativeHtmlPath.Substring(0, pxd.relativeHtmlPath.IndexOf(@"/PxMapWeb.aspx"));

          // Create the map and stream the result to the client (web-browser).
          Response.Write(pxd.MakeMap());

       }
       catch (System.IO.FileNotFoundException e)
       {
          Response.Write(e.Message);
       }
       catch (Exception e)
       {
          // Change to true when debugging!
          //bool showExceptionErrorMessage = false;
          bool showExceptionErrorMessage = true;

          if (showExceptionErrorMessage == true)
          {
             Response.Write("PxMapWeb ERROR: " + e.ToString());
          }
          else
          {
             Response.Write("PxMapWeb SYSTEM ERROR!");
          }
          // Do some logging... 
          Response.End();
       }
        finally
        {
            // Clean up.
        }
        
    %>
