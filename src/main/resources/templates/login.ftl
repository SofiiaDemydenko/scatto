<#import "parts/common.ftl" as c>
<#import "parts/login.ftl" as l>
<@c.page>
    <h5><strong>Log in</strong></h5>
    <div class="mb-4">Please enter your Username and Password</div>

<#--    <#if Session?? && Session.SPRING_SECURITY_LAST_EXCEPTION??>-->
    <#if RequestParameters.error??>
        <div class="alert alert-danger" role="alert">
            ${Session.SPRING_SECURITY_LAST_EXCEPTION.message}
        </div>
    </#if>
    <#if message??>
        <div class="alert alert-${messageType}" role="alert">
            ${message}
        </div>
    </#if>
    <@l.login "/login" "Sign in" "/registration" "Create new user" false/>
</@c.page>
