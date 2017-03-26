<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Results.aspx.cs" Inherits="WebApplication6.WebForm2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron">
        <h1>Results Page</h1>
        <p class="lead" aria-multiselectable="False" spellcheck="true">Below is the results from all of the completed analysis of uploaded retinal scans.</p>
        <p class="lead" aria-multiselectable="False" spellcheck="true">
            <asp:Label ID="Label1" runat="server" Text="Results"></asp:Label>
        </p>
        <p class="lead" aria-multiselectable="False" spellcheck="true">
            <asp:Label ID="Label2" runat="server" Text="Score"></asp:Label>
        </p>
        
                <%--<div class="container">
        <div class="section z-depth-2 blue-grey lighten-5">
            <asp:Repeater ID="rptResults1" runat="server">
                <HeaderTemplate><table style="width: 25%" ></HeaderTemplate>
                <ItemTemplate>
                <tr>
                    <td><strong>Results <%# Container.ItemIndex + 1 %>:</strong></td>
                    <td><%# Container.DataItem %></td>
                </tr>
                </ItemTemplate>
                <FooterTemplate></table></FooterTemplate>
            </asp:Repeater>
        </div>
        </div>--%>
        
    </div>
</asp:Content>
