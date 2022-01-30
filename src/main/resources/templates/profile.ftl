<#import "parts/common.ftl" as c>
<#include "parts/security.ftl">

<@c.page>
    <h5><strong>Change user info</strong></h5>
    <form method="post" xmlns="http://www.w3.org/1999/html">
        <div class="mt-8 font-weight-bold">Please enter your current password to get access to the operation</div>
        <div class="form-group">
            <input type="password" class="form-control"
                   name="currentPassword" placeholder="Current password">
        </div>

        <div class="pt-8 font-weight-bold">Choose your new Email or Password</div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" class="form-control"
                       name="email" value="${email!''}">
            </div>
        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" class="form-control"
                   name="password" placeholder="New password">
        </div>
        <div class="form-group">
            <label for="password">Password Confirmation</label>
            <input type="password" class="form-control"
                   name="password2" placeholder="Retype the password">
        </div>
        <button type="submit" class="btn btn-primary">Save</button>

        <!-- Button trigger modal -->
        <button type="button" class=" my-4 btn btn-outline-danger" data-toggle="modal" data-target="#exampleModalLong">
            Delete Account
        </button>

        <!-- Modal -->
        <div class="modal fade" id="exampleModalLong" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLongTitle">Delete Account</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body text-danger">
                        <h6>Warning</h6>
                        This action is not reversible. Your account will be deleted automatically and
                        permanently within a few minutes.
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline-success" data-dismiss="modal">Close</button>
                        <a href="/user/delete/${id}" class="btn btn-outline-danger">Confirm deletion</a>
                    </div>
                </div>
            </div>
        </div>

        <input type="hidden" name="_csrf" value="${_csrf.token}" />
    </form>
</@c.page>