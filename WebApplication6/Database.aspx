 <%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Database.aspx.cs" Inherits="WebApplication6.Database" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div style="margin-left: 40px">
    
        <asp:SqlDataSource ID="Img_Database" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Table]"></asp:SqlDataSource>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" DataKeyNames="Id" DataSourceID="Img_Database" ForeColor="Black" GridLines="Vertical" Height="197px" Width="536px">
            <AlternatingRowStyle BackColor="#CCCCCC" />
            <Columns>
                <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" SortExpression="Id" />
                <asp:BoundField DataField="Full_Name" HeaderText="Full_Name" SortExpression="Full_Name" />
                <asp:BoundField DataField="Email_Address" HeaderText="Email_Address" SortExpression="Email_Address" />
                <asp:BoundField DataField="Institution" HeaderText="Institution" SortExpression="Institution" />
                <asp:BoundField DataField="ZipFileLocation" HeaderText="ZipFileLocation" SortExpression="ZipFileLocation" />
            </Columns>
            <FooterStyle BackColor="#CCCCCC" />
            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#F1F1F1" />
            <SortedAscendingHeaderStyle BackColor="#808080" />
            <SortedDescendingCellStyle BackColor="#CAC9C9" />
            <SortedDescendingHeaderStyle BackColor="#383838" />
        </asp:GridView>
    
    </div>
    </form>
</body>
</html>
