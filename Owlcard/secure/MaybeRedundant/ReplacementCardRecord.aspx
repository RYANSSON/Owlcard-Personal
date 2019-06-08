<%@ Page Title="" Language="C#" MasterPageFile="~/secure/Nav.Master" AutoEventWireup="true" CodeBehind="ReplacementCardRecord.aspx.cs" Inherits="OwlCard.ReplacementCardRecord" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br><br>
    <div class="container" style="background-color:lightpink">
        <div class="row">

            
            <div class="col-sm-8 col-sm-offset-2">
                <center><h2>Replacement Lost/Stolen/Damaged <br />Student OWLCard<br />Price- $20.00</h2><br /></center>
                
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
                     
                        <div class="row">
                            <div class="col-xs-3">
                                <label for="payment">Payment Method:</label><br />
                                <label for="Photo">Photo Options:</label>
                            </div>
                            <div class="col-xs-5">
                               <asp:RadioButton ID="payment1"  GroupName="Payment"  runat="server" value="Cash"/>Cash
                                <br />
                                <br />
                                <asp:RadioButton ID="PhotoNew"  GroupName="Photo"  runat="server" value="New"/>Take a new photo
                            </div>
                            <div class="col-xs-4">
                                <asp:RadioButton ID="payment2"  GroupName="Payment"  runat="server" value="Diamond"/>Diamond Dollars
                                <br />
                                <br />
                                <asp:RadioButton ID="PhotoOld"  GroupName="Photo"  runat="server" value="Old"/>Keep current photo
                                <br />
                                
                            </div>
                        </div>

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
                        
                        
                        
                        
                        
                    <%--<label for="lblSign">Signature:</label>
                    <asp:Textbox id="txtSignature" class="form-control" runat="server"></asp:Textbox>--%>

                        
                </div>
            </div>

           

            
            <div class="col">
                
            </div>
        

            </div>
</asp:Content>
