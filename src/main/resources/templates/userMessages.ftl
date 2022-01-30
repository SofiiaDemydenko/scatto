<#import "parts/common.ftl" as c>
<#include "parts/security.ftl">

<@c.page>
    <link rel="stylesheet" href="/static/cards_style.css">
    <#if errorMessage??><div class="text-danger">${errorMessage}</div></#if>

    <h2>${userChannel.username}</h2>
    <#if !isCurrentUser>
        <div class="container">
            <#if !isSubscibed?? && subscribersCount != 0>
                <a href="/user/unsubscribe/${userChannel.id}" class="btn btn-outline-dark">Unsubscribe</a>
            <#else>
                <a href="/user/subscribe/${userChannel.id}" class="btn btn-outline-dark">Subscribe</a>
            </#if>
        </div>
    </#if>

    <div class="container">
        <div class="row">
            <div class="col my-3">
                <div class="card border-success mb-3">
                    <div class="card-body">
                        <div class="card-title">Subscriptions</div>
                        <h3>
                            <a href="/user/subscriptions/${userChannel.id}">${subscriptionsCount}</a>
                        </h3>
                    </div>
                </div>
            </div>
            <div class="col my-3">
                <div class="card border-success">
                    <div class="card-body">
                        <div class="card-title">Subscribers</div>
                        <h3>
                            <a href="/user/subscribers/${userChannel.id}">${subscribersCount}</a>
                        </h3>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <#if isCurrentUser && RequestParameters.message??>
        <form method="post" action="/user-messages/${currentUserId}" enctype="multipart/form-data">
            <div class="container">
                <h5>Message Editor:</h5>
                <#include "parts/setMessage.ftl">
            </div>
        </form>
    </#if>

    <#include "parts/messages.ftl">
</@c.page>