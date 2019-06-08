<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="500-Error.aspx.cs" Inherits="OwlCard.secure._500_Error" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head id="Head1" runat="server">
    <title>500: Internal Server Error -- CIS4396 Template</title>
        <!--Supporting 1:1 ratio for smaller screens (mobile support)-->
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <!--Referencing Bootstrap JS/CSS CDNs with integrety and security-->
    <link id="Link1" runat="server" rel="shortcut icon" href="Resources/favicon.ico" type="image/x-icon" />
    <link id="Link2" runat="server" rel="icon" href="Resources/favicon.ico" type="image/ico" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js" integrity="sha384-3ceskX3iaEnIogmQchP8opvBy3Mi7Ce34nWjpBIwVTHfGYWQS9jwHDVRnpKKHJg7" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>

    <style type="text/css">
        body {
            padding-top: 5rem;
        }

        .starter-template {
            padding: 3rem 1.5rem;
        }

        p, ul {
            font-size: 15pt;
        }
    </style>
</head>
<body>
    <div id="navBar">
        <form runat="server">
            <asp:Label runat="server" ID="test"></asp:Label>
        </form>
        <nav class="navbar-temple navbar-fixed-top">
            <div class="navbar-header">
              
            </div>
        </nav>
    </div>
      
    <div class="container">
        <div id="content" class="starter-template">
            <div class="col-md-2 col-lg-2"></div>
            <div class="col-sm-12 col-md-8 col-lg-8">
                <h1>500</h1>
                <hr />
                <p>An unexpected error has occurred. Please try again later.</p>
                
                  

               
            </div>
            <div class="col-md-2 col-lg-2"></div>
        </div>
    </div>
</body>
</html>
