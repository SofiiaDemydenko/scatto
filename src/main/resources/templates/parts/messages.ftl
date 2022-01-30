<#include "security.ftl">

<div class="card-columns">
    <#list messages as message>
        <div class="card">
            <#if message.filename??>
                <img class="card-img-top" src="/img/${message.filename}">
            </#if>
            <div class="card-body">
                <h6 class="card-title">${message.text}</h6>
                <a href="/user-messages/${message.author.id}">
                    <footer class="blockquote-footer">
                        @<cite>${message.getAuthorName()}</cite>
                    </footer>
                </a>
                <footer class="blockquote-footer">#<cite>${message.tag}</cite></footer>
                <#if message.author.id == currentUserId>
                    <a class="d-flex justify-content-end"
                       href="/user-messages/${message.author.id}?message=${message.id}">
                        <footer class=" btn btn-outline-secondary">Edit</footer>
                    </a>
                </#if>
            </div>
        </div>
    <#else>
        No messages
    </#list>
</div>