<#import "parts/common.ftl" as c>
<#include "parts/security.ftl">
<@c.page>
    <form action="/user/delete" method="post" xmlns="http://www.w3.org/1999/html">
        <h5 class="text-danger">Delete Account</h5>
        <div>
            You will permanently delete your Scatto account and all its data by submitting the form below.
        </div>
        <a class="py-4 font-weight-bold">Account to delete:     </a>
        <a>${username}</a>
            <div class="font-weight-bold">Please type in 'confirm'</div>
            <div class="form-group">
                <input type="text" class="form-control" name="confirmation">
            </div>
            <#if message??>
                <div class="text-danger">${message}</div>
            </#if>
        <button type="submit" class="btn btn-outline-danger">Delete</button>
        <a href="/main" class="btn btn-outline-success">Cancel</a>

        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
    </form>
</@c.page>

