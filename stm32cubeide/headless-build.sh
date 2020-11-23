#!/bin/bash

# Full directory name of the script no matter where it is being called from.
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# ===== ARGUMENTS =====
nbParam=$#
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
  -data)
  WORKSPACE_LOC="$key $2"
  shift
  ;;
  -importAll)
  IMPORT_LOC="$key $2"
  shift
  ;;
  -build|-cleanBuild)
  BUILD_OPTION="$key $2"
  shift
  ;;
  -clean)
  BUILD_OPTION="-cleanBuild $2"
  shift
  ;;
  -v|-verbose|--verbose)
  VERBOSE=$key
  ;;
  *|-h|-help|--help)
  HELP=$key
  ;;
esac
shift
done

# ===== HELP =====
if [[ ${nbParam} -eq 0 || -n ${HELP} ]];
then
  echo "To perform headless build or clean of your project in a workspace."
  echo "Example : \"headless-build.sh -build my_project -data /local/workspace\""
  echo
  echo "Options:"
  echo "-data         [path_to_workspace]     Workspace location (required)"
  echo "-build        [project_name | all]    Build the project"
  echo "-clean        [project_name | all]    Clean and build the project"
  echo
  echo "-v|-verbose   Display arguments and command line executed (displayed at the end of the trace)"
  echo "-h|-help      Display this help and exit"
  exit 0;
fi

# ===== COMAND LINE =====
${DIR}/stm32cubeide --launcher.suppressErrors -nosplash -application org.eclipse.cdt.managedbuilder.core.headlessbuild ${BUILD_OPTION} ${IMPORT_LOC} ${WORKSPACE_LOC}
status=$?
echo
echo

# ===== VERBOSE MODE =====
# At the end of the trace to avoid scrolling.
if [[ -n ${VERBOSE} ]];
then
  echo
  echo "========== VERBOSE MODE =========="
  echo "=== ARGS"
  echo "    BUILD_OPTION  = ${BUILD_OPTION}"
  echo "    WORKSPACE_LOC = ${WORKSPACE_LOC}"
  echo "    IMPORT_LOC    = ${IMPORT_LOC}"
  echo
  echo "=== COMMAND_LINE"
  echo "    ${DIR}/stm32cubeide --launcher.suppressErrors -nosplash -application org.eclipse.cdt.managedbuilder.core.headlessbuild ${BUILD_OPTION} ${IMPORT_LOC} ${WORKSPACE_LOC} ${PARALLEL_BUILD}"
  echo "=================================="
  echo
  echo;
fi

exit $status
