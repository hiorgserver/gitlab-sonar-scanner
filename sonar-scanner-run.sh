#!/bin/sh

  COMMAND="sonar-scanner"

  if [ ! -z "$SONAR_SOURCES" ]; then
    COMMAND="$COMMAND -Dsonar.sources=\"$SONAR_SOURCES\""
  else
    SONAR_SOURCES=$(pwd)
    if [ ! -z "$SONAR_SCAN_SUBDIR" ]; then
      SCANDIR="$SONAR_SOURCES/$SONAR_SCAN_SUBDIR"
    fi
    COMMAND="$COMMAND -Dsonar.sources=\"$SONAR_SOURCES\""
  fi

  if [ ! -z "$SONAR_URL" ]; then
    COMMAND="$COMMAND -Dsonar.host.url=\"$SONAR_URL\""
  fi

  if [ ! -z "$SONAR_PROJECT_KEY" ]; then
    COMMAND="$COMMAND -Dsonar.projectKey=\"$SONAR_PROJECT_KEY\""
  fi

  if [ ! -z "$SONAR_TOKEN" ]; then
    COMMAND="$COMMAND -Dsonar.login=\"$SONAR_TOKEN\""
  fi

  if [ ! -z "$SONAR_PROJECT_NAME" ]; then
    COMMAND="$COMMAND -Dsonar.projectName=\"$SONAR_PROJECT_NAME\""
  fi
  if [ ! -z "$SONAR_BRANCH" ]; then
    COMMAND="$COMMAND -Dsonar.branch=\"$SONAR_BRANCH\""
  fi
  if [ ! -z "$SONAR_PROJECT_VERSION" ]; then
    COMMAND="$COMMAND -Dsonar.projectVersion=\"$SONAR_PROJECT_VERSION\""
  fi

  if [ ! -z "$SONAR_PROFILE" ]; then
    COMMAND="$COMMAND -Dsonar.profile=\"$SONAR_PROFILE\""
  fi

  if [ ! -z "$SONAR_LANGUAGE" ]; then
    COMMAND="$COMMAND -Dsonar.language=\"$SONAR_LANGUAGE\""
  fi

  if [ ! -z "$SONAR_DEBUG" ]; then
    COMMAND="$COMMAND -X"
  fi


  if $SONAR_GITLAB_COMMENT ; then
    if $SONAR_PUBLISH ; then
      echo "(publish 2 sonar)"
      eval $COMMAND
    fi
    
    COMMAND="$COMMAND -Dsonar.analysis.mode=\"issues\""
    if [ ! -z "$CI_PROJECT_ID" ]; then
      COMMAND="$COMMAND -Dsonar.gitlab.project_id=\"$CI_PROJECT_ID\""
    fi
    if [ ! -z "$CI_COMMIT_SHA" ]; then
      COMMAND="$COMMAND -Dsonar.gitlab.commit_sha=\"$CI_COMMIT_SHA\""
    fi
    if [ ! -z "$CI_COMMIT_REF_NAME" ]; then
      COMMAND="$COMMAND -Dsonar.gitlab.ref_name=\"$CI_COMMIT_REF_NAME\""
    fi
    
    echo "(comment 2 gitlab)"
    eval $COMMAND
    
  else
    echo "(publish 2 sonar)"
    eval $COMMAND
  fi
