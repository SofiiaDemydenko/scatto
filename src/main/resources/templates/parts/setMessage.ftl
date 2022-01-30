<div class="form-row mb-2">
    <div class="col-8">
        <input type="text" class="form-control ${(textError??)?string('is-invalid', '')}"
               value="<#if message??>${message.text}</#if>" placeholder="Message..." name="text"/>
        <#if textError??>
            <div class="invalid-feedback">
                ${textError}
            </div>
        </#if>
    </div>
    <div class="col-2">
        <div class="input-group">
            <div class="input-group-prepend">
                <div class="input-group-text">#</div>
            </div>
            <input type="text" class="form-control ${(tagError??)?string('is-invalid', '')}"
                   value="<#if message??>${message.tag}</#if>" placeholder="Tag" name="tag"/>
            <#if tagError??>
                <div class="invalid-feedback">
                    ${tagError}
                </div>
            </#if>
        </div>
    </div>
    <div class="custom-file col-2">
        <input type="file" name="file" class="custom-file-input
                    form-control ${(fileFlash??)?string('is-invalid', '')}">
        <label class="custom-file-label" for="file">Choose file</label>
        <#if fileFlash??>
            <div class="invalid-feedback">
                ${fileFlash}
            </div>
        </#if>
    </div>
</div>
<button type="submit" class="btn btn-primary-secondary mb-4">Save</button>
<input type="hidden" name="_csrf" value="${_csrf.token}"/>
<input type="hidden" name="id" value="<#if message??>${message.id}<#else>-1</#if>"/>