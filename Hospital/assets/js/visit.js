$(document).ready(function () {

    $.post("/Home/getvisits")
        .done(function (res) {
            for (var item in res) {
                $("#tbl_visits").append(
                    "<tr>" +
                    "<td>" + res[item].pkID + "</td>" +
                    "<td>" + res[item].Name + " " + res[item].Family + "</td>" +
                    "<td>" + res[item].PDate + "</td>" +
                    "<td>" + res[item].PTime + "</td>" +
                    "<td>" + res[item].pName + " " + res[item].pFamily + "</td>" +
                    "<td>" + res[item].pMobile + "</td>"
                );
            }

        })
        .fail(function () {

        })
        .always(function () {

        });
});