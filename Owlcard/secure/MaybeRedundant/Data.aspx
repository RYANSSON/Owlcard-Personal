<%@ Page Title="" Language="C#" MasterPageFile="~/secure/Nav.Master" AutoEventWireup="true" CodeBehind="Data.aspx.cs" Inherits="OwlCard.Data" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="col-sm-6 col-sm-offset-3">
    <table class="table">
    <thead>
      <tr>
        <th>Name</th>
        <th>Major</th>
        <th>Email</th>
          <th>Acceptance</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Jiaming Wang</td>
        <td>IST</td>
        <td>tue42933@temple.edu</td>
          <td>
              <button onclick="myFunction()" >accept</button>
          </td>
      </tr>
      <tr>
        <td>Ardal Kelley</td>
        <td>Math</td>
        <td>tua12345@temple.edu</td>
          <td>
              <button onclick="myFunction()" >accept</button>
          </td>
      </tr>
      
    </tbody>
  </table>
        </div>
</asp:Content>
