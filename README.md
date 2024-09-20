# ToDo App ![version](https://img.shields.io/badge/version-1.0-blue) ![coverage](https://img.shields.io/badge/RSpec-100%25-success)
A simple web application to manage checklists and tasks.

[![forthebadge](http://forthebadge.com/images/badges/made-with-ruby.svg)](http://forthebadge.com) [![forthebadge](http://forthebadge.com/images/badges/made-with-vue.svg)](http://forthebadge.com)

## Table of Contents
- [Features](#features)
- [Requirements](#requirements)
- [Setup](#setup)
- [Development](#development)
- [Feedback](#feedback)
- [Contributing](#contributing)
- [License](#license)

## Features

- ##### Simple landing page
- ##### User registration and secure authentication (strong password validation)
- ##### Option to enable/disable Two Factor Authentication using OTP
- ##### Checklists management - create, update or delete
- ##### Tasks management - create, update, delete
- ##### Option to move task on checklist using drag&drop
- ##### Option to upload thumbnail for checklist
- ##### Option to export checklist as PDF file
- ##### Option to send checklist via email

## Tools

- Ruby 3.2.2
- Node 20.9.0
- TypeScript 5.5.4
- Rails 7.1.3.4
- Vue 3.4.38
- Vite 5.0.0
- TailwindCSS 3.4.10

## Setup

##### 1. Install application dependencies
```bash
bundle install
yarn install
```

##### 2. Create and setup the database
```bash
bundle exec rake db:create
bundle exec rake db:setup
```

##### 3. Start dev servers
```bash
# run rails and vite servers
bin/dev
```

## Development

```bash
# RSpec
bundle exec rspec

# Rubocop
bundle exec rubocop

# Vitest
yarn run test

# TypeScript Check
yarn run ts:check

# ESlint
yarn run eslint
```

## Feedback

Feel free to send us feedback. Feature requests are always welcome. If you wish to contribute, please take a quick look at the guidelines!

If you notice any bugs in the app, see some code that can be improved, or have features you would like to be added, please create a bug report or a feature request!

A good bug report must include the following four things:

1. **The steps to reproduce the bug**: Give detailed steps on how to reproduce the problem
2. **The expected behavior of the application**: It’s important to include the result you’re expecting, as it might differ from how the program was designed to work.
3. **The observed behavior of the application**
4. **Additional info**: ... like some links, images etc.

## Contributing

We encourage you to contribute to ToDo App! See [CONTRIBUTING](CONTRIBUTING.md) for guidelines about how to proceed.

Thank you for your interest in contributing! Please feel free to put up a PR for any issue or feature request.

If you want to open a PR that fixes a bug or adds a feature, then we can't thank you enough! It is definitely appreciated if an issue has been created before-hand so it can be discussed first.

## License

ToDo App is released under the *MIT* license.
