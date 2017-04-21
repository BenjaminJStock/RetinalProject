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
        <h2 class="text-center">Results Page</h2>
        <p class="lead" aria-multiselectable="False" spellcheck="true" style="text-align: center">Below is the results from all of the completed evaluation of uploaded retinal scans.</p>
        <br />
        <p class="text-center"><span style="font-size: medium">The table below shows an overview of the performance of each different uploaded dataset. The rightmost column shows the name of the person who uploaded the dataset.</span></p>
        <%--<p class="lead" aria-multiselectable="False" spellcheck="true">
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [ResultsDataBase]"></asp:SqlDataSource>

        </p>


        <asp:GridView ID="gvCustomers" runat="server" CssClass="Borders" DataKeyNames="ID" OnRowDataBound="OnRowDataBound" AllowSorting="True" AutoGenerateColumns="False" Width="100%" Style="margin-top: 0px" BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="0px" CellPadding="2" ForeColor="Black" GridLines="None">
            <AlternatingRowStyle BackColor="PaleGoldenrod" />
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>

                        <img alt="" style="cursor: pointer" src="images/plus.png" />

                        <asp:Panel ID="pnlOrders" runat="server" Style="display: none" BorderStyle="Solid" CssClass="Nested_ChildGrid">

                            <asp:GridView ID="gvOrders" CssClass="Borders" runat="server" AutoGenerateColumns="false" OnSorting="gvOrders_Sorting" Font-Size="Small">

                                <Columns>
                                    <asp:BoundField HeaderStyle-Width="126px" ItemStyle-BorderStyle="None" HeaderStyle-BorderStyle="None" />
                                    <asp:BoundField DataField="ImgNumber" HeaderText="Image Number" HeaderStyle-Width="155px" />
                                    <asp:BoundField DataField="Sensitivity" HeaderText="Sensitivity" HeaderStyle-Width="127px" DataFormatString="{0:F8}" SortExpression="Sensitivity" />
                                    <asp:BoundField DataField="Specificity" HeaderText="Specificity" HeaderStyle-Width="124px" DataFormatString="{0:F8}" SortExpression="Specificity" />
                                    <asp:BoundField DataField="Precision" HeaderText="Precision" HeaderStyle-Width="110px" DataFormatString="{0:F8}" SortExpression="Precision" />
                                    <asp:BoundField DataField="Accuracy" HeaderText="Accuracy" HeaderStyle-Width="110px" DataFormatString="{0:F8}" SortExpression="Accuracy" />
                                    <asp:BoundField DataField="kappa" HeaderText="kappa" HeaderStyle-Width="112px" DataFormatString="{0:F8}" SortExpression="kappa" />


                                </Columns>
                            </asp:GridView>
                        </asp:Panel>
                    </ItemTemplate>

                </asp:TemplateField>
                <asp:BoundField DataField="Last_Name" HeaderText="Researcher" HeaderStyle-Width="127px">
                    
<HeaderStyle Width="127px"></HeaderStyle>
                    
                </asp:BoundField>
                <asp:BoundField DataField="ImgNumber" HeaderText="Total Images"></asp:BoundField>
                <asp:BoundField DataField="Sensitivity" HeaderText="Sensitivity" DataFormatString="{0:F8}" ItemStyle-Font-Size="Small">
                    <ItemStyle Font-Size="Small"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="Specificity" HeaderText="Specificity" DataFormatString="{0:F8}" ItemStyle-Font-Size="Small">
                    <ItemStyle Font-Size="Small"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="Precision" HeaderText="Precision" DataFormatString="{0:F8}" ItemStyle-Font-Size="Small">
                    <ItemStyle Font-Size="Small"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="Accuracy" HeaderText="Accuracy" DataFormatString="{0:F8}" ItemStyle-Font-Size="Small">
                    <ItemStyle Font-Size="Small"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="kappa" HeaderText="kappa" DataFormatString="{0:F8}" ItemStyle-Font-Size="Small">
                    <ItemStyle Font-Size="Small"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="Dataset" HeaderText="Dataset" ItemStyle-Font-Size="Small">

                    <ItemStyle Font-Size="Small"></ItemStyle>
                </asp:BoundField>

            </Columns>
            <EditRowStyle Font-Size="Small" />
            <FooterStyle BackColor="Tan" />
            <HeaderStyle BackColor="Tan" Font-Bold="True" />
            <PagerStyle BackColor="PaleGoldenrod" ForeColor="DarkSlateBlue" HorizontalAlign="Center" />
            <SelectedRowStyle BackColor="DarkSlateBlue" ForeColor="GhostWhite" />
            <SortedAscendingCellStyle BackColor="#FAFAE7" />
            <SortedAscendingHeaderStyle BackColor="#DAC09E" />
            <SortedDescendingCellStyle BackColor="#E1DB9C" />
            <SortedDescendingHeaderStyle BackColor="#C2A47B" />
        </asp:GridView>--%>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:RegistrationConnectionString %>" SelectCommand="SELECT [Table].Last_Name, [Table].Institution, [Table].Dataset, AllResults.ImgNumber, AllResults.Sensitivity, AllResults.Precision, AllResults.Accuracy, AllResults.kappa, AllResults.Specificity, AllResults.Researcher_ID_FK FROM AllResults INNER JOIN [Table] ON AllResults.Researcher_ID_FK = [Table].Researcher_ID"></asp:SqlDataSource>
        <br />
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="1px" CellPadding="2" CellSpacing="2" DataSourceID="SqlDataSource1" ForeColor="Black" GridLines="Horizontal" HorizontalAlign="Center" style="margin-top: 0px; font-size: small;" Width="1050px" BorderStyle="Dotted">
            <AlternatingRowStyle BackColor="PaleGoldenrod" />
            <Columns>
                <asp:BoundField DataField="Last_Name" HeaderText="Method" SortExpression="Last_Name" />
                <asp:BoundField DataField="Institution" HeaderText="Institution" SortExpression="Institution" />
                <asp:BoundField DataField="Dataset" HeaderText="Dataset" SortExpression="Dataset" />
                <asp:BoundField DataField="ImgNumber" HeaderText="Image" SortExpression="ImgNumber" />
                 <asp:BoundField DataField="Sensitivity" HeaderText="Sensitivity" SortExpression="Sensitivity" DataFormatString="{0:n4}" />
                <asp:BoundField DataField="Precision" HeaderText="Precision" SortExpression="Precision" DataFormatString="{0:n4}" />
                <asp:BoundField DataField="Accuracy" HeaderText="Accuracy" SortExpression="Accuracy" DataFormatString="{0:n4}" />
                <asp:BoundField DataField="kappa" HeaderText="kappa" SortExpression="kappa" DataFormatString="{0:n4}" />
                <asp:BoundField DataField="Specificity" HeaderText="Specificity" SortExpression="Specificity" DataFormatString="{0:n4}" />
               
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

