AWS CLI
========

This cookbook configures a system to install and utilize the AWS CLI

REQUIREMENTS
=============

Chef Client 11.16.4
PIP Recipe

ATTRIBUTES
===========

The attributes used by this cookbook are under the `awscli` name space.

Attribute           | Description                                                                     | Type
--------------------|---------------------------------------------------------------------------------|--------
local_package_file  | The remote path of where the AWS CLI page is located                            | String
                    |  + Additional Params : `os` - used to specify what OS is being used             |
                    |  + Example : ['awscli']['local_package_file']['rhel']                 |
                    |  + Required if `package_local_path` is not set                                  |
pip_install         | Flag to specify if PIP needs to be installed                                    | Boolean
                   
RECIPES
========

This section describes the recipes and how to use them in your environment

default
--------

This recipe will
 * Download the AWS CLI from an S3 bucket
 * Install the CLI

The logic of the recipe will first check to see what system is provided as an attribute.
Then, the recipe will run the installation command.
Note that if the system is a RHEL or CENTOS machine, PIP will be used to install the AWS CLI.