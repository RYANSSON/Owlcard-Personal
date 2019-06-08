<%@ Page Title="" Language="C#" MasterPageFile="~/secure/Navadmin.Master" AutoEventWireup="true" CodeBehind="Request.aspx.cs" Inherits="OwlCard.Request" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="css/request.css" />
    <link rel="stylesheet" href="css/forms.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div class="container">
        <div class="row">

            <%-- Main div --%>
            <div class="col-sm-12" style="margin: auto; float: none;">

                <%-- main form --%>
                <form id="form1" runat="server">

                    <asp:ScriptManager EnablePartialRendering="true"
                        ID="ScriptManager1" runat="server" EnablePageMethods="true" >
                    </asp:ScriptManager>

                    <%-- hidden button called by javascript --%>
                    <asp:Button ID="modalForm" runat="server" Text="0" OnClick="modal_Click" Style="display: none;" ClientInstanceName="ModalButton" />
                    <%-- hidden field to hold value of row selected and update on change --%>
                    <asp:HiddenField ID="ValueHiddenField" OnValueChanged="modal_Click" Value="" runat="server" />

                    <%-- Update panel for ajax async updates to the table and modals --%>
                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                        <ContentTemplate>
                            <h1>
                                <asp:Label runat="server" ID="lblTableTitle">Unapproved Transactions</asp:Label></h1>
                            <div class="row col-sm-12">
                                <div class="col-sm-5">
                                    <asp:Label ID="lblInstructions" runat="server" Style="margin-top: 5px">***Click the row to view the transaction as entered***</asp:Label>
                                </div>
                                <div class="col-sm-7">
                                    <div class="col-sm-3" style="text-align: right; margin-top: 5px">
                                        <label for="txtSearch">Filter by Name:</label></div>
                                    <div class="col-sm-5">
                                        <asp:TextBox runat="server" ID="txtSearch"  placeholder="Name" CssClass="form-control" Width="100%"></asp:TextBox>
                                    </div>
                                    <div class="col-sm-4">
                                        <asp:Button runat="server" Text="Filter" OnClick="FilterTransactions_Click" class="btn" Style="background-color:#9D2134;" ForeColor="white"/>
                                        <asp:Button runat="server" Text="Reset" OnClick="ResetTransactions_Click" class="btn" BackColor="#e1e1e1"/>
                                    </div>

                                </div>
                            </div>




                            <div class="tab" style="min-width: 900px">
                                <asp:Button runat="server" ID="btnCurrentItems" class="tab tablinks active" OnClick="CurrentQue" Text="Unapproved" />
                                <asp:Button runat="server" ID="btnTodaysHistory" class="tab tablinks" OnClick="TodaysHistory" Text="Today's" />
                            </div>

                            <%-- approval gridview --%>
                            <asp:GridView ID="gvDisplay" runat="server" AutoGenerateColumns="false" CssClass="table" DataKeyNames="Id,TransactionType,Approved,PhotoChoice,Signature,IdType" OnRowDataBound="OnRowDataBound" Style="text-align: center; vertical-align: central;">
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
                                            <asp:DropDownList runat="server" ID="ddTransactionType" OnSelectedIndexChanged="ddTransactionType_SelectedIndexChanged" AutoPostBack="true" Style="width: 100px;" CssClass="btn btn-secondary dropdown-toggle">
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
                                    <%-- button to attemp and approve or deny the transactions --%>
                                    <asp:TemplateField HeaderText="">
                                        <ItemTemplate>
                                            <asp:Button CssClass="btn" runat="server" ID="btnRowSubmit" Text="Submit" OnClick="approveClick" BackColor="#9D2235" style="color:white;" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>

                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <asp:UpdatePanel ID="warning" runat="server">
                        <ContentTemplate>
                            <%-- Alert modal on failed transaction update --%>
                            <div class="modal" id="myModal2" onclick="modalClose2()" runat="server" style="display: none;">
                                <asp:Button ID="btnClose2" class="close" runat="server" OnClick="closeModal2" Text="X"></asp:Button>
                                <div id="modalSide2">
                                    <div class="modal-content" id="modal-content2">
                                        <asp:Label ID="lblWarning" runat="server"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>


                    <%-- Form modal with hidden fields that are shown based on the transaction type --%>-
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

                </form>
            </div>
            <%-- End Spacing div --%>
            <div class="col-sm-1">
            </div>
        </div>
        <br />
        <br />
        <br />
        <br />
        <br />
    </div>
    <div class="footer" style="background-color:#9D2134; color: white; line-height: normal; vertical-align: middle;">
            <br />
            <p>Temple University - OWLCard Office</p>
        </div>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>

    <%-- Script to open modals on row click --%>
    <script type="text/javascript">
        $(document).ready(function () {
            $(".clickable").live('click', 'td.clickable', function () {

                var row = this.closest('tr.mainTableRow').rowIndex - 1;

                document.getElementById("body_ValueHiddenField").value = row;
                document.getElementById("body_modalForm").click();

            });
        });
    </script>

    <script type="text/javascript">
        function modalClose() {
            document.getElementById("body_btnClose").click();
        }
        function modalClose2() {
            document.getElementById("body_btnClose2").click();
        }

        var changed = false;
        $("[src *= plus]").live("click", "[src *= plus]", function () {

            $(this).closest("tr").after("<tr><td></td><td colspan = '999'>" + $(this).next().html() + "</td></tr>")
            $(this).attr("src", "images/minus.png");
            changed = true;
        });


        $("[src *= minus]").live("click", "[src*=minus]", function () {
            $(this).attr("src", "images/plus.png");
            $(this).closest("tr").next().remove();
        });


    </script>
</asp:Content>
