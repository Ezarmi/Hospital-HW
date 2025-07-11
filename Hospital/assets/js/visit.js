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
                    "<td>" + res[item].pMobile + "</td>" +
                    "<td>" + res[item].Type + "</td>" +
                    "<td class='status' id=status_" + res[item].pkID + " >" + res[item].VisitStatus + "</td>"
                );
            }

        })
        .fail(function () {

        })
        .always(function () {

        });

    $(document).on("dblclick", ".status", function () {

        $("#chg").html($(this).attr("id"));

        $.post("/Home/getstatus")
            .done(function (res) {
                $(".modal-body").empty();
                for (var item in res) {
                    
                    $(".modal-body").append(
                        "<button class='btn btn-primary chgstatus'>" + res[item].pkID + " - " + res[item].VisitStatus + "</button>" +
                        "<br><br>"
                    );
                }

            })
            .fail(function () {

            })
            .always(function () {

            });

        $("#changestatus").modal("show");
    });

    $(document).on("click", ".chgstatus", function () {
        var state = $(this).html().split(" - ");
        var id = $("#chg").html().split("_");

        $.post("/Home/setstatus", {state:state[0],id:id[1]})
            .done(function (res) {
                if (res == 1) {
                    location.reload();
                }

            })
            .fail(function () {

            })
            .always(function () {

            });
    });
});