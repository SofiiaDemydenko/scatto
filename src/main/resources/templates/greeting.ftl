<#import "parts/common.ftl" as c>
<#include "parts/security.ftl">
<@c.page>
    <h5>Hello, <#if name=="unknown">guest<#else>${name}</#if> </h5>
    <div>This is a simple clone of Pinterest</div>
</@c.page>

