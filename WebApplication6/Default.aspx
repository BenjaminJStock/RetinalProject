<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebApplication6._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h1>Retinal Image</h1>
        <p class="lead" aria-multiselectable="False" spellcheck="true">This is a website that allows you to upload a retinal image dataset zip file, then will compare the images in that zip folder to a gold standard dataset and perform an analysis algorithm onto it in order to give back medically accurate results that will show the specificity, sensivity, accuracy and kappa scores of each image.</p>
        <p class="lead" aria-multiselectable="False" spellcheck="true">&nbsp;</p>
        
        <div title="Results">
            
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
                    <td id="EmailBox" class="text-left" style="width: 315px; font-size: medium">Email Address:</td>
                    <td id="EmailBox" class="text-left" style="width: 405px">
                        <asp:TextBox ID="EmaiBox" runat="server" style="font-size: medium" TextMode="Email" Width="350px"></asp:TextBox>
                        <br style="font-size: medium" />
                    </td>
                    <td id="EmailBox" class="text-left" style="font-size: medium">
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
                        <asp:FileUpload ID="FileUpload1" runat="server" Width="357px" />
                    </td>
                    <td>Please Upload a Zip file containing your images </td>
                </tr>
            </table>
            <br />
            <asp:Button ID="Button1" runat="server" Text="Upload Zip File to Database" OnClick="Button1_Click" />
            &nbsp;&nbsp;
            <asp:Label runat="server" id="StatusLabel" text="Upload status: " /> 
            <br />
            <asp:Label ID="Label1" runat="server" Text="height"></asp:Label>
            <asp:Label ID="heightlabel" runat="server" Text="Label"></asp:Label>
            <br />
            <asp:Label ID="Label3" runat="server" Text="width"></asp:Label>
            <asp:Label ID="widthlabel" runat="server" Text="Label"></asp:Label>
            <br />
            <asp:Label ID="Label4" runat="server" Text="tp"></asp:Label>
            &nbsp;<asp:Label ID="LabelTP" runat="server" Text="Label"></asp:Label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="Label6" runat="server" Text="tn"></asp:Label>
            &nbsp;&nbsp;<asp:Label ID="LabelTN" runat="server" Text="LabelTN"></asp:Label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="Label8" runat="server" Text="fp"></asp:Label>
            &nbsp;&nbsp;&nbsp;<asp:Label ID="LabelFP" runat="server" Text="Label"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="Label10" runat="server" Text="FN"></asp:Label>
            <asp:Label ID="LabelFN" runat="server" Text="Label"></asp:Label>
            <br />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br />
            <asp:Label ID="LabelResults" runat="server" Text="Label"></asp:Label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <br />
            <asp:Label ID="ResultsLabel" runat="server" Text="Label"></asp:Label>
            <br />
            <br />
            <asp:Label ID="LabelResults0" runat="server" Text="Label"></asp:Label>
            <br />
            <asp:Label ID="ResultsLabel0" runat="server" Text="Label"></asp:Label>
            <br />
            <br />
            <asp:Label ID="Label11" runat="server" Text="Label"></asp:Label>
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
        </div>
    </div>   
</asp:Content>