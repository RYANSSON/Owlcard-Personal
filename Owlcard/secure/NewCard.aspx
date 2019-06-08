<%@ Page Title="" Language="C#" MasterPageFile="~/secure/Nav.Master" AutoEventWireup="true" CodeBehind="NewCard.aspx.cs" Inherits="OwlCard.NewCard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="css/header.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="header">
        <img src="images/templeLogo.png" />
        <h1>TEMPLE UNIVERSITY</h1>
    </div>
    <link href="css/html.css" rel="stylesheet" />
    <asp:Label ID="lblmsg" runat="server" Text=""></asp:Label>
    <div style="width: 100%; bottom: 0px; background-color: #F0F0F0">
        <div class="container">
            <div class="row">
                <br />
                <br />
                <div class="col-sm-8 col-sm-offset-2" style="border: thin solid #000000; background-color: white; border-radius: 25px;">
                    <h2 style="text-align: center; font-size: 42px;">First OWLCard</h2>
                    <br />
                    <ul style="text-align:left; font-size:medium; font-weight:bold; list-style-position: inside; color: #990d0a;">
                        <li>Use this form if this is your first time requesting a Temple OWLCard</li>
                    </ul>
                    <br />
                    <div class="form-group">
                        <!-- First and Last Name -->
                        <div class="row">
                            <div class="col-xs-4">
                                <label for="tuID" style="font-size: large">TUID:</label>
                                <asp:TextBox ID="txtID" class="form-control" runat="server" autocomplete="none" OnTextChanged="txtID_TextChanged"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="reqID" runat="server" ErrorMessage="* Required" ForeColor="Red" ControlToValidate="txtID" ValidationExpression="[aA-zZ]"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator runat="server" ID="rexTUID" ControlToValidate="txtID" ValidationExpression="^[0-9]{9}$" ForeColor="Red" ErrorMessage="Enter 9 Digit TUID!" />
                            </div>
                            <div class="col-xs-4">
                                <label for="FName" style="font-size: large">First Name:</label>
                                <asp:TextBox ID="txtFirstName" class="form-control" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="reqFirstName" runat="server" ErrorMessage="* Required" ForeColor="Red" ControlToValidate="txtFirstName" ValidationExpression="[aA-zZ]"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator runat="server" ID="regFirstName" ControlToValidate="txtFirstName" ValidationExpression="[a-zA-Z\s]*$" ForeColor="Red" ErrorMessage="Enter Letters Only!" />
                            </div>
                            <div class="col-xs-4">
                                <label for="LName" style="font-size: large">Last Name:</label>
                                <asp:TextBox ID="txtLastName" class="form-control" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="reqLastName" runat="server" ErrorMessage="* Required" ForeColor="Red" ControlToValidate="txtLastName" ValidationExpression="[aA-zZ]"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator runat="server" ID="regLastName" ControlToValidate="txtLastName" ValidationExpression="[a-zA-Z\s]*$" ForeColor="Red" ErrorMessage="Enter Letters Only!" />
                            </div>
                        </div>
                        <br />
                        <p style="font-size: 16px;">
                            I represent that I am the individual above. I understand that any attempt to obtain an ID card using any false information
                        or for any fraudulent purpose may subject me to discipline pursuant to the 
                        student code of conduct as well as applicable local, state, federal laws
                        </p>
                        <br />
                        <label for="lblSign" style="font-size: large">Signature (print your name or initials):</label>
                        <asp:TextBox ID="txtSignature" class="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqsignature" runat="server" ErrorMessage="* Required" ForeColor="Red" ControlToValidate="txtSignature" ValidationExpression="[aA-zZ]" BorderStyle="None"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator runat="server" ID="regSignature" ControlToValidate="txtSignature" ValidationExpression="[a-zA-Z\s]{2,}$" ForeColor="Red" ErrorMessage="Must be at least 2 letters!" />

                        <br>
                        <br>
                        <br>
                        <div class="row">
                            <div class="col-sm-6" style="text-align: center">
                                <asp:Button ID="btnBack" cssclass="btn" Style="background-color: darkslategrey; color: white; height: 50px; width: 150px;" runat="server" Text="Go Back" OnClick="btngoBack_Click" CausesValidation="False" Font-Size="large"></asp:Button>
                            </div>
                            <div class="col-sm-6" style="text-align: center">
                                <asp:Button ID="btnSubmit" runat="server" Style="background-color: #9D2134; color: white; height: 50px; width: 150px;" Text="Submit" OnClick="btnSubmit_Click" Font-Size="large" BorderStyle="None" CssClass="btn" />
                            </div>
                            <br />
                            <br />
                        </div>
                    </div>
                </div>
                
            </div>
            <br />
                <br />
        </div>
    </div>
</asp:Content>


