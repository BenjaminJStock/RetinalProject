<%@ Page Title="Results" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Results.aspx.cs" Inherits="WebApplication6.WebForm2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script src="Scripts/expand.js"></script>
    <link href="Content/Site.css" rel="stylesheet" />
   

    <div class="jumbotron">
        <h1>Results Page<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [ResultsDataBase]"></asp:SqlDataSource>
        </h1>
        <p class="lead" aria-multiselectable="False" spellcheck="true">Below is the results from all of the completed analysis of uploaded retinal scans.</p>
        <p class="lead" aria-multiselectable="False" spellcheck="true">
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSource2" Height="270px" Width="1063px" AllowSorting="True" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" style="font-size: small" SortedAscendingHeaderStyle-CssClass="sortasc" SortedDescendingHeaderStyle-CssClass="sortdesc">
                <AlternatingRowStyle BackColor="Gainsboro" />
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" HeaderStyle-Width="20px" SortExpression="Id" >
                        <HeaderStyle Width="20px"></HeaderStyle>
                    </asp:BoundField>
                    <asp:BoundField DataField="Name" HeaderText="Name" HeaderStyle-Width="100px" SortExpression="Name" >
                        <HeaderStyle Width="100px"></HeaderStyle>
                    </asp:BoundField>
                    <asp:BoundField DataField="ImgNumber" HeaderText="Number of Images in Zip" HeaderStyle-Width="100px" HeaderStyle-Wrap="true" SortExpression="ImgNumber" >
                        <HeaderStyle Wrap="True" Width="100px"></HeaderStyle>
                    </asp:BoundField>
                    <asp:BoundField DataField="Sensitivity" HeaderText="Sensitivity" SortExpression="Sensitivity" HeaderStyle-Width="100px" DataFormatString="{0:F8}" >
                         <HeaderStyle Width="100px"></HeaderStyle>
                    </asp:BoundField>
                    <asp:BoundField DataField="Specificity" HeaderText="Specificity" SortExpression="Specificity" HeaderStyle-Width="100px" DataFormatString="{0:F8}" >
                        <HeaderStyle Width="100px"></HeaderStyle>
                    </asp:BoundField>
                    <asp:BoundField DataField="Precision" HeaderText="Precision" SortExpression="Precision" HeaderStyle-Width="100px" DataFormatString="{0:F8}" >
                        <HeaderStyle Width="100px"></HeaderStyle>
                    </asp:BoundField>
                    <asp:BoundField DataField="Accuracy" DataFormatString="{0:F8}" HeaderText="Accuracy" HeaderStyle-Width="100px" SortExpression="Accuracy" />
                    <asp:BoundField DataField="kappa" HeaderText="kappa" SortExpression="kappa" HeaderStyle-Width="100px" DataFormatString="{0:F8}"  >
                        <HeaderStyle Width="100px"></HeaderStyle>
                    </asp:BoundField>
                </Columns>
                <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                <SortedAscendingHeaderStyle BackColor="#0000A9" ForeColor="#993366" />
                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                <SortedDescendingHeaderStyle BackColor="#000065" />
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [ResultsDataBase]"></asp:SqlDataSource>
        </p>
        <p class="lead" aria-multiselectable="False" spellcheck="true" style="height: 363px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>


        <asp:GridView ID="gvCustomers" runat="server" AutoGenerateColumns="False" CssClass="Grid" DataKeyNames="ID" OnRowDataBound="OnRowDataBound" Width="964px" >
    <Columns>
        <asp:TemplateField>
            <ItemTemplate>
                <img alt = "" style="cursor: pointer" src="images/plus.png" />
                <asp:Panel ID="pnlOrders" runat="server" Style="display: none">
                    <asp:GridView ID="gvOrders" runat="server" AutoGenerateColumns="false" >
                        <Columns>
                            <asp:BoundField  HeaderStyle-Width="154px"  />
                            <asp:BoundField  DataField="ImgNumber" HeaderText="Image Number" HeaderStyle-Width="154px"  />
                            <asp:BoundField  DataField="Sensitivity" HeaderText="Sensitivity" HeaderStyle-Width="122px" DataFormatString="{0:F8}"/>
                            <asp:BoundField  DataField="Specificity" HeaderText="Specificity" HeaderStyle-Width="122px" DataFormatString="{0:F8}"/>
                            <asp:BoundField DataField="Precision" HeaderText="Precision" HeaderStyle-Width="122px" DataFormatString="{0:F8}" />
                            <asp:BoundField DataField="Accuracy" HeaderText="Accuracy" HeaderStyle-Width="124px" DataFormatString="{0:F8}" />
                            <asp:BoundField DataField="kappa" HeaderText="kappa" HeaderStyle-Width="123px" DataFormatString="{0:F8}" />
                            
                        </Columns>
                    </asp:GridView>
                </asp:Panel>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField  DataField="Name" HeaderText="Name" />
        <asp:BoundField  DataField="ImgNumber" HeaderText="Total Images" />
        <asp:BoundField  DataField="Sensitivity" HeaderText="Sensitivity" DataFormatString="{0:F8}"  /> 
        <asp:BoundField  DataField="Specificity" HeaderText="Specificity" DataFormatString="{0:F8}"  />
        <asp:BoundField  DataField="Precision" HeaderText="Precision" DataFormatString="{0:F8}"  />
        <asp:BoundField  DataField="Accuracy"  HeaderText="Accuracy" DataFormatString="{0:F8}" />
        <asp:BoundField  DataField="kappa" HeaderText="kappa" DataFormatString="{0:F8}"/>
        
    </Columns>
</asp:GridView>

    </div>
</asp:Content>

