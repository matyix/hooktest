# hooktest

Repository webhook for GitHub.

NGrok - https://10009877.ngrok.io

Branch re-open/rebase test

trigger

deploy:
    steps:
      - matyix/hooktest-deploy@0.0.1:
          url: $DEPLOY_WEBHOOK


