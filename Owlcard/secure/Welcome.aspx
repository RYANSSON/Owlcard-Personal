<%@ Page Title="" Language="C#" MasterPageFile="~/secure/Nav.Master" AutoEventWireup="true" CodeBehind="Welcome.aspx.cs" Inherits="OwlCard.Welcome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server" style="background-color: white;">
    <link rel="stylesheet" type="text/css" href="css/header.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server" style="background-color: white; border-style:none;">
    <div class="header">
        <img src="images/templeLogo.png" />
        <h1>TEMPLE UNIVERSITY</h1>
    </div>
    <link href="css/welcome.css" rel="stylesheet" />
    <br />
    <br />
    <div style="border-style: none">
        <h1 class="text-center" style="font-size: 52px">OWLCard Request System</h1>
        <h3 class="text-center">Please select from the following options:</h3>
    </div>
    <br />
    <br />
    <div class="col-sm-12" style="background-color:white;">

        <div class="col-md-3" style="display: flex; justify-content: center">
            <button type="button" onclick="window.location.href='NewCard.aspx'" style="background-color: #9D2235; height: 200px; width: 200px; font-size: 30px; text-align: center;" class="btn btn-primary">
                <p>First <br />Owlcard</p>
            </button>

        </div>
        <div class="col-md-3" style="display: flex; justify-content: center">

            <button type="button" onclick="window.location.href='ReplacementCard.aspx'" style="background-color: #9D2235; height: 200px; width: 200px; font-size: 30px; text-align: center;" class="btn btn-primary">
                <p>Replace<br />Owlcard</p>
            </button>

        </div>
        <div class="col-md-3" style="display: flex; justify-content: center">

            <button type="button" onclick="window.location.href='Deposit.aspx'" style="background-color: #9D2235; height: 200px; width: 200px; font-size: 30px; text-align: center; " class="btn btn-primary">
                <p>Deposit<br />Diamond<br />Dollars</p>
            </button>

        </div>
        <div class="col-md-3" style="display: flex; justify-content: center">

            <button type="button" onclick="window.location.href='Purchases.aspx'" style="background-color: #9D2235; height: 200px; width: 200px; font-size: 30px; text-align: center;" class="btn btn-primary">
                <p>Purchase<br />Items</p>
            </button>

        </div>
    </div>
    <div class="footer" style="background-color:#9D2134; color: white; line-height: normal; vertical-align: middle;">
            <br />
            <p>Temple University - OWLCard Office</p>
        </div>
</asp:Content>
