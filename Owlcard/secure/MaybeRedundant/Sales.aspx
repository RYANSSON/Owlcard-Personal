<%@ Page Title="" Language="C#" MasterPageFile="~/secure/Nav.Master" AutoEventWireup="true" CodeBehind="Sales.aspx.cs" Inherits="OwlCard.Sales" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
	<header class="container">
		<h2 class="h2">Purchases</h2>
		<p id="date"></p>
	</header>
	<%-- Purchase form header--%>
	<div class="container">
		<div class="row">
			<p class="mt-3 col-7">
				Print Name:
			<input id="customerName" type="text" class="form-control" />
			</p>
			
			<p class="mt-3 col-3">
				TUid # :
			<input id="TUid" type="text" class="form-control" />
			</p>
			

		</div>
		<%-- Student/Customer information--%>
		<div class="row">
			<table class="table-bordered w-100 mt-3">
				<thead>
					<tr>
						<th>Qty</th>
						<th>Description</th>
						<th>Price Per</th>
						<th>Total Amount</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>
							<input type="number" class="form-control" />
						</td>
						<td>Passport Photo (set of 2 images)</td>
						<td>$10.00</td>
						<td>$10.00</td>
					</tr>
					<tr>
						<td>
							<input type="number" class="form-control" />
						</td>
						<td>Passport Photo (set of 4 images)</td>
						<td>$15.00</td>
						<td>$15.00</td>
					</tr>
					<tr>
					</tr>
					<tr>
						<td>
							<input type="number" class="form-control" />
						</td>
						<td>ID Holder - neck lanyard</td>
						<td>$4.00</td>
						<td>$4.00</td>
					</tr>
					<tr>
						<td>
							<input type="number" class="form-control" />
						</td>
						<td>ID Holder - zip reel</td>
						<td>$5.00</td>
						<td>$4.00</td>
					</tr>
					<tr>
						<td>
							<input type="number" class="form-control" />
						</td>
						<td>ID Holder - wristlet</td>
						<td>$2.00</td>
						<td>$2.00</td>
					</tr>

				</tbody>
			</table>
		</div>
		<%-- table of items for purchases--%>
		<div class="row">
			<p class="col-7">
				Cashier's Name:
				<input id="cashierName" type="text" class="form-control" />
			</p>
			<br />
			<p class="col-4 justify-content-center">
				Grand Total:
				<label id="grandTotal">--</label>
			</p>'
			<span class="clearfix col-0"></span>
		</div>
		<%-- Cashier and grand total--%>
		<div class="row mt-3">
			<p class="col-8">
				Notes:
				<textarea id="notes" class="form-control"></textarea>
			</p>
			<br />
			<p class="col-4 alert-info align-content-center ">
				Deposits/Sales through cash or Diamond Dollars account - <strong>Sorry, no checks or credit cards</strong>
			</p>
		</div>
		<%-- Notes and warning --%>
	</div>
	<!--Purchase form content -->



</asp:Content>

