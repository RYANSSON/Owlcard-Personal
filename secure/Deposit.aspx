<%@ Page Title="" Language="C#" MasterPageFile="~/secure/Nav.Master" AutoEventWireup="true" CodeBehind="Deposit.aspx.cs" Inherits="OwlCard.Deposit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="css/header.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%--Deposit Form.--%>

    <div class="header">
        <img src="images/templeLogo.png" />
        <h1>TEMPLE UNIVERSITY</h1>
    </div>
    <div style="width: 100%; bottom: 0; background-color: #F0F0F0">
    <div class="container">
        <div class="row">
            <br />
                <br />
            <div class="col-sm-10 col-sm-offset-1" style="border: thin solid #000000; background-color: white; border-radius: 25px;">
                <h2 style="text-align: center; font-size:42px;">Deposit Form</h2>
                <ul style="text-align:center; font-size:medium; list-style-position: inside; color: #990d0a;">
                    <li>Use this form for the <strong>check or cash</strong> deposits to a Diamond Dollars account.</li>
                    <li>For deposit by <strong>credit card</strong>, please visit <strong>www.temple.edu/diamonddollars.</strong></li>
                </ul>
                <br />
                <div class="form-group">
                    <!-- First and Last Name Row -->
                    <div class="row">
                        <div class="col-xs-4">
                             <label for="tuID" style="font-size:large">TUID:</label>
                            <asp:TextBox ID="txtID" class="form-control" runat="server" Font-Size="Large" autocomplete="off" AutoCompleteType="Disabled"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqID" runat="server" ErrorMessage="* Required" ForeColor="Red" ControlToValidate="txtID" ValidationExpression="[aA-zZ]"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator runat="server" ID="rexTUID" ControlToValidate="txtID" ValidationExpression="^[0-9]{9}$" ForeColor="Red" ErrorMessage="Enter 9 Digit TUID!" />                                               
                        </div>
                        <div class="col-xs-4">
                            <label for="FName" style="font-size:large">First Name:</label>
                            <asp:TextBox ID="txtFirstName" class="form-control" runat="server" Font-Size="Large" autocomplete="off" AutoCompleteType="Disabled"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqFirstName" runat="server" ErrorMessage="* Required" ForeColor="Red" ControlToValidate="txtFirstName" ValidationExpression="[aA-zZ]"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator runat="server" ID="regFirstName" ControlToValidate="txtFirstName" ValidationExpression="[a-zA-Z\s]*$" ForeColor="Red" ErrorMessage="Enter Letters Only!" />
                        </div>
                        <div class="col-xs-4">
                            <label for="LName" style="font-size:large">Last Name:</label>
                            <asp:TextBox ID="txtLastName" class="form-control" runat="server" Font-Size="Large" autocomplete="off" AutoCompleteType="Disabled"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqLastName" runat="server" ErrorMessage="* Required" ForeColor="Red" ControlToValidate="txtLastName" ValidationExpression="[aA-zZ]"></asp:RequiredFieldValidator>  
                            <asp:RegularExpressionValidator runat="server" ID="regLastName" ControlToValidate="txtLastName" ValidationExpression="[a-zA-Z\s]*$" ForeColor="Red" ErrorMessage="Enter Letters Only!" />
                        </div>
                        
                    </div>
                    <br />
                    <div class="row">
                        <div class="col-sm-4">
                            <label for="payment" style="font-size:large">Payment Method:</label><br />
                            <asp:DropDownList ID="ddlPayMethod" runat="server" CssClass="form-control" Font-Size="Large">
                                <asp:ListItem Selected="True">Cash</asp:ListItem>
                                <asp:ListItem>Check</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-sm-4">
                            <label for="amount" style="font-size:large">Amount:</label><br />
                            <asp:DropDownList runat="server" ID="ddlAmount" OnSelectedIndexChanged="ddlAmount_SelectedIndexChanged" CssClass="form-control" Font-Size="Large" AutoPostBack="True">
                                <asp:ListItem Selected="True">$25</asp:ListItem>
                                <asp:ListItem>$50</asp:ListItem>
                                <asp:ListItem>$75</asp:ListItem>
                                <asp:ListItem>$100</asp:ListItem>
                                <asp:ListItem>Other</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div id="otherAmountDiv" runat="server" class="col-sm-4">
                            <asp:Label for="payment" ID="lblAmount" runat="server" style="font-size:large" Visible="False" Font-Bold="True">Other Amount:</asp:Label><br />
                            <asp:TextBox ID="txtAmount" class="form-control" runat="server" Font-Size="Large" CssClass="form-control" Visible="False" autocomplete="off" AutoCompleteType="Disabled"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqAmount" runat="server" ErrorMessage="* Required" ForeColor="Red" Enabled="false" ControlToValidate="txtAmount" ValidationExpression="^\d+?$"></asp:RequiredFieldValidator>  
                            <asp:RegularExpressionValidator runat="server" ID="regAmount" ControlToValidate="txtAmount" ValidationExpression="^(0*[1-9][0-9]*(\.[0-9]+)?|0+\.[0-9]*[1-9][0-9]*)$" ForeColor="Red" ErrorMessage="Enter Numbers Only!" />
                       
                        </div>
                    </div>
                </div>
                <br />
                <div class="row">
                    <div class="col-sm-12">
                        <ul>
                            <li style="font-size:medium; text-align: left; list-style-position: inside; font-weight:bold; color:#990d0a">Make check payable to Temple University, TUId# on memo line, minimum $25.</li>
                        </ul>
                    </div>
                </div>
                <br>
                <p>
                    I represent that I am the individual above. I understand that any attempt to obtain an ID card using any false information
                    or for any fraudulent purpose may subject me to discipline pursuant to the student code of conduct as well as applicable 
                    local, state, and federal laws
                </p>
                <br />
                <label for="lblSign" style="font-size:large">Signature (print your name or initials):</label>
                <asp:TextBox ID="txtSignature" style="font-size:large;" class="form-control" runat="server" autocomplete="off" AutoCompleteType="Disabled"></asp:TextBox>
                <asp:RequiredFieldValidator ID="reqSignature" runat="server" ErrorMessage="* Required" ForeColor="Red" ControlToValidate="txtSignature" ValidationExpression="[aA-zZ]"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator runat="server" ID="regSignature" ControlToValidate="txtSignature" ValidationExpression="[a-zA-Z\s]{2,}$" ForeColor="Red" ErrorMessage="Must be at least 2 letters!" />
                        
                <br>
                <div class="row">
                    <div class="col-xs-6" style="text-align: center">
                        <asp:Button ID="btnGoBack" runat="server" Text="Go Back" Style="background-color: darkslategrey; font-size: large; color: white; height: 50px; width: 150px;" class="btn" OnClick="btnGoBack_Click" CausesValidation="False" />
                    </div>

                    <div class="col-xs-6" style="text-align: center">
                        <asp:Button ID="btnSubmitDepositFormPage" runat="server" Text="Submit" Style="background-color: #9D2134; font-size: large; border: none; color: white; height: 50px; width: 150px;" class="btn" OnClick="btnSubmitDepositFormPage_Click" />
                    </div>
                </div>
                <br />
            </div>
        </div>
    </div>
        <br />
        <br />
        <br />
    </div>
</asp:Content>
