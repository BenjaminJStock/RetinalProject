<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Database.aspx.cs" Inherits="WebApplication6.Database" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            margin-top: 15px;
        }
    </style>
</head>
<body style="height: 399px">
    <form id="form1" runat="server">
        <div style="margin-left: 40px">

            <asp:SqlDataSource ID="SqlDataBaseZip" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Table] ORDER BY [Id]"></asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [ResultsDataBase]"></asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [AllResults]"></asp:SqlDataSource>
            <asp:Label ID="Label1" runat="server" Text="Name Database"></asp:Label>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="auto-style1" DataSourceID="SqlDataBaseZip" Height="85px" Width="409px" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical">
                <AlternatingRowStyle BackColor="#DCDCDC" />
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="Id" SortExpression="Id" />
                    <asp:BoundField DataField="Full_Name" HeaderText="Full_Name" SortExpression="Full_Name" />
                    <asp:BoundField DataField="Email_Address" HeaderText="Email_Address" SortExpression="Email_Address" />
                    <asp:BoundField DataField="Institution" HeaderText="Institution" SortExpression="Institution" />
                    <asp:BoundField DataField="ZipFileLocation" HeaderText="ZipFileLocation" SortExpression="ZipFileLocation" />

                    <asp:BoundField DataField="Dataset" HeaderText="Dataset" SortExpression="Dataset" />

                </Columns>
                <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                <SortedAscendingHeaderStyle BackColor="#0000A9" />
                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                <SortedDescendingHeaderStyle BackColor="#000065" />
            </asp:GridView>

            Results Database<br />
            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSource1">
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" SortExpression="Id" />
                    <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                    <asp:BoundField DataField="ImgNumber" HeaderText="ImgNumber" SortExpression="ImgNumber" />
                    <asp:BoundField DataField="Sensitivity" DataFormatString="{0:F8}" HeaderText="Sensitivity" SortExpression="Sensitivity" />
                    <asp:BoundField DataField="Specificity" DataFormatString="{0:F8}" HeaderText="Specificity" SortExpression="Specificity" />
                    <asp:BoundField DataField="Precision" DataFormatString="{0:F8}" HeaderText="Precision" SortExpression="Precision" />
                    <asp:BoundField DataField="Accuracy" DataFormatString="{0:F8}" HeaderText="Accuracy" SortExpression="Accuracy" />
                    <asp:BoundField DataField="kappa" DataFormatString="{0:F8}" HeaderText="kappa" SortExpression="kappa" />
                    <asp:BoundField DataField="Dataset" HeaderText="Dataset" />
                </Columns>
            </asp:GridView>
            
            AllResults Database<br />
            <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="Id" DataSourceID="SqlDataSource2" ForeColor="#333333" GridLines="None">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" SortExpression="Id" />
                    <asp:BoundField DataField="ImgNumber" HeaderText="ImgNumber" SortExpression="ImgNumber" />
                    <asp:BoundField DataField="Sensitivity" DataFormatString="{0:F8}" HeaderText="Sensitivity" SortExpression="Sensitivity" />
                    <asp:BoundField DataField="Specificity" DataFormatString="{0:F8}" HeaderText="Specificity" SortExpression="Specificity" />
                    <asp:BoundField DataField="Precision" DataFormatString="{0:F8}" HeaderText="Precision" SortExpression="Precision" />
                    <asp:BoundField DataField="Accuracy" DataFormatString="{0:F8}" HeaderText="Accuracy" SortExpression="Accuracy" />
                    <asp:BoundField DataField="kappa" DataFormatString="{0:F8}" HeaderText="kappa" SortExpression="kappa" />
                </Columns>
                <EditRowStyle BackColor="#2461BF" />
                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#EFF3FB" />
                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#F5F7FB" />
                <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                <SortedDescendingCellStyle BackColor="#E9EBEF" />
                <SortedDescendingHeaderStyle BackColor="#4870BE" />
            </asp:GridView>

        </div>
    </form>

    
</body>
</html>
