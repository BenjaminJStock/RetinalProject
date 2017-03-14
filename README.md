# Retinal Image Analyser

![N|Solid](http://www.rainbowcreativemedia.com/wp-content/themes/Rainbow_2016/images/ede299499541feb76de115e5d3399513_asp_net.png)

Retinal image analyser is a ASP.net with C# based web application that is able to analyse upload 'zip' files containing retinal scan images along with the masks used, and give results that are medically accurate.
#### Features
  - Upload Multiple Retinal Scans at once in a zip and repeat the algorithm recursivly, instead of one at a time.
  - Allows the results to be viewed seperatly, with details of who uploaded them.
  - Results can be viewed on mobile.
  - Medically Accurate Results.
  - Output the Sensitivity, Specificity, Accuracy and kappa score of each image.

# New Features!

  - Results are sent to the email stored in the database from the email box on upload.


You can also:
  - View other users results on the Results Page.
  - Export documents as Markdown, HTML and PDF

Markdown is a lightweight markup language based on the formatting conventions that people naturally use in email.  As [John Gruber] writes on the [Markdown site][df1]

> Add Quote or something here

### Tech

This project uses a number of different technologies for it to work properly:
* [ASP.net] - Web framework for building modern web apps and services with .NET
* [C#] - General-purpose, object-oriented programming language used for backend services
* [SQL] - Used for the backend database management.
* [AForge.net] - ASP and C# image processing library.
* [DotNetZip] - Used for extracting the uploaded Zip Files.
* [Css] - Used for Webpage Styling.
* [Jquery] - jQuery is a fast, small, and feature-rich JavaScript library.
* [XML] - For Web Configuration.
* [Bootstrap] - Extends CSS and helps mobile views due to the front end framework.

### Installation

Just clone or download this repository and open in Visual Studio, then click run (Debug) or build.
Note: You may need to update visual studio for the local SQL database to work properly.
If that doesnt work, then Download the ImageUpload SQL file and add it as 'connectionstring' in the data connection tab on the Server Explorer pane. 

##License
                                  
                                  
                                  Apache License
                           Version 2.0, January 2004
                        http://www.apache.org/licenses/
