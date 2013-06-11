<!--- Authorize.net API login --->
<cfset loginID="API_LOGIN_ID">

<!--- Authorize.net transaction key --->
<cfset transactionKey="TRANSACTION_KEY">

<!--- Authorize.net MD5setting --->
<cfset md5_setting = "MD5_KEY">

<!--- Authorize.net test mode --->
<cfset testMode="false">

<!--- By default, this sample code is designed to post to Authorize.net test server for developer accounts: https://test.authorize.net/gateway/transact.dll 
For real accounts (even in test mode), please make sure that you are posting to: https://secure.authorize.net/gateway/transact.dll --->
<cfset posturl="https://test.authorize.net/gateway/transact.dll">

<!--- this is the url where your response lives.  Make sure that you enable this as a valid response in the Authorize.net Settings / Response/Receipt URLs  --->
<cfset relayurl="https://YOUR_DOMAIN_NAME/response.cfm">

<!--- this is the url where your receipt lives.   --->
<cfset receipturl="https://YOUR_DOMAIN_NAME/receipt.cfm">

<!--- vars for cfmail test email on response page --->
<cfset emailto="YOUR_TO_EMAIL">
<cfset emailfrom="YOUR_FROM_EMAIL">
<cfset mailserver="YOUR_MAILSERVER">

