<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Results.aspx.cs" Inherits="WebApplication6.WebForm2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron">
        <h1>Results Page</h1>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [ResultsDataBase]"></asp:SqlDataSource>
        <p class="lead" aria-multiselectable="False" spellcheck="true">Below is the results from all of the completed analysis of uploaded retinal scans.</p>
        
        <asp:GridView ID="GridView1" HeaderStyle-BackColor="#3AC0F2" HeaderStyle-ForeColor="White"
            runat="server" AutoGenerateColumns="False" Height="255px" Width="1083px" AllowSorting="True" DataKeyNames="Id" DataSourceID="SqlDataSource2">
            <Columns>
                <asp:BoundField DataField="Id" HeaderText="Id" ItemStyle-Width="125" ReadOnly="True" SortExpression="Id" />
                <asp:BoundField DataField="Name" HeaderText="Name" ItemStyle-Width="150" SortExpression="Name" />
                <asp:BoundField DataField="ImgNumber" HeaderText="ImgNumber" ItemStyle-Width="100" SortExpression="ImgNumber" />
                <asp:BoundField DataField="Sensitivity" HeaderText="Sensitivity" ItemStyle-Width="100" SortExpression="Sensitivity" />
                <asp:BoundField DataField="Specificity" HeaderText="Specificity" ItemStyle-Width="100" SortExpression="Specificity" />
                <asp:BoundField DataField="Precision" HeaderText="Precision" ItemStyle-Width="100" SortExpression="Precision" />
                <asp:BoundField DataField="Accuracy" HeaderText="Accuracy" ItemStyle-Width= "100" SortExpression="Accuracy" />


                <asp:BoundField DataField="kappa" HeaderText="kappa" SortExpression="kappa" />


            </Columns>

<HeaderStyle BackColor="#3AC0F2" ForeColor="White"></HeaderStyle>
        </asp:GridView>


        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [ResultsDataBase]"></asp:SqlDataSource>


    </div>
</asp:Content>
