$(document).ready(function () {
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
        let data_string = `{'authenticity_token'=>${authenticity_token},'email'=>{'user_id'=>${user_id},'additional_email'=>${email}}`
        $.ajax({
            method: "POST",
            url: "/scraper/additional-email",
            data: data_string,
            success: function (data) {
                alert('bavoooo!!!');
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
