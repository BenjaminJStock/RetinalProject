<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="WebApplication6.About" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %> Retinal Image Analyser.</h2>
    <h3>This application able to ....</h3>
    <p style="font-size: 21px">
        This project is a web based application that is able to accurately read and analyse multiple retinal 
        scan images contained in a zip file that can be uploaded by users and find out the Sensitivity,
        Specificity, Accuracy and kappa scores for each image within the dataset. 
        <br /> This works by using the algorithm on the users uploaded image, a mask and a ‘GoldStandard’ image which are used from the
        Drive or Stare retinal image datasets.
        <br />
        For example, here are some results based off of a randomly uploaded retinal image:<br />
        <asp:Label ID="Label1" runat="server" Text="Sensitivity, Specificity, Precision, Accuracy, Kappa"></asp:Label><br />
        <asp:Label ID="Label2" runat="server" Text="0.5269039, 0.4697795, 0.5274663, 0.5, -0.003316397"></asp:Label>
    <p>
        &nbsp;
</asp:Content>
