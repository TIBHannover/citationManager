<?php
/**
 * @file plugins/generic/optimetaCitations/classes/handler/OptimetaCitationsAPIHandler.inc.php
 *
 * Copyright (c) 2014-2021 Simon Fraser University
 * Copyright (c) 2000-2021 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @class PKPUserHandler
 * @ingroup api_v1_users
 *
 * @brief Base class to handle API requests for user operations.
 *
 */
namespace Optimeta\Citations\Handler;

import('lib.pkp.classes.security.authorization.PolicySet');
import('lib.pkp.classes.security.authorization.RoleBasedHandlerOperationPolicy');

use APIHandler;
use Optimeta\Citations\Parser\Parser;
use RoleBasedHandlerOperationPolicy;
use PolicySet;

class OptimetaCitationsAPIHandler extends APIHandler
{
    private $apiEndpoint = OPTIMETA_CITATIONS_API_ENDPOINT;

    private $submissionId = '';
    private $citationsRaw = '';
    private $citationsParsed = '[]';

    private $response = [
        'submissionId' => '',
        'citationsRaw' => '',
        'citationsParsed' => '[]',
        'message' => ''];

    public function __construct()
    {
        $this->_handlerPath = $this->apiEndpoint;

        $this->_endpoints = [
            'POST' => [
                [
                    'pattern' => $this->getEndpointPattern() . '/parse',
                    'handler' => [$this, 'parse'],
                    'roles' => [ROLE_ID_MANAGER, ROLE_ID_SUB_EDITOR, ROLE_ID_ASSISTANT, ROLE_ID_REVIEWER, ROLE_ID_AUTHOR],
                ],
                [
                    'pattern' => $this->getEndpointPattern() . '/submit',
                    'handler' => [$this, 'submit'],
                    'roles' => [ROLE_ID_MANAGER, ROLE_ID_SUB_EDITOR, ROLE_ID_ASSISTANT, ROLE_ID_REVIEWER, ROLE_ID_AUTHOR],
                ],
                [
                    'pattern' => $this->getEndpointPattern() . '/enrich',
                    'handler' => [$this, 'enrich'],
                    'roles' => [ROLE_ID_MANAGER, ROLE_ID_SUB_EDITOR, ROLE_ID_ASSISTANT, ROLE_ID_REVIEWER, ROLE_ID_AUTHOR],
                ]
            ],
            'GET' => [

            ]
        ];

        parent::__construct();
    }

    public function authorize($request, &$args, $roleAssignments)
    {
        $rolePolicy = new PolicySet(COMBINING_PERMIT_OVERRIDES);

        foreach ($roleAssignments as $role => $operations) {
            $rolePolicy->addPolicy(new RoleBasedHandlerOperationPolicy($request, $role, $operations));
        }
        $this->addPolicy($rolePolicy);

        return parent::authorize($request, $args, $roleAssignments);
    }

    public function parse($slimRequest, $response, $args)
    {
        $request = $this->getRequest();

        // check if citationsRaw is in POST
        if ($request->getUserVars() && sizeof($request->getUserVars()) > 0 &&
            isset($request->getUserVars()['citationsRaw'])) {
            $this->citationsRaw = trim($request->getUserVars()['citationsRaw']);
        }

        // citationsRaw not found, response with message
        if (strlen($this->citationsRaw) === 0) {
            $this->response['message'] = 'citationsRaw not found';
            return $response->withJson($this->response, 404);
        }

        // citationsRaw found, assign to response and parse
        $this->response['citationsRaw'] = $this->citationsRaw;

        // parse citations
        $parser = new Parser($this->citationsRaw);
        $this->citationsParsed = $parser->getCitationsParsedJson();

        // citations parsed, assign to response
        $this->response['citationsParsed'] = $this->citationsParsed;

        return $response->withJson($this->response, 200);
    }

    public function submit($slimRequest, $response, $args)
    {
        $this->response['message'] = 'submit';

        return $response->withJson($this->response, 200);
    }

    public function enrich($slimRequest, $response, $args)
    {
        $this->response['message'] = 'enrich';

        return $response->withJson($this->response, 200);
    }
}
