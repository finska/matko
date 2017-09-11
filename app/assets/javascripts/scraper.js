(function () {
    "use strict";
    window.addEventListener("load", function () {
        var form = document.getElementById("additional-email-form");
        form.addEventListener("submit", function (event) {
            if (form.checkValidity() == false) {
                event.preventDefault();
                event.stopPropagation();
            }
            form.classList.add("was-validated");
        }, false);
    }, false);
}());


$(document).ready(function () {
    $(".question-email").click(function (e) {
        e.preventDefault();
        $(this).hide();
        let $additional = $(".additional-email");
        $additional.html(`<br>
        <input class="form-control" name="email[additional_email]" placeholder="Email address" type="email" required>
        <button class="btn btn-success additional-email-submit" type="submit">Send</button>
        `);
        $(".additional-email-submit").click(function () {
            $additional.html(``);
            $additional.html(`<br>
        <h4>We will send info to this email as well!</h4>`);
        });

    });
});
