<%@ Page Title="" Language="C#" MasterPageFile="~/secure/Navadmin.Master" AutoEventWireup="true" CodeBehind="ItemsPage.aspx.cs" Inherits="OwlCard.secure.ItemsPage" %>

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
    <link rel="stylesheet" type="text/css" href="css/header.css" />
    
    <link rel="stylesheet" href="css/forms.css" />
    <style>
           .tablesorter-bootstrap thead th, .tablesorter-bootstrap thead td, .tablesorter-bootstrap tfoot td {
    background-color: #9D2134;
    color:white;
}
           td{
            text-align:center;
        }
           .table{
               border:none
           }
           .table tr {
               border: none;
               border-top: 1px solid lightgray;
           }
           .table td{
               border:none;
           }
           .table th{
               border:none;
           }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div style="width: 100%; bottom: 0; background-color: #F0F0F0">
        <div class="container">
            <div class="row">
                <div class="col-sm-12" style="float: none;">
                    <form id="form1" runat="server">

                        <asp:ScriptManager EnablePartialRendering="true"
                            ID="ScriptManager1" runat="server" EnablePageMethods="true">
                        </asp:ScriptManager>

                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-inline">
                                    <div class="form-group" style="width: 100%">
                                        <div class="row col-sm-12" style="border: thin solid #000000; background-color: white; padding-bottom: 20px; border-radius:25px; padding-left:20px; ">
                                            <h1 style="text-align: center; font-size: 42px;">Sale Items</h1>
                                            <div class="col-lg-5">

                                                <div class="row col-sm-12">
                                                    <h3>Add New Item</h3>
                                                    <asp:Label runat="server" ID="lblAddWarning" Text="Please enter valid information" Style="display: none; color: red;"></asp:Label>
                                                    <div class=" col-lg-5 col-md-3">
                                                        <asp:Label ID="lbName" runat="server" Text="Name: " CssClass="control-label"></asp:Label>
                                                        <br />
                                                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control input-sm" type="text" placeholder="Enter Name" Enabled="True" autocomplete="off" Width="150px" CausesValidation="True" />
                                                    </div>
                                                    <div class="col-lg-7 col-md-3">
                                                        <asp:Label ID="lblCost" runat="server" Text="Cost: " CssClass="control-label"></asp:Label>
                                                        <br />
                                                        <asp:TextBox ID="txtCost" runat="server" CssClass="form-control input-sm" type="number" placeholder="Enter Cost" Enabled="True" autocomplete="off" Width="150px" CausesValidation="True" />
                                                    </div>
                                                    
                                                    
                                                    <div class="col-lg-12 col-md-6">
                                                        <asp:Label ID="lblDescription" runat="server" Text="Description: " CssClass="control-label"></asp:Label>
                                                        <br />
                                                        <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control input-sm" type="text" placeholder="Enter Description" Enabled="True" autocomplete="off" Width="270px" TabIndex="2" />
                                                        &nbsp&nbsp
                                                    <asp:Button runat="server" Text="Add" OnClick="Add_Click" CssClass="btn" TabIndex="3" BackColor="#9D2134" ForeColor="white" />
                                                    </div>
                                                    <br />
                                                    <br />


                                                </div>
                                            </div>
                                            <div class="col-lg-7">

                                                <div class="row col-lg-12 col-sm-12 col-md-4">
                                                    <h3>Update Existing Item</h3>
                                                    <asp:Label runat="server" ID="lblIdWarning" Text="Please enter a valid ID" Style="display: none; color: red;"></asp:Label>
                                                    <asp:Label ID="lblUpdateRow" runat="server" Text="Item ID: " CssClass="control-label"></asp:Label>
                                                    <asp:TextBox ID="txtUpdateRow" runat="server" CssClass="form-control input-sm" type="number" Enabled="True" autocomplete="off" Width="100px" TabIndex="4" CausesValidation="True" />
                                                    &nbsp
                                                    <asp:Button runat="server" Text="Get Item" OnClick="Update_Click" class="btn" TabIndex="5" BackColor="#9D2134" ForeColor="white"/>
                                                </div>
                                                <div class="row col-lg-12 col-sm-12 col-md-8" >
                                                    <br /> 

                                                    <asp:GridView ID="gvItems" runat="server" AutoGenerateColumns="false" CssClass="table" Style="display: none; width: 100%;" DataKeyNames="Name,Description,Cost" BorderStyle="None">
                                                        <Columns>
                                                            <asp:BoundField DataField="Id" HeaderText="ID" />
                                                            <asp:TemplateField HeaderText="Name">
                                                                <ItemTemplate>
                                                                    <asp:TextBox runat="server" CssClass="form-control" ID="txtUpdateName" Width="100px" CausesValidation="False"></asp:TextBox>
                                                                    <asp:DynamicFilter ID="DynamicFilter1" runat="server"></asp:DynamicFilter>

                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Description">
                                                                <ItemTemplate>
                                                                    <asp:TextBox runat="server" CssClass="form-control" ID="txtUpdateDescription" Width="100px" CausesValidation="False"></asp:TextBox>
                                                                    <asp:DynamicFilter ID="DynamicFilter2" runat="server"></asp:DynamicFilter>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Cost">
                                                                <ItemTemplate>
                                                                    <asp:TextBox runat="server" CssClass="form-control" ID="txtUpdateCost" Width="100px" CausesValidation="False"></asp:TextBox>
                                                                    <asp:DynamicFilter ID="DynamicFilter3" runat="server"></asp:DynamicFilter>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="">
                                                                <ItemTemplate>
                                                                    <asp:Button runat="server" Text="Update" OnClick="SubmitUpdate_Click" class="btn" Style="background-color: green; border: #990d0a; color: white;"/>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                             <asp:TemplateField HeaderText="">
                                                            <ItemTemplate>
                                                                <asp:Button runat="server" Text="Delete" OnClick="DeleteUpdate_Click" class="btn" BackColor="#9D2134" ForeColor="white"/>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
                                            </div>
                                        </div>

                                        <br />
                                    </div>
                                    <br />
                                    <br />

                                </div>
                            </div>
                        </div>
                        <br />
                        <div class="row">
                        <div id="divDisplay" runat="Server"></div>
                        </div>
                        <br />
                        <br />
                        <br />
                    </form>

                </div>
            </div>
        </div>
    </div>
    <div class="footer" style="background-color: #9D2134; color: white; line-height: normal; vertical-align: middle;">
        <br />
        <p>Temple University - OWLCard Office</p>
    </div>
</asp:Content>
