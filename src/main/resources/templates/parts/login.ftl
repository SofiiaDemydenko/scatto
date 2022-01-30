<#macro login path, button, href, label, isRegistrationPage>
    <form action="${path}" method="post" xmlns="http://www.w3.org/1999/html">
        <div class="form-group">
            <label for="username">Username</label>
            <input type="text" class="form-control ${(usernameError??)?string('is-invalid', '')}"
                   name="username" placeholder="Enter username" value="<#if user??>${user.username}</#if>">
            <#if usernameError??>
                <div class="invalid-feedback">
                    ${usernameError}
                </div>
            </#if>
        </div>
        <#if isRegistrationPage>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" class="form-control ${(emailError??)?string('is-invalid', '')}"
                name="email" placeholder="Enter user email" value="<#if user??>${user.email}</#if>">
                <#if emailError??>
                    <div class="invalid-feedback">
                        ${emailError}
                    </div>
                </#if>
            </div>
        </#if>
        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" class="form-control ${(passwordError??)?string('is-invalid', '')}"
                   name="password" placeholder="Password">
            <#if passwordError??>
                <div class="invalid-feedback">
                    ${passwordError}
                </div>
            </#if>
        </div>
        <#if isRegistrationPage>
            <div class="form-group">
                <label for="password2">Password Confirmation</label>
                <input type="password" class="form-control ${(password2Error??)?string('is-invalid', '')}"
                       name="password2" placeholder="Retype password">
                <#if password2Error??>
                    <div class="invalid-feedback">
                        ${password2Error}
                    </div>
                </#if>
            </div>
            <div>
                <div class="g-recaptcha" data-sitekey="6LcLDjQeAAAAAFw0t-iASECWYVxgtdhtTHN8IR0X"></div>
                <#if captchaError??>
                    <div class="alert alert-danger" role="alert">
                        ${captchaError}
                    </div>
                </#if>
            </div>
        </#if>
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <button type="submit" class="btn btn-primary">${button}</button>
        <a>or</a>
        <a href="${href}">${label}</a>
    </form>
</#macro>
<#macro logout>
    <form action="/logout" method="post">
        <!--Forms without this hidden line will be overlooked by the server-->
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <button type="submit" class="btn btn-outline-secondary">Log out</button>
    </form>
</#macro>