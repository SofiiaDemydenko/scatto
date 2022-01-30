<#import "parts/common.ftl" as c/>

<@c.page>
    <h5 class="bm-5">User editor</h5>
    <form action="/user" method="post">
        <div class="form-group row">
            <label for="username" class="col-sm-2 col-form-label">Username</label>
            <div class="col-sm-10">
                <input type="text" value="${user.username}" class="form-control" name="username">
            </div>
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <input type="hidden" name="userId" value="${user.id}"/>
        <#list roles as role>
            <div class="form-group row">
                <div class="col-sm-2">Checkbox</div>
                <div class="col-sm-10">
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" name="${role}" ${user.roles?seq_contains(role)?string("checked", "")}>
                        <label class="form-check-label" for="${role}">
                            ${role}
                        </label>
                    </div>
                </div>
            </div>
        </#list>
        <div class="form-group row">
            <div class="col-sm-10">
                <button type="submit" class="btn btn-primary">Save</button>
            </div>
        </div>
    </form>
</@c.page>