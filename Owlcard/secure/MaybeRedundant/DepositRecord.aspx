<%@ Page Title="" Language="C#" MasterPageFile="~/secure/Nav.Master" AutoEventWireup="true" CodeBehind="DepositRecord.aspx.cs" Inherits="OwlCard.DepositRecord" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
	
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
	<%--Deposit Form.--%>


	 <div class="container">
        <div class="row" style="background-color:lightgreen">

            
            <div class="col-sm-8 col-sm-offset-2">
                <center><h2>Deposit Form</h2><br /></center>
                <p>
				Use this form for the <strong>check or cash</strong> deposits to a Diamond Dolllars account.
			For deposit by <strong>credit card</strong>, please visit our at <strong>www.temple.edu/diamonddollars.</strong>
			</p>
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
                                
                            </div>
                            <div class="col-xs-2">
                               <asp:RadioButton ID="RadioButton3"  GroupName="Payment"  runat="server" value="Cash"/>Cash
                                <br />
                                
                            </div>
                            <div class="col-xs-2">
                                <asp:RadioButton ID="RadioButton5"  GroupName="Payment"  runat="server" value="Diamond"/>Check
                                <br />
                                
                                
                            </div>
                            <div class="col-xs-5">
                                <asp:RadioButton ID="RadioButton7"  GroupName="Payment"  runat="server" value="Diamond"/>Diamond Dollars
                                <br />
                                
                                
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-3">
                                
                                <label for="Photo">Amount:</label>
                            </div>
                            <div class="col-xs-2">
                               
                                
                                <asp:RadioButton ID="PhotoNew"  GroupName="Photo"  runat="server" value="New"/>25
                            </div>
                            <div class="col-xs-2">
                                
                                
                                <asp:RadioButton ID="PhotoOld"  GroupName="Photo"  runat="server" value="Old"/>50
                                <br />
                                
                            </div>
                            <div class="col-xs-2">
                                
                                
                                <asp:RadioButton ID="RadioButton2"  GroupName="Photo"  runat="server" value="Old"/>75
                                <br />
                                
                            </div>
                            <div class="col-xs-3">
                                
                                
                                <asp:RadioButton ID="RadioButton1"  GroupName="Photo"  runat="server" value="Old"/>100
                                <br />
                                
                            </div>
                            </div>
                            <div class="row">
                            <div class="col-xs-3">
                                <br>
                                <label  for="payment">Other Amount:</label><br />
                                <br />
                                </div>
                                <div class="col-xs-4">
                                    <br>
                                <asp:Textbox id="Textbox1" class="form-control" runat="server"></asp:Textbox>
                                <br />
                                </div>
                                <div class="col-xs-5">
                                
                                <br />
                                </div>
                            </div>
                                
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                        <label class="alert-info" for="payment">*Make check payable to Temple University, TUid# on memo line, minimum $25.</label><br />
                        </div>
                            </div>

            <br><br>
                        <p>
                            I represent that I am the individual above. I understand that any attempt
                            to obtain an ID card using any false information or for any false information
                            or for any fraudulent purpose may subject me to discipline pursuant to the 
                            student code of conduct as well as applicable local, state, federal laws
                        </p>
                        <br />
                    <label for="lblSign">Signature(print your name):</label>
                    <asp:Textbox id="txtSignature" class="form-control" runat="server"></asp:Textbox>
                        <br><br><br>
                        <div class="row">
                            <div class="col-sm-4">
                            <Button type="button" ID="btnBack" onclick="window.location.href='Request.aspx'" style="background-color:lightgray; border:lightgray; color: black; height:50px; width:150px;" runat="server" class="btn btn-primary" >Back</button>
                            </div>
                            <div class="col-sm-4 " >
                                
                        </div>
                            <div class="col-sm-4 " >
                                <Button  type="button" ID="Button1" onclick="window.location.href='Request.aspx'" style="background-color:#990d0a; border:#990d0a; color: white; height:50px; width:150px;" runat="server" class="btn btn-primary" >Submit</button>
                        </div>
                            </div>
                </div>
            </div>

           

            
            <div class="col">
                
            </div>
        

            </div>
        

    <br><br>
</asp:Content>
