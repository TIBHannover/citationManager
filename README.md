[<img src="assets/images/optimeta_logo_full_bg_white.png" height="100"/>](https://projects.tib.eu/optimeta/en/)
[<img src="assets/images/komet_logo_full_bg_white.png" height="100"/>](https://projects.tib.eu/komet/en/)

# Citation Manager Plugin

Citation Manager for OJS

- [Citation Manager Plugin](#citation-manager-plugin)
- [Features](#features)
    - [Extract PID's](#extract-pids)
    - [Get structured metadata from external services](#get-structured-metadata-from-external-services)
    - [Deposit to OpenCitations](#deposit-to-opencitations)
    - [Deposit Wikidata.org](#deposit-wikidataorg)
- [Install and configure the plugin](#install-and-configure-the-plugin)
    - [Requirements](#requirements)
    - [Install with Git](#install-with-git)
    - [Install via direct download](#install-via-direct-download)
    - [Configuration of the plugin](#configuration-of-the-plugin)
- [Development](#development)
    - [Structure](#structure)
    - [Notes](#notes)
    - [Tests](#tests)
- [Contribute](#contribute)
- [License](#license)

[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-2.1-4baaaa.svg)](CODE_OF_CONDUCT.md)

# Features

### Extract PID's

- DOI
- URL
- URN
- Handle
- Arxiv

### Get structured metadata from external services

- OpenAlex.org
- Orcid.org

### Batch process

- Batch process can be executed from Website > Plugins > Settings.
- Batch process is automatically triggered by the Task Scheduler.
- All publications which are not declined are processed.

### Batch deposit

- Batch deposit can be executed from Website > Plugins > Settings.
- Batch deposit is automatically triggered by the Task Scheduler.
- All publications which are published are deposited.

### Deposit to OpenCitations

1. Metadata
    - id
    - title
    - author
    - pub_date
    - venue
    - volume
    - issue
    - page
    - type
    - publisher
    - editor

2. Citing and cited relation
    - citing_id
    - citing_publication_date
    - cited_id
    - cited_publication_date

Please see https://github.com/opencitations/crowdsourcing for more information.

### Deposit Wikidata.org

Only items which have unique identifiers will be deposited to Wikidata.

1. author
    - labels (en, ...)
    - instance of ([P31](https://www.wikidata.org/wiki/Property:P31)) >
      human ([Q5](https://www.wikidata.org/wiki/Q5))
    - orcid id ([P496](https://www.wikidata.org/wiki/Property:P496)) (identifier)
2. journal
    - labels (en, ...)
    - instance of ([P31](https://www.wikidata.org/wiki/Property:P31)) >
      scientific journal ([Q5633421](https://www.wikidata.org/wiki/Q5633421))
    - issn ([P236](https://www.wikidata.org/wiki/Property:P236)) (identifier)
    - title ([P1476](https://www.wikidata.org/wiki/Property:P1476))
3. cited article (scholarly article)
    - labels (en, ...)
    - instance of ([P31](https://www.wikidata.org/wiki/Property:P31)) >
      scholarly article ([Q13442814](https://www.wikidata.org/wiki/Q13442814))
    - doi ([P356](https://www.wikidata.org/wiki/Property:P356)) (identifier)
    - title ([P1476](https://www.wikidata.org/wiki/Property:P1476))
4. main article (scholarly article)
    - labels (en, ...)
    - instance of ([P31](https://www.wikidata.org/wiki/Property:P31)) >
      scholarly article ([Q13442814](https://www.wikidata.org/wiki/Q13442814))
    - doi ([P356](https://www.wikidata.org/wiki/Property:P356)) (identifier)
    - title ([P1476](https://www.wikidata.org/wiki/Property:P1476))
    - publication date ([P577](https://www.wikidata.org/wiki/Property:P577))
    - volume ([P478](https://www.wikidata.org/wiki/Property:P478))
    - author ([P50](https://www.wikidata.org/wiki/Property:P50)) [1. author]
    - published in ([P1433](https://www.wikidata.org/wiki/Property:P1433)) [2. journal]
    - cites work ([P2860](https://www.wikidata.org/wiki/Property:P2860)) [3. cited article]

# Install and configure the plugin

### Requirements

- PHP 8.1+

### Install with Git

Get the correct version for you OJS version:

- branch stable-3_3_0: use this version for OJS version 3.3.0.x \
  `git clone -b stable-3_3_0 https://github.com/TIBHannover/citationManager`
- branch stable-3_4_0: use this version for OJS version 3.4.0.x \
  `git clone -b stable-3_4_0 https://github.com/TIBHannover/citationManager`

### Install via direct download

- Download release for your OJS version from [here](https://github.com/TIBHannover/citationManager/releases).
  _Note the correct version for you OJS version._
- Alternatively, download the code with the option 'Download ZIP'.
  _Note the correct branch for your OJS version._
- Extract the downloaded file to `/plugins/generic/citationManager`.

### Configuration of the plugin

- Login in your OJS instance as an Administrator or Manager
- Navigate to Website > Plugins > Installed Plugins > Generic Plugins > Citation Manager Plugin
    - Activate the plugin by clicking the checkbox
- Click on the arrow at the left and click "Settings"
- Fill in your authentication info as described in the sections [OpenCitations](#opencitationsorg-crowdsourcing)
  and [Wikidata](#wikidataorg)
- Click Save

#### OpenCitations.org crowdsourcing

Depositing at OpenCitations will be done through GitHub issues of OpenCitations/crowdsourcing. \
For this you need a GitHub account, if you have none please register one through https://github.com/signup.

- Login at https://github.com and navigate to https://github.com/settings/tokens
- Click "Generate new token" button at the right top
- At the input field "Note" typ in "OpenCitations CROCI"
- Select "No expiration" at Expiration selectbox
- Check the checkbox "public_repo"; leave all other checkboxes unchecked
- Click on the button "Generate token"
- You will be provided the token; save this token, as you will not shown this again
- Login to your OJS with an administrator account
- Navigate to Settings > Website > Plugins and find "Citation Manager Plugin" on the page
- Click on the arrow at the left and click "Settings"
- At Owner field, fill in "OpenCitations"
- At Repository field, fill in "crowdsourcing"
- Fill in your token, which you generated above
- Click Save

#### Wikidata.org

Depositing at Wikidata.org will be done through the wikidata API. \
For this you need an account on Wikidata.org. \
If you have none please register one through https://www.wikidata.org/w/index.php?title=Special:CreateAccount.

- Login at https://www.wikidata.org and navigate to https://www.wikidata.org/wiki/Special:BotPasswords
- Type a name (e.g. OJSCitationManager) at "Bot name" in the section "Create a new bot password"
- Check the following permissions: "High-volume editing", "Edit existing pages", Edit protected pages, "Create, edit,
  and move pages"
- Optionally, add your server IP address(es) into the field "Allowed IP ranges"
- Click on the button "Create"
- After creation, you will be redirected to a page where your credentials are shown
- Save these data somewhere safe
- Login to your OJS with an administrator account
- Navigate to Settings > Website > Plugins and find "Citation Manager Plugin" on the page
- Click on the arrow at the left and click "Settings"
- At "Wikidata bot username" field, fill in the username which you saved previously (e.g. Username@OJSCitationManager)
- At "Wikidata bot password", fill in the password which you have saved previously
- Click Save

# Screenshot(s)

![OPTIMETA screenshot add submission](assets/screenrecordings/submission-edit.gif)

# Development

- Fork the repository
- Make your changes
- Open a PR with your changes

### Structure

    .
    ├─ assets                               # Styles, images, javascript files
    ├─ classes                              # Main folder with models / logic
    │   ├─ DataModels                       # Data models used in this plugin
    │   │   ├─ Citation                     # Data models for citations, authors in citations
    │   │   └─ Metadata                     # Metadata for OJS authors, journals and publications
    │   └─ Db                               # Database related classes
    │   │   ├─ PluginDAO.php                # Retrieve / save data to / from database
    │   │   └─ PluginSchema.php             # Schema extestions for data models
    │   ├─ External                         # Classes for external services
    │   |   ├─ Wikidata                     # Classes for Wikidata.org
    |   |   |  ├─ DataModels                # Data models for this service, e.g. mappings
    │   |   |  ├─ Api.php                   # Methods for connecting to their API
    │   |   |  ├─ Deposit.php               # Methods for depositing data
    │   |   |  └─ Enrich.php                # Methods for retrieving data
    |   |   ├─ ... Other services           # Other services follow the same structure
    |   |   ├─ ApiAbstract.php              # This class is used by service Api class
    |   |   ├─ DepositAbstract.php          # This class is used by service Deposit class
    |   |   └─ EnrichAbstract.php           # This class is used by service Enrich class
    │   ├─ FrontEnd                         # Classes for the front end, e.g. ArticleView
    │   ├─ Handlers                         # Handlers, e.g. Deposit, Enrich, API
    │   ├─ Helpers                          # Helper classes
    │   ├─ PID                              # PID classes
    │   ├─ ScheduledTasks                   # Classes for the scheduler
    │   ├─ Settings                         # Settings classes
    │   └─ Workflow                         # Classes or the workflow and submission wizard
    ├─ cypress                              # Cypress tests
    ├─ docs                                 # Documentation, examples
    ├─ locale                               # Language files
    ├─ templates                            # Templates folder
    ├─ tests                                # Tests folder
    │   └─ classes                          # Classes for tests
    ├─ vendor                               # Composer autoload and dependencies
    ├─ .gitignore                           # Git ignore file
    ├─ CitationManagerPlugin.php            # Main class of plugin
    ├─ composer.json                        # Composer file, e.g. dependencies, classmap
    ├─ CONDUCT.md                           # Code of conduct
    ├─ cypress.config.js                    # Cypress configuration file
    ├─ LICENSE                              # License file
    ├─ README.md                            # This file
    ├─ scheduledTasks.xml                   # Scheduler configuration file
    └─ version.xml                          # Version information of the plugin

### Notes

- Autoload of the classes in the folder `classes` is done with
  composer [classmap](https://getcomposer.org/doc/04-schema.md#classmap).
- If you add or remove classes in this folder, run the following command to update
  autoload files: `composer dump-autoload -o --no-dev`.
- Running `composer install -o --no-dev` or `composer update -o --no-dev` will also generate the autoload files.
- The `-o` option generates the optimised files ready for production.
- If you are developing, you might use the classes in `tests/classes`.
  Test or sandbox versions of API's will be used in this case, e.g. test.wikidata.org.
  For using this, use `composer dump-autoload -o --dev` for creating the autoload files.
- If isDebugMode = true, debug information will be written to the log file (see LogHelper class)
  such as API calls. _Careful with sensitive information, (passwords, tokens) will be written in plain text._
  Debug information is written to the log file in the `files_dir` directory of your OJS instance.
  You can find this in your config.inc.php file.

### Tests

```bash
npm install

# start containers
npm run-script test_compose

# run tests with UI
npm run-script test_open
```

# Data models

## Models for citations

1. Citation (CitationModel)
    - doi _The DOI for the work._
    - title _The title of this work._
    - publication_year _The year this work was published._
    - publication_date _The publication date, formatted as an ISO 8601 date e.g. 2018-02-13._
    - type _The type or genre of the work, e.g. journal-article._
    - volume _The volume of the issue of the journal, e.g. 495._
    - issue _The issue of the journal, e.g. 7442._
    - pages _The number of pages of the work/article, e.g. 4._
    - first_page _The first page of the work/article, e.g. 49._
    - last_page _The last page of the work/article, e.g. 59._
    - abstract _The abstract of this work._
    - authors _List of AuthorModel objects._
    - journal_name _Name of the journal._
    - journal_issn_l _Issn_l of the journal._
    - journal_publisher _Publisher name of the journal._
    - url _URL for the work._
    - urn _URN for the work._
    - arxiv_id _The arxiv id of the work._
    - handle_id _The handle id of the work._
    - openalex_id _The OpenAlex ID of the work._
    - wikidata_id _The Wikidata QID of the work._
    - opencitations_id _Open Citations ID._
    - github_issue_id _GitHub Issue ID used by Open Citations._
    - raw _The unchanged raw citation._
    - isProcessed _Is processed / structured._
2. Author (AuthorModel)
    - orcid_id _The ORCID ID for this author._
    - display_name _The name of the author as a single string._
    - given_name _The given name of the author as a single string._
    - family_name _The family name of the author as a single string._
    - wikidata_id _The Wikidata QID._
    - openalex_id _The OpenAlex ID._

## Metadata of OJS models

1. Journal (MetadataJournal)
    - openalex_id _The OpenAlex ID of the work._
    - wikidata_id _The Wikidata QID of the work._
2. Author (MetadataAuthor)
    - openalex_id _The OpenAlex ID of the work._
    - wikidata_id _The Wikidata QID of the work._
3. Publication (MetadataPublication)
    - openalex_id _The OpenAlex ID of the work._
    - wikidata_id _The Wikidata QID of the work._
    - opencitations_id _Open Citations ID._
    - github_issue_id _GitHub Issue ID used by Open Citations._

# Contribute

All help is welcome: asking questions, providing documentation, testing, or even development.

Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md).
By participating in this project you agree to abide by its terms.

# License

This project is published under GNU General Public License, Version 3.

---
