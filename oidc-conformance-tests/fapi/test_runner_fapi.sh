#!/bin/bash +x
# ----------------------------------------------------------------------------
#  Copyright 2021 WSO2, Inc. http://www.wso2.org
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.


CONFORMANCE_SUITE_PATH=./conformance-suite
PATH_TO_SCRIPTS=./product-is/oidc-conformance-tests
IS_SUCCESSFUL=false
IS_LOCAL=false

if $IS_LOCAL; then
  PATH_TO_SCRIPTS=.
  PRODUCT_IS_ZIP_PATH=./wso2is-5.12.0-m7.zip
  echo "====================="
  echo "Identity Server Setup"
  echo "====================="
  echo
  python3 ./configure_is.py $PRODUCT_IS_ZIP_PATH
fi

echo "========================"
echo "Running Tests"
echo "========================"
echo


#  sed -i '/^.*all_test_modules\ =.*/a \ \ \ \ print("All available OIDC test modules:")\n\ \ \ \ print("==============================================")\n\ \ \ \ print(sorted(all_test_modules.keys()))' $CONFORMANCE_SUITE_PATH/scripts/run-test-plan.py
echo
echo "FAPI test plan - mtls, plain_fapi, plain_response, by_value"
echo "-----------------------------"
echo
#  python3 $CONFORMANCE_SUITE_PATH/scripts/run-test-plan.py fapi1-advanced-final-test-plan[client_auth_type=mtls][fapi_profile=plain_fapi][fapi_response_mode=plain_response][fapi_auth_request_method=by_value] $PATH_TO_SCRIPTS/fapi/IS_config_fapi.json 2>&1 | tee fapi-mtls-test-log.txt
echo
echo
echo "FAPI test plan - private_key_jwt, plain_fapi, plain_response, by_value"
echo "-----------------------------"
echo
python3 $CONFORMANCE_SUITE_PATH/scripts/run-test-plan.py fapi1-advanced-final-test-plan[client_auth_type=private_key_jwt][fapi_profile=plain_fapi][fapi_response_mode=plain_response][fapi_auth_request_method=by_value] $PATH_TO_SCRIPTS/fapi/IS_config_fapi.json 2>&1 | tee fapi-private_key_jwt-test-log.txt
echo




if $IS_LOCAL; then
  pkill -f wso2
fi

