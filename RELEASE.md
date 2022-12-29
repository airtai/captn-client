# Release Notes

## 2022.11.0

Released on Nov 29, 2022

**captn-client changes:**

* Fix: Update prediction examples

## 2022.10.0

Released on Oct 29, 2022

**captn-client changes:**

* Feature: Integrate token route changes
* Fix: Include working examples in the docstrings of all methods

## 2022.9.0

Released on Sep 30, 2022

**captn-client changes:**

* Feature: Integrate to_datasource method and remove from_csv, from_parquet methods
* Feature: Integrate register and validate the phone number routes
* Feature: Integrate reset password route
* Feature: Integrate send SMS OTP route
* Feature: Integrate disable_mfa route changes
* Feature: Integrate cloud_provider changes
* Fix: Integrate user and apikey route changes

## 2022.8.0

Released on Aug 31, 2022

**captn-client changes:**

* Feature: Integrate single sign-on (SSO) changes
* Feature: Integrate UUID changes
* Feature: Integrate from_azure_blob_storage
* Fix: Use .uuid attribute instead of the .id attribute to access the unique id for the class instances

## 2022.7.0

Released on Aug 1, 2022

**captn-client changes:**

* Fix: Integrate user's info route changes
* Feature: Integrate OTP route changes
* Feature: Make sensitive CLI commands interactive if OTP is not passed as an argument for MFA enabled user
* Feature: Integrate region parameter
* Feature: Integrate single sign-on(SSO) authentication

## 2022.6.0

Released on June 1, 2022

**captn-client changes:**

* Feature: Integrate Multi-Factor authentication
* Feature: Integrate route to get user's info

## 2022.5.1

Released on June 1, 2022

**captn-client changes:**

* Fix: Update airt-client version in requirements

## 2022.5.0

Released on May 31, 2022

**captn-client changes:**

* Fix: Add source for DataBlobs created using the from_local method
* Fix: Return a dictionary instead of pandas series when calling the Client.version method
* Fix: Set proper dtypes to the dataframe in the datasource.head method

## 2022.4.0

Released on April 27, 2022

**captn-client changes:**

* Feature: Integrate prediction.to_clickhouse method
* Feature: Add set_token method to Client class
* Fix: Include index of datasource in datasource.head() method
* Feature: Integrate source property in DataBlob class

## 2022.3.1

Released on April 13, 2022

**captn-client changes:**

* Fix: Integrate from_csv, from_parquet and from_clickhouse route parameter changes

## 2022.3.0

Released on April 6, 2022

**captn-client changes:**

* Feature: Introduce DataBlob Class to import files from multiple sources.
* Feature: Add from_local, from_s3, from_mysql and from_clickhouse methods to the DataBlob class for creating a new DataBlob.
* Feature: Add from_csv and from_parquet methods to create DataSource from a DataBlob.
* Feature: Add ls, as_df, delete, details and tag methods to the DataBlob and DataSource classes for managing the resources.
