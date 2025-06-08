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

        $.post("/Home/getdocs", { dep: dep2[0] })
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


    $("#doctor").on('change', function (e) {
        var doc = $("#doctor").val();
        var doc2 = doc.split("-");

        $.post("/Home/getvisit", { doc: doc2[0] })
            .done(function (res) {
                //console.log(res);
                $("#visit").empty();
                $("#visit").append("<option>" + "انتخاب کنید" + "</option>");

                for (var item in res) {
                    $("#visit").append(
                        "<option>" + res[item].pkID + " - " + res[item].PDate + "|" + res[item].PTime + "</option>"
                    );
                }

            })
            .fail(function () {

            })
            .always(function () {

            });

    });
});

function setvisit() {
    var vn = $("#visit").val();
    var vn2 = vn.split("-");

    var namee = $("#name").val();
    var phone = $("#phone").val();
    var family = $("#family").val();

    $.post("/Home/setvisit", { vn: vn2, namee: namee, phone: phone, family: family })
        .done(function (res) {
            //console.log(res);
            if (res = "ok") {
                alert("نوبت شما ثبت شد");
            }

        })
        .fail(function () {
            alert("خطا در برقراری ارتباط با سرور");
        })
        .always(function () {

        });

}