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
                    "<td class='status' id=status_" + res[item].hashid + " >" + res[item].VisitStatus + "</td>"
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


        var nid = $("#chg").html();

        var pstatus = document.getElementById(nid).innerHTML;
        document.getElementById(nid).innerHTML="...تغییر...";

        var id = $("#chg").html().split("_");

        var token = $('input[name="__RequestVerificationToken"]').val();

        $.post("/Home/setstatus", { state: state[0], sid: id[1], __RequestVerificationToken:token})
            .done(function (res) {
                if (res.status == 1) {
                    //location.reload();

                    document.getElementById(nid).innerHTML = res.sname;
                }

            })
            .fail(function () {

                document.getElementById(nid).innerHTML = pstatus;

            })
            .always(function () {

                $("#changestatus").modal('hide');

            });
    });
});