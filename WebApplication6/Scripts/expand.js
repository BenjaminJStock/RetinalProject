$("[src*=plus]").on("click", function () {
    $(this).closest("tr").after("<tr><td></td><td colspan = '999'>" + $(this).next().html() + "</td></tr>");
    $(this).attr("src", 'Images/minus.png');
});
$("[src*=minus]").on("click", function () {
    $(this).attr("src", 'Images/plus.png');
    $(this).closest("tr").next().remove();
});