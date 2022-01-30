<#include "security.ftl">
<#import "login.ftl" as l>

<nav class="navbar navbar-expand-lg navbar-light" style="background-color:#BFD9FF">
    <a class="navbar-brand mb-0 h1" href="/">
        <img src="/images/scatto_logo1.png" width="26" height="26" class="d-inline-block align-top" alt="">
        Scatto
    </a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item">
                <a class="nav-link" href="/">Home</a>
            </li>
            <#if user??>
                <li class="nav-item">
                    <a class="nav-link" href="/main">Messages</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/user-messages/${currentUserId}">My Messages</a>
                </li>
            </#if>
            <#if isAdmin>
                <li class="nav-item">
                    <a class="nav-link" href="/user">User list</a>
                </li>
            </#if>
            <#if user??>
                <li class="nav-item">
                    <a class="nav-link" href="user/profile">My Profile</a>
                </li>
            </#if>
        </ul>
        <div class="navbar-text mr-2">${name}</div>
        <#if name!="unknown">
            <@l.logout/>
            <#else>
            <a class="btn btn-outline-secondary" href="/login">Log in</a>
        </#if>
    </div>
</nav>