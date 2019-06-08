<%@ Page Title="" Language="C#" MasterPageFile="~/secure/Nav.Master" AutoEventWireup="true" CodeBehind="Purchases.aspx.cs" Inherits="OwlCard.Purchases" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="css/header.css" />
 

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="header">
        <img src="images/templeLogo.png" />
        <h1>TEMPLE UNIVERSITY</h1>
    </div>
    <div style="width: 100%; bottom: 0; background-color: #F0F0F0">
    <div class="container">
        <br />
        <div class="row">
            <br />
            <div class="col-sm-10 col-sm-offset-1" style="background-color: white; border: thin solid #000000; border-radius: 25px;">
                <h2 style="text-align: center; font-size: 42px;">Purchase Form</h2>
                <br />
                <div class="form-group">
                    <!--First and Last Name Row -->
                    <div class="row">
                        <div class="col-xs-4">
                            <label for="tuID" style="font-size: medium">TUID:</label>
                            <asp:TextBox ID="txtID" class="form-control" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqID" runat="server" ErrorMessage="* Required" ForeColor="Red" ControlToValidate="txtID" ValidationExpression="[aA-zZ]"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator runat="server" ID="rexTUID" ControlToValidate="txtID" ValidationExpression="^[0-9]{9}$" ForeColor="Red" ErrorMessage="Enter 9 Digit TUID!" />
                        </div>
                        <div class="col-xs-4">
                            <label for="LName" style="font-size: medium">Last Name:</label>
                            <asp:TextBox ID="txtLastName" class="form-control" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqLastName" runat="server" ErrorMessage="* Required" ForeColor="Red" ControlToValidate="txtLastName" ValidationExpression="[aA-zZ]"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator runat="server" ID="regLastName" ControlToValidate="txtLastName" ValidationExpression="[a-zA-Z\s]*$" ForeColor="Red" ErrorMessage="Enter Letters Only!" />
                        </div>
                        <div class="col-xs-4">
                            <label for="FName" style="font-size: medium">First Name:</label>
                            <asp:TextBox ID="txtFirstName" class="form-control" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqFirstName" runat="server" ErrorMessage="* Required" ForeColor="Red" ControlToValidate="txtFirstName" ValidationExpression="[aA-zZ]"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator runat="server" ID="regFirstName" ControlToValidate="txtFirstName" ValidationExpression="[a-zA-Z\s]*$" ForeColor="Red" ErrorMessage="Enter Letters Only!" />

                        </div>
                    </div>
                    <asp:Label ID="lblmsg" runat="server" Text=""></asp:Label>
                    <div class="row">
                        <div class="col-sm-10 col-sm-offset-1">
                            <asp:ScriptManager EnablePartialRendering="true"
                                ID="ScriptManager1" runat="server" EnablePageMethods="true">
                            </asp:ScriptManager>
                            <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                <ContentTemplate>
                                    <asp:GridView ID="gvDisplay" runat="server" AutoGenerateColumns="false" CssClass="table table-bordered" DataKeyNames="Id,Cost" Style="background-color: antiquewhite; font-size: large; text-align: left; vertical-align: middle;">
                                        <Columns>
                                            <asp:TemplateField HeaderText="QTY">
                                                <ItemTemplate>
                                                    <asp:TextBox runat="server" CssClass="form-control" ID="txtValidID" Width="100px" CausesValidation="False"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="Description" HeaderText="Description" />
                                            <asp:BoundField DataField="Cost" HeaderText="Price Per"  DataFormatString="{0:C2}"/>
                                        </Columns>
                                    </asp:GridView>
                                </ContentTemplate>
                            </asp:UpdatePanel>



                        </div>
                    </div>
                    <p>
                        I represent that I am the individual above. I understand that any attempt
                        to obtain an ID card using any false information or for any fraudulent purpose may subject me to discipline pursuant to the 
                        student code of conduct as well as applicable local, state, federal laws
                    </p>

                    <label for="lblSign" style="font-size: medium">Signature (print your name):</label>
                    <br>
                    <asp:TextBox ID="txtSignature" class="form-control" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqSignature" runat="server" ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtSignature" ValidationExpression="[aA-zZ]"></asp:RequiredFieldValidator>

                    <asp:RegularExpressionValidator runat="server" ID="regSignature" ControlToValidate="txtSignature" ValidationExpression="[a-zA-Z\s]{2,}$" ForeColor="Red" ErrorMessage="Must be at least 2 letters!" />

                    <br />

                    <div class="row">
                        <div class="col-sm-6" style="text-align: center">
                            <asp:Button ID="btnGoBack" runat="server" Text="Go Back" Style="font-size: large; background-color: darkslategrey; color: white; height: 50px; width: 150px;" class="btn btn-primary" CausesValidation="False" OnClick="btnCancel_Click" />
                        </div>
                        <div class="col-sm-6" style="text-align: center">
                            <asp:Button ID="Button1" runat="server" Style="font-size: large; background-color: #990d0a; border: #990d0a; color: white; height: 50px; width: 150px;" Text="Submit" OnClick="btnSubmit_Click1" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</asp:Content>
