{**
 * templates/settings.tpl
 *
 * @copyright (c) 2021+ TIB Hannover
 * @copyright (c) 2021+ Gazi Yücel
 * @license Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * Settings form for the citationManager plugin.
 *}

<script>
    $(function () {ldelim}
        $('#{$smarty.const.CITATION_MANAGER_PLUGIN_NAME}Settings').pkpHandler('$.pkp.controllers.form.AjaxFormHandler');
        {rdelim});
</script>

<form
        class="pkp_form"
        id="{$smarty.const.CITATION_MANAGER_PLUGIN_NAME}Settings"
        method="POST"
        action="{url router=$smarty.const.ROUTE_COMPONENT op="manage" category="generic" plugin=$pluginName verb="settings" save=true}"
>
    <!-- Always add the csrf token to secure your form -->
    {csrf}

    {fbvFormArea id="citationManagerSettingsArea"}

    {fbvFormSection title="plugins.generic.citationManager.settings.description"}{/fbvFormSection}

        <!-- OpenCitations -->
    {fbvFormSection label="plugins.generic.citationManager.settings.open_citations_title"}
        <p>
            {fbvElement
            type="text"
            id="{\APP\plugins\generic\citationManager\classes\External\OpenCitations\Constants::owner}"
            value=${\APP\plugins\generic\citationManager\classes\External\OpenCitations\Constants::owner}
            label="plugins.generic.citationManager.settings.open_citations_owner"
            description="plugins.generic.citationManager.settings.open_citations_owner"
            placeholder="plugins.generic.citationManager.settings.open_citations_owner"
            }
        </p>
        <p>
            {fbvElement
            type="text"
            id="{\APP\plugins\generic\citationManager\classes\External\OpenCitations\Constants::repository}"
            value=${\APP\plugins\generic\citationManager\classes\External\OpenCitations\Constants::repository}
            label="plugins.generic.citationManager.settings.open_citations_repository"
            description="plugins.generic.citationManager.settings.open_citations_repository"
            placeholder="plugins.generic.citationManager.settings.open_citations_repository"
            }
        </p>
        <p>
            {fbvElement
            type="text"
            password=true
            id="{\APP\plugins\generic\citationManager\classes\External\OpenCitations\Constants::token}"
            value=${\APP\plugins\generic\citationManager\classes\External\OpenCitations\Constants::token}
            label="plugins.generic.citationManager.settings.open_citations_token"
            description="plugins.generic.citationManager.settings.open_citations_token"
            placeholder="plugins.generic.citationManager.settings.open_citations_token"
            }
        </p>
    {/fbvFormSection}
        <!-- OpenCitations -->

        <!-- Wikidata -->
    {fbvFormSection label="plugins.generic.citationManager.settings.wikidata_title"}
        <p>
            {fbvElement
            type="text"
            id="{\APP\plugins\generic\citationManager\classes\External\Wikidata\Constants::username}"
            value=${\APP\plugins\generic\citationManager\classes\External\Wikidata\Constants::username}
            label="plugins.generic.citationManager.settings.wikidata_username"
            description="plugins.generic.citationManager.settings.wikidata_username"
            placeholder="plugins.generic.citationManager.settings.wikidata_username"
            }
        </p>
        <p>
            {fbvElement
            type="text"
            password=true
            id="{\APP\plugins\generic\citationManager\classes\External\Wikidata\Constants::password}"
            value=${\APP\plugins\generic\citationManager\classes\External\Wikidata\Constants::password}
            label="plugins.generic.citationManager.settings.wikidata_password"
            description="plugins.generic.citationManager.settings.wikidata_password"
            placeholder="plugins.generic.citationManager.settings.wikidata_password"
            }
        </p>
    {/fbvFormSection}
        <!-- Wikidata -->

        <!-- Show at Front -->
    {fbvFormSection title="plugins.generic.citationManager.settings.show_structured_frontend.title" list="true"}
    {fbvElement
    type="checkbox"
    name="{CitationManagerPlugin::FRONTEND_SHOW_STRUCTURED}"
    id="{CitationManagerPlugin::FRONTEND_SHOW_STRUCTURED}"
    value={CitationManagerPlugin::FRONTEND_SHOW_STRUCTURED}
    label="plugins.generic.citationManager.settings.show_structured_frontend.checkbox"
    checked=${CitationManagerPlugin::FRONTEND_SHOW_STRUCTURED}
    }
    {/fbvFormSection}
        <!-- Show at Front -->

    {/fbvFormArea}

    {fbvFormButtons submitText="common.save"}
</form>
