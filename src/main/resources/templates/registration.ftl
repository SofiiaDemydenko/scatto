<#import "parts/common.ftl" as c>
<#import "parts/login.ftl" as l>

<@c.page>
    <h5><strong>Create Account</strong></h5>
    <div class="mb-4">Get started with your free account</div>
    <h6 style="color: mediumseagreen">${message?ifExists}</h6>
    <@l.login "/registration" "Create" "/login" "Sign in" true/>
</@c.page>

