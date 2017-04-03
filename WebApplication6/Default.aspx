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
            <asp:Label ID="Label1" runat="server" Text="Count of Total Pixels IM GS MASK"></asp:Label>
            <asp:Label ID="IMLABEL" runat="server" Text="Label"></asp:Label>
            <asp:Label ID="GSLABEL" runat="server" Text="Label"></asp:Label>
            <asp:Label ID="MASKLABEL" runat="server" Text="Label"></asp:Label>
            <br />
            <asp:Label ID="Label2" runat="server" Text="WhitePixelCount"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="WHITEIM" runat="server" Text="Label"></asp:Label>
            <asp:Label ID="WHITEGS" runat="server" Text="Label"></asp:Label>
            <asp:Label ID="WHITEMASK" runat="server" Text="Label"></asp:Label>
            <br />
            <asp:Label ID="Label3" runat="server" Text="BLACKPIXELCOUNT"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="IMBLACK" runat="server" Text="Label"></asp:Label>
            <asp:Label ID="GSBLACK" runat="server" Text="Label"></asp:Label>
            <asp:Label ID="MaskBlack" runat="server" Text="Label"></asp:Label>
            <br />
            <br />
            <br />
            <br />
            <asp:Label ID="intlabel" runat="server" Text="Label"></asp:Label>
            <br />
            <br />
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
        </div>
    </div>   
</asp:Content>