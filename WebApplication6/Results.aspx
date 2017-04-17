<%@ Page Title="Results" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Results.aspx.cs" Inherits="WebApplication6.WebForm2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <link href="Content/Site.css" rel="stylesheet" />
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>

    <script type="text/javascript">
        $("[src*=plus]").live("click", function () {
            $(this).closest("tr").after("<tr><td></td><td colspan = '999'>" + $(this).next().html() + "</td></tr>")
            $(this).attr("src", "Images/minus.png");
        });
        $("[src*=minus]").live("click", function () {
            $(this).attr("src", "Images/plus.png");
            $(this).closest("tr").next().remove();
        });
    </script>



    <div class="jumbotron" style="overflow: auto">
        <h1>Results Page</h1>
        <p class="lead" aria-multiselectable="False" spellcheck="true">Below is the results from all of the completed evaluation of uploaded retinal scans.</p>
        <p class="lead" aria-multiselectable="False" spellcheck="true">
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [ResultsDataBase]"></asp:SqlDataSource>

        </p>


        <asp:GridView ID="gvCustomers" runat="server" CssClass="Borders"  DataKeyNames="ID" OnRowDataBound="OnRowDataBound"  BorderColor="Tan" BorderWidth="1px" CellPadding="2" ForeColor="Black" GridLines="None" AllowSorting="True" AutoGenerateColumns="False" Width="920px" Style="margin-top: 0px" BackColor="LightGoldenrodYellow">
            <AlternatingRowStyle BackColor="PaleGoldenrod" />
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        
                            <img alt="" style="cursor: pointer" src="images/plus.png" />

                            <asp:Panel ID="pnlOrders" runat="server" Style="display: none" BorderStyle="Double" CssClass="Nested_ChildGrid">

                                <asp:GridView ID="gvOrders" CssClass="Borders" runat="server" AutoGenerateColumns="false" OnSorting="gvOrders_Sorting" Font-Size="Small">

                                    <Columns>
                                        <asp:BoundField HeaderStyle-Width="85px" ItemStyle-BorderStyle="None" HeaderStyle-BorderStyle="None" />
                                        <asp:BoundField DataField="ImgNumber" HeaderText="Image Number" HeaderStyle-Width="123px" />
                                        <asp:BoundField DataField="Sensitivity" HeaderText="Sensitivity" HeaderStyle-Width="108px" DataFormatString="{0:F8}" SortExpression="Sensitivity" />
                                        <asp:BoundField DataField="Specificity" HeaderText="Specificity" HeaderStyle-Width="108px" DataFormatString="{0:F8}" SortExpression="Specificity" />
                                        <asp:BoundField DataField="Precision" HeaderText="Precision" HeaderStyle-Width="109px" DataFormatString="{0:F8}" SortExpression="Precision" />
                                        <asp:BoundField DataField="Accuracy" HeaderText="Accuracy" HeaderStyle-Width="109px" DataFormatString="{0:F8}" SortExpression="Accuracy" />
                                        <asp:BoundField DataField="kappa" HeaderText="kappa" HeaderStyle-Width="109px" DataFormatString="{0:F8}" SortExpression="kappa" />


                                    </Columns>
                                </asp:GridView>
                            </asp:Panel>
                    </ItemTemplate>
                    
                </asp:TemplateField>
                <asp:BoundField DataField="Name" HeaderText="Name" />
                <asp:BoundField DataField="ImgNumber" HeaderText="Total Images"></asp:BoundField>
                <asp:BoundField DataField="Sensitivity" HeaderText="Sensitivity" DataFormatString="{0:F8}" />
                <asp:BoundField DataField="Specificity" HeaderText="Specificity" DataFormatString="{0:F8}" />
                <asp:BoundField DataField="Precision" HeaderText="Precision" DataFormatString="{0:F8}" />
                <asp:BoundField DataField="Accuracy" HeaderText="Accuracy" DataFormatString="{0:F8}" />
                <asp:BoundField DataField="kappa" HeaderText="kappa" DataFormatString="{0:F8}" />
                <asp:BoundField DataField="Dataset" HeaderText="Dataset" />

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
    </div>

</asp:Content>

