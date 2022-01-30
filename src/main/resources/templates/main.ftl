<#import "parts/common.ftl" as c>
<@c.page>
    <link rel="stylesheet" href="/static/cards_style.css">
    <form method="post" action="/main" enctype="multipart/form-data">
        <h5>Message:</h5>
        <#include "parts/setMessage.ftl">
    </form>
    <h5>Filter:</h5>
    <form method="get" action="/main">
        <div class="row mb-2 col-6">
            <input type="text" class="form-control mb-2" placeholder="Write down the tag to filter messages"
                   name="filter" value="${filter!}">
            <div class="input-group-append">
                <button class="btn btn-primary-secondary mb-4" type="submit">Find</button>
            </div>
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        <input type="hidden" name="id" value="<#if message??>${message.id}</#if>"/>
    </form>
    <#include "parts/messages.ftl">
</@c.page>
