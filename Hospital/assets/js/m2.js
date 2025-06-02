$(document).ready(function () {

    $.post("/Home/getdep")
        .done(function (res) {
            for (var item in res) {
                $("#department").append(
                    "<option>" + res[item].pkID + " - " + res[item].Skill + "</option>"
                );
            }

        })
        .fail(function () {

        })
        .always(function () {

        });

    $("#department").on('change', function (e) {
        var dep = $("#department").val();
        var dep2 = dep.split("-");

        $.post("/Home/getdocs", {dep:dep2[0]})
            .done(function (res) {

                $("#doctor").empty();
                $("#doctor").append("<option>" + "انتخاب کنید" + "</option>");

                for (var item in res) {
                    $("#doctor").append(
                        "<option>" + res[item].pkID + " - " + res[item].Name + " " + res[item].Family + "</option>"
                    );
                }

            })
            .fail(function () {

            })
            .always(function () {

            });

    });
});