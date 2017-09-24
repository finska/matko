$(document).ready(function () {
    $("")
    // Additional email
    let $additional = $(".additional-email");
    $(".question-email").click(function (e) {
        e.preventDefault();
        $(this).hide();
        $additional.html(`<br>
        <input class="form-control" id="additional-email-id" name="email[additional_email]" placeholder="Email address" type="email" required>
        <button class="btn btn-success additional-email-submit" type="submit">Send</button>
        `);
    });
    $(".additional-email-submit").click(function (e) {
        e.preventDefault();
        let authenticity_token = $("#authenticity_token").val();
        let email = $("#additional-email-id").val();
        let user_id = $("#email-user-id").val();
        $.ajax({
            method: "POST",
            url: "/scraper/additional-email",
            data: {
                authenticity_token: authenticity_token,
                user_id: user_id,
                additional_email: email
            },
            success: function (data) {
                $additional.html(``);
                $additional.html(`<br>
                <h4>We will send info to this email as well!</h4>
                <a href="" class="another-email">Click here if you want to add another email?</a>
                `);
            }
        });
//         e.preventDefault();
//         $additional.html(``);
//         $additional.html(`<br>
//         <h4>We will send info to this email as well!</h4>
//         <a href="" class="another-email">Click here if you want to add another email?</a>
//         `);
    });


    $(".another-email").click(function (e) {
        e.preventDefault();
        $additional.html(``);
        $additional.html(`<br>
        <input class="form-control" name="email[additional_email]" placeholder="Email address" type="email" required>
        <button class="btn btn-success additional-email-submit" type="submit">Send</button>
        `);
    });
});

function primary_email_address(form) {
    var curSubmit = $("button[type=submit]", form);
    $(curSubmit).button("loading");
    var userId = $("input[name='user[email]']", form).attr('data');
    var shipmentCodeId = $("input[name='user[email]']", form).attr('shipment');
    var email = $("input[name='user[email]']", form).val();
    var token = '<%= hidden_field_tag :authenticity_token, form_authenticity_token %>';

    $.ajax({
        type: 'POST',
        url: '/scraper/store-email',
        data: {user_id: userId, email: email, shipment_code_id: shipmentCodeId},
        success: function (data) {
            $(".primary-email-form").html(`
                    <p class="lead">Your email is saved and you will be informed when something change!</p>
                    <p class="lead">Do you wish to send additional email to someone close?</p>
                    <hr>
                    <form action="scraper/additional-email" method="post" onsubmit="secondary_email_address(this); return false;">
                      
                      <input class="form-control form-control-sm" name="user[email]" data="${userId}" shipment="${data.shipment_id}" placeholder="Additional email address" type="email">
                      <br/>
                      <button class="btn btn-success btn-block btn-sm" type="submit">Save</button>
                    </form>

            `);
            $(".emails-associated").html(`
                <li>${data.email_address}</li>
            `);
        },
        error: function (data) {
            // ei onnsitunut syystä X
            alert("We didn't manage to insert your email address. Try again!");
        }
    });
}

function secondary_email_address(form) {
    var curSubmit = $("button[type=submit]", form);
    $(curSubmit).button("loading");
    var userId = $("input[name='user[email]']", form).attr('data');
    var shipmentCodeId = $("input[name='user[email]']", form).attr('shipment');
    var email = $("input[name='user[email]']", form).val();

    $.ajax({
        type: 'POST',
        url: '/scraper/additional-email',
        data: {user_id: userId, email: email, shipment_code_id: shipmentCodeId},
        success: function (data) {
            $(".primary-email-form").html(`
                    <p class="lead">Same information will be sent to this email also!</p>
            `);
            $(".emails-associated").append(`
                <li>${data.add_email}</li>
            `);
        },
        error: function (data) {
            // ei onnsitunut syystä X
            alert(
                "There was a problem creating additional email address! Try again!");
        }
    });
}


