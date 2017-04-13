<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebApplication6._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h1 class="text-center"><span style="font-size: smaller">Retinal Image Evaluation</span></h1>
        <p class="lead" aria-multiselectable="False" spellcheck="true">This is an online service that allows you to evaluate multiple segmented retinal scan images against the DRIVE or STARE datasets.</p>
        <p class="lead" aria-multiselectable="False" spellcheck="true">&nbsp; website that allows you to upload a retinal image dataset zip file, then will compare the images in that zip folder to a gold standard dataset and perform an analysis algorithm onto it in order to give back medically accurate results that will show the specificity, sensivity, accuracy and kappa scores of each image</p>
        
        <div title="Results">
            <br />
            <table class="nav-justified">
                <tr>
                    <td class="text-left" style="width: 315px; font-size: medium">Full Name:</td>
                    <td id="NameBox" class="text-left" style="width: 405px">
                        <asp:TextBox ID="NameBox" runat="server" style="font-size: medium" Width="350px"></asp:TextBox>
                    </td>
                    <td class="text-left">
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="NameBox" ErrorMessage="Full Name is Required" ForeColor="Red" style="text-align: center; font-size: medium"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td id="EmailBox" class="text-left" style="width: 315px; font-size: medium; height: 70px;">Email Address:</td>
                    <td id="EmailBox" class="text-left" style="width: 405px; height: 70px;">
                        <asp:TextBox ID="EmaiBox" runat="server" style="font-size: medium" TextMode="Email" Width="350px"></asp:TextBox>
                        <br style="font-size: medium" />
                    </td>
                    <td id="EmailBox" class="text-left" style="font-size: medium; height: 70px;">
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="EmaiBox" ErrorMessage="Email Address is Required" ForeColor="Red"></asp:RequiredFieldValidator>
                        <br />
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="EmaiBox" ErrorMessage="Enter a Valid Email" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                    </td>
                </tr>
                <tr>
                    <td class="text-left" style="width: 315px; font-size: medium">Institution:</td>
                    <td class="text-left" style="width: 405px">
                        <asp:TextBox ID="InstitutionBox" runat="server" style="font-size: medium" Width="350px"></asp:TextBox>
                    </td>
                    <td class="text-left">
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="InstitutionBox" ErrorMessage="Institution is Required" ForeColor="Red" style="font-size: medium"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td style="width: 315px; font-size: medium">Zip File:</td>
                    <td style="width: 405px">
                        <asp:FileUpload ID="FileUpload1" runat="server"  Width="357px" />
                    </td>
                    <td style="font-size: large">Please Upload a Zip file containing your images </td>
                </tr>
                <tr>
                    <td style="width: 315px; font-size: medium">Zip File:</td>
                    <td style="width: 405px">
                        <asp:DropDownList ID="DropDownList1" runat="server" Width="350px">
                            <asp:ListItem>Drive Data Set</asp:ListItem>
                            <asp:ListItem>Stare Data Set</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td style="font-size: large">Please Choose Which dataset you want to evaluate.</td>
                </tr>
            </table>
            <br />
            <asp:Button ID="Button1" runat="server" Text="Upload Zip File to Database" OnClick="Button1_Click" />
            &nbsp;&nbsp;
            <br />
            <br />
            <asp:GridView ID="GridView1" runat="server" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical">
                <AlternatingRowStyle BackColor="#CCCCCC" />
                <FooterStyle BackColor="#CCCCCC" />
                <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                <SortedAscendingHeaderStyle BackColor="#808080" />
                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                <SortedDescendingHeaderStyle BackColor="#383838" />
            </asp:GridView>
            <br />
            The bottom row of the above table will show the average score for the total images uploaded.<br />
        </div>
    </div>   
</asp:Content>