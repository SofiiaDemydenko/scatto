<#import "parts/common.ftl" as c>

<@c.page>
    <h5>${user.username}</h5>
    <table class="table table-hover">
        <thead>
        <tr>
            <th scope="col"><#if subscriptions??>Subscriptions<#else>Subscribers</#if></th>
        </tr>
        </thead>
        <tbody>
        <#if subscriptions??>
            <#list subscriptions as subscription>
                <tr>
                    <td><a href="/user-messages/${subscription.id}">${subscription.username}</a></td>
                </tr>
            </#list>

            <#else>
                <#list subscribers as subscriber>
                    <tr>
                        <td><a href="/user-messages/${subscriber.id}">${subscriber.username}</a></td>
                    </tr>
                </#list>
        </#if>
        </tbody>
    </table>
</@c.page>