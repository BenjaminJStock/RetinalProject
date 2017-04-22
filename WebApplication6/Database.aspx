<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Database.aspx.cs" Inherits="WebApplication6.Database" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    </head>
<body style="height: 399px">
    <form id="form1" runat="server">
        <div style="margin-left: 40px">

            <asp:Label ID="Label1" runat="server" Text="Name Database"></asp:Label>
            <br />
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:RegistrationConnectionString %>" SelectCommand="SELECT * FROM [Table]"></asp:SqlDataSource>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="1px" CellPadding="2" DataKeyNames="Researcher_ID" DataSourceID="SqlDataSource1" ForeColor="Black" GridLines="None">
                <AlternatingRowStyle BackColor="PaleGoldenrod" />
                <Columns>
                    <asp:BoundField DataField="Researcher_ID" HeaderText="Researcher_ID" SortExpression="Researcher_ID" InsertVisible="False" ReadOnly="True" />
                    <asp:BoundField DataField="First_Name" HeaderText="First_Name" SortExpression="First_Name" />
                    <asp:BoundField DataField="Last_Name" HeaderText="Last_Name" SortExpression="Last_Name" />
                    <asp:BoundField DataField="Email_Address" HeaderText="Email_Address" SortExpression="Email_Address" />
                    <asp:BoundField DataField="Institution" HeaderText="Institution" SortExpression="Institution" />
                    <asp:BoundField DataField="ZipFileLocation" HeaderText="ZipFileLocation" SortExpression="ZipFileLocation" />
                    <asp:BoundField DataField="Dataset" HeaderText="Dataset" SortExpression="Dataset" />
                    <asp:BoundField DataField="FOV" HeaderText="FOV" SortExpression="FOV" />
                    <asp:BoundField DataField="Download" HeaderText="Download" SortExpression="Download" />
                </Columns>
                <FooterStyle BackColor="Tan" />
                <HeaderStyle BackColor="Tan" Font-Bold="True" />
                <PagerStyle BackColor="PaleGoldenrod" ForeColor="DarkSlateBlue" HorizontalAlign="Center" />
                <SelectedRowStyle BackColor="DarkSlateBlue" ForeColor="GhostWhite" />
                <SortedAscendingCellStyle BackColor="#FAFAE7" />
                <SortedAscendingHeaderStyle BackColor="#DAC09E" />
                <SortedDescendingCellStyle BackColor="#E1DB9C" />
                <SortedDescendingHeaderStyle BackColor="#C2A47B" />
            </asp:GridView>
            <br />
            <br />

            Results Database<asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource3">
                <Columns>
                    <asp:BoundField DataField="Last_Name" HeaderText="Last_Name" SortExpression="Last_Name" />
                    <asp:BoundField DataField="Researcher_ID_FK" HeaderText="Researcher_ID_FK" SortExpression="Researcher_ID_FK" />
                    <asp:BoundField DataField="Institution" HeaderText="Institution" SortExpression="Institution" />
                    <asp:BoundField DataField="Dataset" HeaderText="Dataset" SortExpression="Dataset" />
                    <asp:BoundField DataField="ImgNumber" HeaderText="ImgNumber" SortExpression="ImgNumber" />
                    <asp:BoundField DataField="Sensitivity" HeaderText="Sensitivity" SortExpression="Sensitivity" />
                    <asp:BoundField DataField="Precision" HeaderText="Precision" SortExpression="Precision" />
                    <asp:BoundField DataField="Accuracy" HeaderText="Accuracy" SortExpression="Accuracy" />
                    <asp:BoundField DataField="kappa" HeaderText="kappa" SortExpression="kappa" />
                    <asp:BoundField DataField="Specificity" HeaderText="Specificity" SortExpression="Specificity" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:RegistrationConnectionString %>" SelectCommand="SELECT [Table].Last_Name, [Table].Institution, [Table].Dataset, AllResults.ImgNumber, AllResults.Sensitivity, AllResults.Precision, AllResults.Accuracy, AllResults.kappa, AllResults.Specificity, AllResults.Researcher_ID_FK FROM AllResults INNER JOIN [Table] ON AllResults.Researcher_ID_FK = [Table].Researcher_ID"></asp:SqlDataSource>
            <br />
            
            AllResults Database<br />

            ewr</div>
    </form>

    
</body>
</html>
