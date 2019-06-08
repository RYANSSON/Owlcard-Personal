<%@ Page Title="" Language="C#" MasterPageFile="~/secure/Nav.Master" AutoEventWireup="true" CodeBehind="NewCardRecord.aspx.cs" Inherits="OwlCard.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br><br>
     <div class="container" style="background-color:lightblue">
        <div class="row">

            
            <div class="col-sm-8 col-sm-offset-2">
                <center><h2>First Card Form</h2><br /></center>
                
                    <div class="form-group">
                    
                        <div class="row">
                            <div class="col-xs-6">
                                <label for="FName">First Name:</label>
                                <asp:Textbox id="txtFirstName" placeholder="Jiaming" class="form-control" runat="server"></asp:Textbox>
                            </div>
                            <div class="col-xs-6">
                                <label for="LName">Last Name:</label>
                                <asp:Textbox id="txtLastName" placeholder="Wang" class="form-control" runat="server"></asp:Textbox>
                            </div>
                        </div>
                    
                        
                    <label for="tuID">TUID:</label>
                    <asp:Textbox id="txtID" placeholder="9134879631" class="form-control" runat="server"></asp:Textbox>
                     

                        <p>
                            I represent that I am the individual above. I understand that any attempt
                            to obtain an ID card using any false information or for any false information
                            or for any fraudulent purpose may subject me to discipline pursuant to the 
                            student code of conduct as well as applicable local, state, federal laws
                        </p>
                        <br />
                    <label for="lblSign">Signature(print your name):</label>
                    <asp:Textbox id="txtSignature" placeholder="Jiaming Wang" class="form-control" runat="server"></asp:Textbox>
                        <br><br><br>
                        <div class="row">
                            <div class="col-sm-4">
                            <Button type="button" ID="btnBack" onclick="window.location.href='Request.aspx'" style="background-color:lightgray; border:lightgray; color: black; height:50px; width:150px;" runat="server" class="btn btn-primary" >Delete</button>
                            </div>
                            <div class="col-sm-4 " >
                                
                        </div>
                            <div class="col-sm-4 " >
                                <Button  type="button" ID="Button1" onclick="window.location.href='Request.aspx'" style="background-color:#990d0a; border:#990d0a; color: white; height:50px; width:150px;" runat="server" class="btn btn-primary" >Process</button>
                        </div>
                            </div>
                </div>
            </div>

           

            
            <div class="col">
                
            </div>
        

            </div>
        </div>
</asp:Content>