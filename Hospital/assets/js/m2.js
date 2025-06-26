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

        var token = $('input[name="__RequestVerificationToken"]').val();

        $.post("/Home/getdocs", { dep: dep2[0], __RequestVerificationToken: token })
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

    $("#name").focus(function () {
        document.getElementById("name-v").innerHTML = "";
    });
    $("#name").blur(function () {
       var valid = validtion();
    });

    $("#family").focus(function () {
        document.getElementById("family-v").innerHTML = "";
    });
    $("#family").blur(function () {
        var valid = validtion();
    });

    $("#phone").focus(function () {
        document.getElementById("phone-v").innerHTML = "";
    });
    $("#phone").blur(function () {
        var valid = validtion();
    });

    $("#visit").focus(function () {
        document.getElementById("visit-v").innerHTML = "";
    });
    $("#visit").blur(function () {
        var valid = validtion();
    });
});

function setvisit() {
    var vn = $("#visit").val();
    var vn2 = vn.split("-");

    var namee = $("#name").val();
    var phone = $("#phone").val();
    var family = $("#family").val();

    var valid = validtion();

    if (valid) {
        $.post("/Home/setvisit", { vn: vn2, namee: namee, phone: phone, family: family })
            .done(function (res) {
                //console.log(res);
                switch (res) {
                    case 1: alert("چنین نوبتی وجود ندارد");
                        break;
                    case 2: alert("نوبت شما ثبت شد");
                        break;
                }

            })
            .fail(function () {
                alert("خطا در برقراری ارتباط با سرور");
            })
            .always(function () {

            });
    }
}

function validtion() {

    var valid = true;

    var namee = $("#name").val();
    var family = $("#family").val();
    var phone = $("#phone").val();

    if (namee.length > 20 || namee.length <= 2) {
        valid = false;
        $("#name-v").html("نام باید بین ۳ تا ۲۰ کاراکتر باشد");
    }

    if (family.length > 20 || family.length <= 2) {
        valid = false;
        $("#family-v").html("نام خانوادگی باید بین ۳ تا ۲۰ کاراکتر باشد");
    }

    if (phone.length !=11) {
        valid = false;
        $("#phone-v").html("شماره همراه باید ۱۱ رقم باشد.");
    }

    if ($(#"visit").val() == "انتخاب کنید") {
        valid = false;
        $("#phone-v").html("از منوی بالا یک نوبت انتخاب کنید");
    }
    return valid;
}