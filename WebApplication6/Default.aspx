<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebApplication6._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <%--<link href="Content/Site.css" rel="stylesheet" />--%>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">


    <div class="jumbotron">
        <h1 class="text-center"><span style="font-size: smaller">Retinal Image Evaluation Calculator</span></h1>


        <p class="lead" aria-multiselectable="False" spellcheck="true" style="text-align: center"><span style="font-size: large">This is an online service that allows you to evaluate multiple segmented retinal scan images against the DRIVE or STARE Retinal Image datasets. </span></p>
        <p class="lead" aria-multiselectable="False" spellcheck="true" style="text-align: center"><span style="font-size: large">This project is an automatic diagnostic test evaluation is a method to evaluate the chances of being affected with diseases, calculated based on the present health conditions. In the below form, fill in your details, select the DRIVE or STARE dataset in the dropdown, and then upload your ZIP file that contains the segmented retinal scan images.</span></p>
        <p class="lead" aria-multiselectable="False" spellcheck="true" style="text-align: center">How does it work?</p>
        <p class="lead" aria-multiselectable="False" spellcheck="true" style="text-align: center; font-size: large">This website allows you to upload a retinal image dataset zip file, then will compare the images in that zip folder to a gold standard dataset and perform an analysis algorithm onto it in order to <span style="font-size: large">calculate medical diagnosis factors such as Sensitivity, Specificity and other values.</span></p>
        <p class="lead" aria-multiselectable="False" spellcheck="true" style="text-align: center; font-size: large">Why should I use it?</p>
        <p class="lead" aria-multiselectable="False" spellcheck="true" style="text-align: center; font-size: large">Unlike most other Diagnostic Test Calculators, this one is fully automated for retinal scan images, meaning you dont have to fiddle about entering the TPFPTNFN scores for each image, as it will do it automatically for each segmented retinal scan in the uploaded ZIP file.</p>
        <br />






        




        <div class="w3-container w3-card-4 w3-light-grey w3-text-blue w3-margin" id="ResultsGrid">
            <h2 class="w3-center">Upload and Evaluate Your Dataset</h2>
            <%--<div class="w3-container w3-card-4 w3-light-grey w3-text-blue w3-margin" id="Center">--%>

            <div id="Center" class="col-md-4">
                <div class="col-md-1 col-xs-offset-1" id="BG" style="left: 0px; top: 0px; width: 152px">
                    <h3>Guide</h3>
                    <p style="font-size: small; font-weight: normal; color: #000000;">In order to use this service, you need to enter your credentials into the form. This is so your results can be sent to you in an email, and can also be matched up correctly on the results page.</p>
                </div>
                <div class="w3-row w3-section">
                    <div class="w3-col" style="width: 50px; text-align: center;">
                        <i class="w3-xxlarge fa fa-user"></i>

                    </div>
                    <div class="w3-rest">
                        <%--<input class="w3-input w3-border" name="first" type="text" placeholder="First Name">--%>
                        <asp:TextBox ID="NameBox" runat="server" Style="font-size: medium" Width="100%" Wrap="False" class="w3-input w3-border" placeholder="First Name"></asp:TextBox>

                    </div>
                    <div class="w3-col" style="width: 50px; text-align: center;">
                        <i class="w3-xxlarge fa fa-user"></i>

                    </div>
                    <div class="w3-rest">
                        <%--<input class="w3-input w3-border" name="first" type="text" placeholder="First Name">--%>
                        <asp:TextBox ID="NameBox1" runat="server" Style="font-size: medium" Width="100%" Wrap="False" class="w3-input w3-border" placeholder="Last Name"></asp:TextBox>

                    </div>
              


                    <div class="w3-row w3-section">
                        <div class="w3-col" style="width: 50px; text-align: center;"><i class="w3-xxlarge fa fa-envelope"></i></div>
                        <div class="w3-rest" style="text-align: center">
                            <%--<input class="w3-input w3-border" name="Email" type="text" placeholder="Email">--%>
                            <asp:TextBox ID="EmaiBox" runat="server" Style="font-size: medium" TextMode="Email" Width="100%" Wrap="False" class="w3-input w3-border" placeholder="Email"></asp:TextBox>

                        </div>
                    </div>

                    <div class="w3-row w3-section">
                        <div class="w3-col" style="width: 50px; text-align: center;"><i class="w3-xxlarge fa fa-folder-open"></i></div>
                        <div class="w3-rest" style="text-align: center">
                            <asp:DropDownList ID="DropDownList2" runat="server" class="w3-input w3-border">
                                <asp:ListItem>--Select--</asp:ListItem>
                                <asp:ListItem Value="1">Drive Data Set</asp:ListItem>
                                <asp:ListItem Value="0">Stare Data Set</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="w3-row w3-section">
                        <div class="w3-col" style="width: 50px; text-align: center;"><i class="w3-xxlarge fa fa-book"></i></div>
                        <div class="w3-rest" style="text-align: center">
                            <%--<input class="w3-input w3-border" name="Institution" type="text" placeholder="Institution">--%>
                            <asp:TextBox ID="InstitutionBox" runat="server" Style="font-size: medium" Width="100%" Wrap="False" class="w3-input w3-border" placeholder="Institution"></asp:TextBox>

                        </div>
                    </div>

                    <div class="w3-row w3-section">
                        <div class="w3-col" style="width: 50px; text-align: center;"><i class="w3-xxlarge fa fa-file"></i></div>
                        <div class="w3-rest" style="text-align: center">
                            <asp:FileUpload ID="FileUpload1" runat="server" accept=".zip" class="w3-input w3-border" />
                            <%--<input class="w3-input w3-border" name="FileUpload" type="text" placeholder="FileUpload">--%>
                        </div>
                    </div>
                    <asp:Button ID="Button2" runat="server" Text="Upload Zip File to Database" OnClick="Button1_Click" class="w3-button w3-block w3-section w3-blue w3-ripple w3-padding" />
                    <%--<button class="w3-button w3-block w3-section w3-blue w3-ripple w3-padding">Send</button>--%>
                </div>
                <div class="col-md-1 col-xs-offset-1" id="BG" style="left: 0px; top: 0px; width: 152px">

                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="NameBox" ErrorMessage="Full Name is Required" ForeColor="Red" Style="text-align: right; font-size: small"></asp:RequiredFieldValidator>
                    <br />
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="EmaiBox" ErrorMessage="Email Address is Required" ForeColor="Red" Style="font-size: small"></asp:RequiredFieldValidator>
                    <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="EmaiBox" ErrorMessage="Enter a Valid Email" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>--%>
                    <br />
                    <br />

                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="DropDownList2" ErrorMessage="Select a dataset to use" InitialValue="--Select--" ForeColor="Red" Style="font-size: small"></asp:RequiredFieldValidator>
                    <br />
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="InstitutionBox" ErrorMessage="Institution is Required" ForeColor="Red" Style="font-size: small"></asp:RequiredFieldValidator>
                    <br />
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="FileUpload1" ErrorMessage="Only .zip files containing segmented retinal scans are allowed!" ForeColor="Red" Style="font-size: small"></asp:RequiredFieldValidator>

                    

                </div>



            </div>
        </div>
        <div class="w3-container w3-card-4 w3-light-grey w3-text-blue w3-margin" id="MobileGrid">
            <p>If you are seeing this message, it means that you are probably using a mobile device or tablet. While this is fine for viewing the completed evaluation results of users' uploaded retinal scans, it is not viable to provide
                mobile upload viewpoint. This is due to the fact that Apple Devices, and iOS does not deal with zip files that well. I recommend you use a laptop or desktop to upload the zip file. <br />Mobile and Tablet users can still view all of the results properly though.</p>
            <p>&nbsp;</p>
            </div>




    <%--            <asp:GridView ID="GridView1" runat="server" CellPadding="3" GridLines="Vertical" Width="801px" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" Caption="Results Table - Please note the last row is the average results for all images" CaptionAlign="Top" ForeColor="Black">
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
            The bottom row of the above table will show the average score for the total images uploaded.<br />--%>
    </div>

    
</asp:Content>
