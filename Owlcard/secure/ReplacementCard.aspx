<%@ Page Title="" Language="C#" MasterPageFile="~/secure/Nav.Master" AutoEventWireup="true" CodeBehind="ReplacementCard.aspx.cs" Inherits="OwlCard.ReplacementCard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="css/header.css"/>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="header">
        <img src="images/templeLogo.png" />
        <h1>TEMPLE UNIVERSITY</h1>
    </div>
    <link href="css/html.css" rel="stylesheet" />
    <div style="width: 100%; bottom: 0; background-color: #F0F0F0">
        <div class="container">
            <div class="row">
                <br />
                <br />
                <div class="col-sm-10 col-sm-offset-1" style="background-color: white; border: thin solid #000000; border-radius: 25px;">
                    <div class="col-sm-10 col-sm-offset-1" style="text-align:center;">
                        <h2 style=" font-size: 42px;">Replacement OWLCard - $<asp:Label id="lblPrice" runat="server"></asp:Label></h2>
                        <ul style="text-align:left; font-size:medium; list-style-position: inside; color: #990d0a;">
                            <li>Use this form to replace lost, stolen, or damaged OWLCards.</li>
                            <li>Defective OWLCards are replaced with no charge</li>
                        </ul>
                    </div>
                    <br />
                    <br />
                    <div class="form-group">
                        <!-- First and Last Name Row -->
                        <div class="row">
                            <div class="col-xs-4">
                                <label for="tuID" style="font-size:large">TUID:</label>
                                <asp:TextBox ID="txtID" class="form-control" style="font-size: medium;" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="reqID" runat="server" ErrorMessage="* Required" ForeColor="Red" ControlToValidate="txtID" ValidationExpression="[aA-zZ]"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator runat="server" ID="rexTUID" ControlToValidate="txtID" ValidationExpression="^[0-9]{9}$" ForeColor="Red" ErrorMessage="Enter 9 Digit TUID!" />
                            </div>
                        
                            <div class="col-xs-4">
                                <label for="FName" style="font-size:large">First Name:</label>
                                <asp:TextBox ID="txtFirstName" class="form-control" style="font-size: medium;" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="reqFirstName" runat="server" ErrorMessage="* Required" ForeColor="Red" ControlToValidate="txtFirstName" ValidationExpression="[aA-zZ]"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator runat="server" ID="regFirstName" ControlToValidate="txtFirstName" ValidationExpression="[a-zA-Z\s]*$" ForeColor="Red" ErrorMessage="Enter Letters Only!" />
                            </div>
                            <div class="col-xs-4">
                                <label for="LName" style="font-size:large">Last Name:</label>
                                <asp:TextBox ID="txtLastName" class="form-control" style="font-size: medium;" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="reqLastName" runat="server" ErrorMessage="* Required" ForeColor="Red" ControlToValidate="txtLastName" ValidationExpression="[aA-zZ]"></asp:RequiredFieldValidator>
                                 <asp:RegularExpressionValidator runat="server" ID="regLastName" ControlToValidate="txtLastName" ValidationExpression="[a-zA-Z\s]*$" ForeColor="Red" ErrorMessage="Enter Letters Only!" />
                            </div>
                        </div>
                        <br />
                        <!-- DDLs for payment and photo type -->
                        <div class="row">
                                <div class="col-xs-6" >
                                    <label for="payment" style="font-size: large">Payment Method:</label><br />
                                    <asp:DropDownList ID="ddlPayMethod" runat="server" style="font-size: medium;" CssClass="form-control">
                                        <asp:ListItem Selected="True">Cash</asp:ListItem>
                                        <asp:ListItem>Diamond Dollars</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-xs-6">
                                    <label for="Photo" style="font-size: large">Photo Options:</label>
                                    <asp:DropDownList ID="ddlPhotoOptions" runat="server" style="font-size: medium;" CssClass="form-control">
                                        <asp:ListItem Selected="True">Keep Existing Photo</asp:ListItem>
                                        <asp:ListItem>Take New Photo</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                        </div>
                        <br />
                        <br />
                        <p class="col-xs-12" style="font-size: 16px;">
                            I represent that I am the individual above. I understand that any attempt
                                to obtain an ID card using any false information or for any fraudulent purpose may subject me 
                                to discipline pursuant to the student code of conduct as well as applicable local, state, federal laws
                        </p>
                        <br />
                        <div class="col-xs-12">
                            <label for="lblSign" style="font-size:large";>Signature (print your name or initials):</label>
                            <asp:TextBox ID="txtSignature" class="form-control" style="font-size: medium;" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqSignature" runat="server" ErrorMessage="* Required" ForeColor="Red" ControlToValidate="txtSignature" ValidationExpression="[aA-zZ]"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator runat="server" ID="regSignature" ControlToValidate="txtSignature" ValidationExpression="[a-zA-Z\s]{2,}$" ForeColor="Red" ErrorMessage="Must be at least 2 letters!" />
                        </div>
                         <br />
                        <br />
                        <div class="row">
                            <div class="col-sm-6" style="text-align: center">
                                <asp:Button ID="btnBack" Style="font-size: large; background-color: darkslategrey; color: white; height: 50px; width: 150px;" runat="server" Text="Go Back" OnClick="btnBack_Click" CausesValidation="False" CssClass="btn"></asp:Button>
                            </div>
                            <div class="col-sm-6" style="text-align: center">
                                <asp:Button ID="btnSubmit" runat="server" Style="font-size: large; background-color: #9D2134; color: white; height: 50px; width: 150px;" Text="Submit" OnClick="btnSubmit_Click" CssClass="btn" />
                            </div>
                        </div>
                    </div>
                </div> 
            </div>
        </div>
        <br />
        <br />
        <br />
        <br />
    </div>
</asp:Content>


