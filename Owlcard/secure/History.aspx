<%@ Page Title="" Language="C#" MasterPageFile="~/secure/Navadmin.Master" AutoEventWireup="true" CodeBehind="History.aspx.cs" Inherits="OwlCard.History" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker.css" rel="stylesheet" type="text/css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/js/bootstrap-datepicker.js"></script>

    <link href="css/theme.bootstrap.css" rel="stylesheet">
    <link href="css/jquery.tablesorter.pager.css" rel="stylesheet"> 
    <script src="js/jquery.tablesorter.js"></script> 
    <script src="js/jquery.tablesorter.widgets.js"></script> 
    <script src="js/jquery.tablesorter.pager.js"></script> 
    <link rel="stylesheet" href="css/bootstrap.min.css" />

    <!-- To AVOID errors in chrome console we need to update web config file or add link to glipcoins css specifically https://stackoverflow.com/questions/32300578/how-to-remove-error-about-glyphicons-halflings-regular-woff2-not-found -->
    
    <link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
    
    <link rel="stylesheet" href="css/history.css" />
    <script src="js/validation.js"></script>
    <script src="js/modalLoad.js"></script>
     <link rel="stylesheet" type="text/css" href="css/header.css"/>
    <link rel="stylesheet" href="css/forms.css" />
    <style>
        .tablesorter-bootstrap thead th, .tablesorter-bootstrap thead td, .tablesorter-bootstrap tfoot td {
    background-color: #9D2134;
    color:white;
}
        td{
            text-align:center;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div style="background-color:#F0F0F0;">
    <div class="container">
        <form id="form1" runat="server">
              <%-- hidden button called by javascript --%>
            <asp:Button ID="modalForm" runat="server" Text="0" OnClick="modal_Click" Style="display: none;" ClientInstanceName="ModalButton" />
            <%-- hidden field to hold value of row selected and update on change --%>
            <asp:HiddenField ID="ValueHiddenField" OnValueChanged="modal_Click" Value="" runat="server" />
            <div class="jumbotron" style="border: thin solid #000000; background-color:white;">
                <asp:Label ID="lblmsg" runat="server" Text=""></asp:Label>
                <h2>Enter Search Criteria</h2>
                <!-- search criteria fields -->
           <div class="form-group row">
                                <div class="col-xs-2">
                                    <asp:Label ID="lblTUID" runat="server" Text="TUID:" CssClass="control-label"></asp:Label>
                                    <asp:TextBox ID="txtTUID" runat="server" CssClass="form-control input-sm" type="text" placeholder="Enter TUID" autocomplete="off" />
                                </div>
                                <div class="col-xs-2">
                                    <asp:Label ID="lblFirst" runat="server" Text="Name:" CssClass="control-labe" for="txtFirst"></asp:Label>
                                    <asp:TextBox ID="txtFirst" runat="server" CssClass="form-control input-sm" type="text" placeholder="Enter Name" autocomplete="off" />
                                </div>

                                <div class="col-xs-2">
                                    <asp:Label ID="lblStartDate" runat="server" Text="Start Date:" CssClass="control-label"></asp:Label>
                                    <input data-provide="datepicker" type="text" runat="server" id="startDate" enableviewstate="True" class="form-control input-sm" placeholder="Enter Start Date"  autocomplete="off"/>
                                </div>
                                <div class="col-xs-2">
                                    <asp:Label ID="lblEndDate" runat="server" Text="End Date:" CssClass="control-label"></asp:Label>
                                    <input data-provide="datepicker" type="text" runat="server" id="endDate" enableviewstate="True" class="form-control input-sm" placeholder="Enter End Date" autocomplete="off"/>
                                </div>
                                <div class="col-xs-2">
                                    <asp:Label ID="lblType" runat="server" Text="Type:" CssClass="control-label"></asp:Label>
                                    <asp:DropDownList ID="ddlType" runat="server" CssClass="form-control input-sm">
                                        <asp:ListItem Value="">-- Select Type --</asp:ListItem>
                                        <asp:ListItem Value="Cash">Cash</asp:ListItem>
                                        <asp:ListItem Value="Diamond">Diamond</asp:ListItem>
                                        <asp:ListItem Value="New">New Owlcard</asp:ListItem>
                                        <asp:ListItem Value="Replace">Replace Owlcard</asp:ListItem>
                                        <asp:ListItem Value="Deposit">Deposit</asp:ListItem>
                                        <asp:ListItem Value="Purchase">Purchase</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-xs-2">
                                     <asp:Label ID="Label1" runat="server" Text="Status:" CssClass="control-label"></asp:Label>
                        <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control input-sm">
                            <asp:ListItem Value="">-- Select Status --</asp:ListItem>
                            <asp:ListItem Value="Approved">Approved</asp:ListItem>
                            <asp:ListItem Value="Denied">Denied</asp:ListItem>
                            
                            </asp:DropDownList>
                                </div>
                    </div>
                    <!-- search and clear buttons -->
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-inline">
                                <asp:Button ID="btnSearch" runat="server" CssClass="btn" Text="Search" OnClick="btnSearch_Click" BackColor="#9D2134" ForeColor="white"/>
                                <asp:Button ID="btnClearSearch" runat="server" CssClass="btn" Text="Clear Search" OnClick="btnClearSearch_Click" BorderColor="Black" />
                            </div>
                        </div>
                    </div>

                </div>
            <div class="row">
                <div class="col-sm-12">
                    <div id="divDisplay" runat="Server"></div>
                </div>
            </div>
            <br />
            <br /><br />
               <%-- Form modal with hidden fields that are shown based on the transaction type --%>-
            <div class="container">
                            <div class="modal" runat="server" id="myModal" onclick="modalClose()" style="display: none; width: 100%; height: 1000px;">
                                <asp:Button ID="btnClose" class="close" runat="server" OnClick="closeModal" Text="X"></asp:Button>
                                <div id="modalSide">
                                    <div class="modal-content" id="modal-content" onclick="close">
                                        <center><h2><asp:Label runat="server" ID="lblFormTitle"></asp:Label></h2><br /></center>
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-xs-4">
                                                    <label for="FName" style="font-size: large">First Name:</label>
                                                    <asp:TextBox ID="txtFirstName" class="form-control" runat="server" Font-Size="Large" Enabled="false"></asp:TextBox>

                                                </div>
                                                <div class="col-xs-4">
                                                    <label for="LName" style="font-size: large">Last Name:</label>
                                                    <asp:TextBox ID="txtLastName" class="form-control" runat="server" Font-Size="Large" Enabled="false"></asp:TextBox>

                                                </div>
                                                <div class="col-xs-4">
                                                    <label for="tuID" style="font-size: large">TUID:</label>
                                                    <asp:TextBox ID="txtID" class="form-control" runat="server" Font-Size="Large" Enabled="false"></asp:TextBox>


                                                </div>
                                            </div>
                                            <br />
                                            <%-- Owlcard Form Payment method fields --%>
                                            <div class="row" runat="server" id="RowOwlcardOptions">
                                                <div class="col-xs-6">
                                                    <label for="payment" style="font-size: large">Payment Method:</label><br />
                                                    <asp:DropDownList ID="ddlOwlcardPaymentMethod" runat="server" Style="font-size: medium;" CssClass="form-control" Enabled="false">
                                                        <asp:ListItem Selected="True">Cash</asp:ListItem>
                                                        <asp:ListItem>Diamond Dollars</asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                                <div class="col-xs-6">
                                                    <label for="Photo" style="font-size: large">Photo Options:</label>
                                                    <asp:DropDownList ID="ddlPhotoOptions" runat="server" Style="font-size: medium;" CssClass="form-control" Enabled="false">
                                                        <asp:ListItem Selected="True">Keep Existing Photo</asp:ListItem>
                                                        <asp:ListItem>Take New Photo</asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                            </div>


                                            <%-- Deposite form deposite amount fields --%>
                                            <div runat="server" id="RowDeposit">
                                                <div class="row">
                                                    <div class="col-sm-3">
                                                        <label for="payment" style="font-size: large">Payment Method:</label><br />
                                                        <asp:DropDownList ID="ddlDepositPaymentMethod" runat="server" CssClass="form-control" Font-Size="Large" Enabled="false">
                                                            <asp:ListItem Selected="True">Cash</asp:ListItem>
                                                            <asp:ListItem>Check</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <label for="amount" style="font-size: large">Amount:</label><br />
                                                        <asp:DropDownList runat="server" ID="ddlDepositPaymentAmount" AutoPostBack="True" CssClass="form-control" Font-Size="Large" Enabled="false">
                                                            <asp:ListItem Selected="True">$25</asp:ListItem>
                                                            <asp:ListItem>$50</asp:ListItem>
                                                            <asp:ListItem>$75</asp:ListItem>
                                                            <asp:ListItem>$100</asp:ListItem>
                                                            <asp:ListItem>Other</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <label for="payment" style="font-size: large">Other Amount:</label><br />
                                                        <asp:TextBox ID="txtDepositAmount" class="form-control" runat="server" Enabled="False" Font-Size="Large" CssClass="form-control"></asp:TextBox>
                                                    </div>
                                                </div>

                                                <br />
                                                <div class="row">
                                                    <div class="col-xs-12">
                                                        <label for="payment" style="font-size: medium; color: #990d0a"><u>* Make check payable to Temple University, TUid# on memo line, minimum $25.</u></label><br />
                                                    </div>
                                                </div>
                                            </div>
                                            <%-- Purchase form item selection fields --%>
                                            <div class="row" runat="server" id="RowPurchases">
                                                <div class="col-sm-10 col-sm-offset-1">
                                                    <asp:GridView ID="gvPurchases" runat="server" AutoGenerateColumns="false" CssClass="table table-bordered" DataKeyNames="Quantity" Style="background-color: antiquewhite; font-size: large; text-align: left; vertical-align: middle;">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="QTY">
                                                                <ItemTemplate>
                                                                    <asp:TextBox runat="server" CssClass="form-control" ID="txtValidID" Width="100px" CausesValidation="False" Enabled="false"></asp:TextBox>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:BoundField DataField="Name" HeaderText="Name" />
                                                            <asp:BoundField DataField="Description" HeaderText="Description" />
                                                            <asp:BoundField DataField="Cost" HeaderText="Price Per" />
                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
                                            </div>

                                            <p>
                                                I represent that I am the individual above. I understand that any attempt
                            to obtain an ID card using any false information or for any false information
                            or for any fraudulent purpose may subject me to discipline pursuant to the 
                            student code of conduct as well as applicable local, state, federal laws
                                            </p>
                                            <br />
                                            <label for="lblSign">Signature(print your name):</label>
                                            <asp:TextBox ID="txtSignature" class="form-control" runat="server" ReadOnly="true" placeholder="Signature"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
             <%-- approval gridview --%>
                            <asp:GridView ID="gvDisplay" runat="server" AutoGenerateColumns="false" CssClass="table" DataKeyNames="Id,TransactionType,Approved,PhotoChoice,Signature,IdType" Style="text-align: center; vertical-align: central;" Visible="false">
                                <Columns>
                                    <asp:TemplateField HeaderText="View Items">
                                        <ItemTemplate>
                                            <%-- image acting as a button for dropdown of available transaction items --%>
                                            <img alt="" style="cursor: pointer; width: 20px; height: 20px;" src="images/plus.png" />
                                            <%-- hiddel panel containing the gridview of transaction items --%>
                                            <asp:Panel ID="pnlOrders" runat="server" Style="display: none">
                                                <asp:GridView ID="gvItems" runat="server" AutoGenerateColumns="false" CssClass="table">
                                                    <Columns>
                                                        <asp:BoundField ItemStyle-Width="150px" DataField="ItemId" HeaderText="Item Id" />
                                                        <asp:BoundField ItemStyle-Width="150px" DataField="Name" HeaderText="Item Name" />
                                                        <asp:BoundField ItemStyle-Width="150px" DataField="Quantity" HeaderText="Quantity" />
                                                        <asp:BoundField ItemStyle-Width="150px" DataField="TotalCost" HeaderText="Total Cost" DataFormatString="{0:C2}" />
                                                    </Columns>
                                                </asp:GridView>
                                            </asp:Panel>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="TUID" HeaderText="TUID" ReadOnly="true" />
                                    <asp:BoundField DataField="Name" HeaderText="Name" ReadOnly="true" />
                                    <asp:BoundField DataField="DateTime" HeaderText="DateTime" />
                                    <asp:BoundField DataField="Cost" HeaderText="Transaction Cost" DataFormatString="{0:C2}" />
                                    <asp:BoundField DataField="PaymentMethod" HeaderText="Payment Method" />
                                    <%-- drop down for new or replace transaction types(replaced with text in codebehind if it is a different transaction type --%>
                                    <asp:TemplateField HeaderText="Transaction Type">
                                        <ItemTemplate>
                                            <asp:DropDownList runat="server" ID="ddTransactionType" AutoPostBack="true" Style="width: 100px;" CssClass="btn btn-secondary dropdown-toggle">
                                                <asp:ListItem Value="null" disabled="true" Selected="true">Transaction Type</asp:ListItem>
                                                <asp:ListItem Value="New">New</asp:ListItem>
                                                <asp:ListItem Value="ReplaceNew">Replace - New Photo</asp:ListItem>
                                                <asp:ListItem Value="ReplaceOld">Replace - Old Photo</asp:ListItem>
                                                <asp:ListItem Value="FreeReplaceNew">Replace - New Photo(Free)</asp:ListItem>
                                                <asp:ListItem Value="FreeReplaceOld">Replace - Old Photo(Free)</asp:ListItem>
                                            </asp:DropDownList>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Validation ID">
                                        <ItemTemplate>
                                            <asp:TextBox runat="server" CssClass="form-control" ID="txtValidID" Width="100px" CausesValidation="False"></asp:TextBox>
                                            <asp:DynamicFilter ID="DynamicFilter1" runat="server"></asp:DynamicFilter>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <%-- Approve or deny dropdown options --%>
                                    <asp:TemplateField HeaderText="Approve/Deny">
                                        <ItemTemplate>
                                            <asp:DropDownList runat="server" ID="ddacceptance" Width="100px" CssClass="btn btn-secondary dropdown-toggle">
                                                <asp:ListItem Value="null" disabled="true" Selected="true">Status</asp:ListItem>
                                                <asp:ListItem Value="Accept">Approve</asp:ListItem>
                                                <asp:ListItem Value="Deny">Deny</asp:ListItem>
                                            </asp:DropDownList>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                  
                                </Columns>
                            </asp:GridView>
                </div>
        </form>
    </div>
        </div>
    <br />
    
    <div class="footer" style="background-color: #9D2134; color: white;">
        <br />
        <p>Temple University - OWLCard Office</p>
    </div>
   
</asp:Content>
