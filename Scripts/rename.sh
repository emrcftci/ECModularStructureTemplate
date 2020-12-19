#!/bin/bash
# -*- coding: utf-8 -*-

NEW_PROJECT_NAME="$1"

if [ "$NEW_PROJECT_NAME" == "0" ] || [ -z "$NEW_PROJECT_NAME" ]; then
# You can find some chars hex code to change the "emoji" 
# https://www.fileformat.info/info/unicode/char/search.htm
  echo -e "\xf0\x9f\x98\xa0 Please pass a new project name ass an argument <./rename.sh 'new_project_name'>" 
  exit
else 
  echo "new name is -> $NEW_PROJECT_NAME"
fi

WORKSPACEDATA_DIR="ECTemplate.xcworkspace/contents.xcworkspacedata"
TMP_WORKSPACEDATA_DIR="ECTemplate.xcworkspace/tmp_contents.xcworkspacedata"
PBXPROJ_DIR="ECTemplate/ECTemplate.xcodeproj/project.pbxproj"
TMP_PBXPROJ_DIR="ECTemplate/ECTemplate.xcodeproj/tmp_project.pbxproj"
UPDATED_WORKSPACEDATA_DIR="$NEW_PROJECT_NAME.xcworkspace/contents.xcworkspacedata"
UPDATED_TMP_WORKSPACEDATA_DIR="$NEW_PROJECT_NAME.xcworkspace/tmp_contents.xcworkspacedata"
TEMPLATE_BUNDLE_ID="ectemplate"

COMMON_PBXPROJ_DIR="Common/Common.xcodeproj/project.pbxproj"
TMP_COMMON_PBXPROJ_DIR="Common/Common.xcodeproj/tmp_project.pbxproj"
NETWORKING_PBXPROJ_DIR="Networking/Networking.xcodeproj/project.pbxproj"
TMP_NETWORKING_PBXPROJ_DIR="Networking/Networking.xcodeproj/tmp_project.pbxproj"
UICOMP_PBXPROJ_DIR="UIComp/UIComp.xcodeproj/project.pbxproj"
TMP_UICOMP_PBXPROJ_DIR="UIComp/UIComp.xcodeproj/tmp_project.pbxproj"

TEMPLATE_TAG="ECTemplate"
APP_DELEGATE_DIR="$NEW_PROJECT_NAME/$NEW_PROJECT_NAME/AppDelegate.swift"
TMP_APP_DELEGATE_DIR="$NEW_PROJECT_NAME/$NEW_PROJECT_NAME/tmp_AppDelegate.swift"
VIEW_CONTROLLER_DIR="$NEW_PROJECT_NAME/$NEW_PROJECT_NAME/ViewController.swift"
TMP_VIEW_CONTROLLER_DIR="$NEW_PROJECT_NAME/$NEW_PROJECT_NAME/tmp_ViewController.swift"

cd ..
# Firstly, should change the project's name & necessary fields in .pbxproj
sed "s/ECTemplate.xcodeproj/$NEW_PROJECT_NAME.xcodeproj/g" $WORKSPACEDATA_DIR > $TMP_WORKSPACEDATA_DIR && mv $TMP_WORKSPACEDATA_DIR $WORKSPACEDATA_DIR
sed "s/ECTemplate/$NEW_PROJECT_NAME/g" $PBXPROJ_DIR > $TMP_PBXPROJ_DIR && mv $TMP_PBXPROJ_DIR $PBXPROJ_DIR

# Bundle IDs changed in .pbxproj for the project & all frameworks
sed "s/$TEMPLATE_BUNDLE_ID/$NEW_PROJECT_NAME/g" $PBXPROJ_DIR > $TMP_PBXPROJ_DIR && mv $TMP_PBXPROJ_DIR $PBXPROJ_DIR
sed "s/$TEMPLATE_BUNDLE_ID/$NEW_PROJECT_NAME/g" $COMMON_PBXPROJ_DIR > $TMP_COMMON_PBXPROJ_DIR && mv $TMP_COMMON_PBXPROJ_DIR $COMMON_PBXPROJ_DIR
sed "s/$TEMPLATE_BUNDLE_ID/$NEW_PROJECT_NAME/g" $NETWORKING_PBXPROJ_DIR > $TMP_NETWORKING_PBXPROJ_DIR && mv $TMP_NETWORKING_PBXPROJ_DIR $NETWORKING_PBXPROJ_DIR
sed "s/$TEMPLATE_BUNDLE_ID/$NEW_PROJECT_NAME/g" $UICOMP_PBXPROJ_DIR > $TMP_UICOMP_PBXPROJ_DIR && mv $TMP_UICOMP_PBXPROJ_DIR $UICOMP_PBXPROJ_DIR

# Then change all folders and files name to new one
function rename_folder { 
  cp -R $1 $2; 
  rm -rf $1;
}

rename_folder "ECTemplate" "$NEW_PROJECT_NAME"
rename_folder "$NEW_PROJECT_NAME/ECTemplate.xcodeproj" "$NEW_PROJECT_NAME/$NEW_PROJECT_NAME.xcodeproj"
rename_folder "$NEW_PROJECT_NAME/ECTemplate" "$NEW_PROJECT_NAME/$NEW_PROJECT_NAME"
rename_folder "ECTemplate.xcworkspace" "$NEW_PROJECT_NAME.xcworkspace"

# Change redundant path in .workspacedata
sed "s/ECTemplate/$NEW_PROJECT_NAME/g" $UPDATED_WORKSPACEDATA_DIR > $UPDATED_TMP_WORKSPACEDATA_DIR && mv $UPDATED_TMP_WORKSPACEDATA_DIR $UPDATED_WORKSPACEDATA_DIR

sed "s/$TEMPLATE_TAG/$NEW_PROJECT_NAME/g" $APP_DELEGATE_DIR > $TMP_APP_DELEGATE_DIR && mv $TMP_APP_DELEGATE_DIR $APP_DELEGATE_DIR
sed "s/$TEMPLATE_TAG/$NEW_PROJECT_NAME/g" $VIEW_CONTROLLER_DIR > $TMP_VIEW_CONTROLLER_DIR && mv $TMP_VIEW_CONTROLLER_DIR $VIEW_CONTROLLER_DIR

echo -e "\xf0\x9f\x9a\x80"