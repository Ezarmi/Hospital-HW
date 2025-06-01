$(document).ready(function () {

    $.post("/Home/getdep")
        .done(function (res) {
            /*console.log(res);*/
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
});