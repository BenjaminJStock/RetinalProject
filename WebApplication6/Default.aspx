<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebApplication6._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h1>Retinal Image</h1>
        <p class="lead" aria-multiselectable="False" spellcheck="true">This is a website that allows you to upload a retinal image dataset zip file, then will compare the images in that zip folder to a gold standard dataset and perform an analysis algorithm onto it in order to give back medically accurate results that will show the specificity, sensivity, accuracy and kappa scores of each image.</p>
        <p class="lead" aria-multiselectable="False" spellcheck="true">&nbsp;</p>
        <p class="lead" aria-multiselectable="False" spellcheck="true">&nbsp;</p>
        <div style="height: 426px">
            
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
            <asp:Label ID="lblmessage" runat="server" Text="File Uploaded to Database"></asp:Label>
            <br />
            <asp:Button ID="Button1" runat="server" Text="Upload Zip File to Database" OnClick="Button1_Click" />
            &nbsp;&nbsp;
            <asp:Label runat="server" id="StatusLabel" text="Upload status: " />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <br />
            
        </div>
        <%-- below is for having a timer so the current time and date can be uploaded to the database as well but it keeps refreshing the page so i cant add stuff to the forms to add to the database.--%>
        <%--<div>
            <p style="height: 102px">Current Time:
                <asp:Label ID="lTime" runat="server"></asp:Label>
                <asp:Timer ID="Timer1" runat="server" Interval="1000" OnTick="Timer1_Tick">
                </asp:Timer>
            </p>
        </div>--%>
    </div>

   

    </asp:Content>
