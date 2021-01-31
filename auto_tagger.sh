#! /bin/bash

SPACES="            "

# Custom date to commit and author
read -p "Commit/author date[now]:" CUSTOM_DATE
CUSTOM_DATE=${CUSTOM_DATE:-date}
CUSTOM_DATE_STR=$($CUSTOM_DATE)

function tagPuhser() {

    echo "************************************************"
    echo "          Working Repo: $2             "
    echo "************************************************"

    DIR=$1

    CURRENT_TAG=$(git -C $DIR describe $(git -C $DIR rev-list --tags --max-count=1))

    echo "[$2]: Current tag: $CURRENT_TAG"

    read -p "[$2]: Enter the new tag name [none]:" INPUT
    TAG=${INPUT:-"none"}

    if [ "$TAG" = "none" ] ;
    then
        echo "[$2]: No new tag"
    else
        echo "[$2]: Processing Tag: $TAG"
        COMMENT="Update till: $CUSTOM_DATE_STR"
        read -p "[$2]: Comment for the tag [$COMMENT]: " INPUT
        COMMENT=${INPUT:-"$COMMENT"}
        GIT_COMMITTER_DATE="$CUSTOM_DATE_STR" GIT_AUTHOR_DATE="$CUSTOM_DATE_STR" git -C $DIR tag -a -m "$COMMENT" "$TAG"
        git -C $DIR push origin "$TAG"
    fi
    echo ""
    echo ""
    echo ""
}

function latestTag() {
    DIR=$1
    NAME=$2
    CURRENT_TAG=$(git -C $DIR describe $(git -C $DIR rev-list --tags --max-count=1))
    printf "[ %s %s]:" $NAME "${SPACES:${#NAME}}"
    printf " $CURRENT_TAG %s\n" "${SPACES:${#CURRENT_TAG}}"
}

tagPuhser "src/subCODE" "subCODE"
tagPuhser "src/masterCODE" "masterCODE"
tagPuhser "src/liveCODE" "liveCODE"
tagPuhser "src/doCODE" "doCODE"
# tagPuhser "src/judgeMod" "judgeMod"

latestTag "src/subCODE" "subCODE"
latestTag "src/masterCODE" "masterCODE"
latestTag "src/liveCODE" "liveCODE"
latestTag "src/doCODE" "doCODE"
