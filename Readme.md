# gitlab-sonar-scanner

## Using in your gitlab projects

Add the next stage to your `.gitlab-ci.yml`.

```yaml
stages:
- analysis

sonarqube:
  stage: analysis
  image: hiorgserver/gitlab-sonar-scanner
  variables:
    SONAR_URL: "http://your-gocd-server:9000"
    SONAR_TOKEN: "$GITLAB_CI_SECRET_VAR_SONAR_TOKEN"
    SONAR_PROJECT_KEY: "$CI_PROJECT_NAMESPACE:$CI_PROJECT_NAME"
    SONAR_PROJECT_NAME: "$CI_PROJECT_NAME"
    SONAR_BRANCH: "$CI_COMMIT_REF_NAME"
    SONAR_PROJECT_VERSION: "$CI_JOB_ID"
    SONAR_GITLAB_COMMENT: "true"
    SONAR_PUBLISH: "true"
  script:
  - /usr/bin/sonar-scanner-run.sh
```

You should have analysed the project by hand before to create it in your sonarqube server.

## Available environment variables

Can be checked in the official documentation: https://docs.sonarqube.org/display/SONARQUBE43/Analysis+Parameters

- SONAR_URL
- SONAR_PROJECT_KEY
- SONAR_PROJECT_NAME
- SONAR_PROJECT_VERSION
- SONAR_TOKEN
- SONAR_DEBUG
- SONAR_SOURCES _or_ SONAR_SCAN_SUBDIR
- SONAR_PROFILE
- SONAR_LANGUAGE
- SONAR_BRANCH
- SONAR_GITLAB_COMMENT [true|false]
- SONAR_PUBLISH [true|false]
