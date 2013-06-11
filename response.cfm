<!--- this is the response / relay page that Authroize.net sends to the merchant server.  This
page validates that the post is correct and if all is good it bounces to the receipt page. 
--->
<cfoutput>

<!--- step 1. include the variables --->
<cfinclude template="vars.cfm">

<!--- step 2. for testing; send the dumped form to yourself to check that it's setup correctly --->
<cfmail to = "#emailto#" from = "#emailfrom#" subject = "Authorize.net Transaction Dump"  type="html" server="#mailserver#"><cfdump var="#form#"></cfmail> 

<!--- step 3.  check to see if the post has been passed by checking for form.x_MD5_Hash --->
<cfif isdefined('form.x_MD5_Hash')>

<!--- step 4.  form has been posted  so we retrieve and define Form Data from Post command body from Authorize.Net --->
<cfset ResponseCode         = "#trim(x_response_code)#" >
<cfset ResponseReasonText   = "#trim(x_response_reason_text)#" >
<cfset ResponseReasonCode   = "#trim(x_response_reason_code)#" >
<cfset AVS                  = "#trim(x_avs_code)#" >
<cfset TransID              = "#trim(x_trans_id)#" >
<cfset AuthCode             = "#trim(x_auth_code)#" >
<cfset x_MD5_Hash           = "#trim(x_MD5_Hash)#" >
<cfset Amount               = "#trim(x_amount)#" >

<!--- step 5.  create a hash string using our md5, login, the passed transid and amount --->
<cfset hashstring = "#md5_setting##loginid##x_trans_id##Amount#">
<cfset serverhash = "#Hash(hashstring,"md5")#">


<!--- step 6.  check to see if the serverhash is the same as the  passed x_MD5_Hash --->
<cfif serverhash is x_MD5_Hash>
<!--- step 7. do your database processing here // i.e. update membership / mark receipt as PIF etc.. --->
<!--- Recommended you write the auth code and the transid code to the database for easy referencing.  Note that you'll have --->
<!--- to trap for ResponseCode.  i.e. if ResponseCode is 1 then the transaction was approived and you can proceed with marking as PIF etc.. Sample code included--->
<cfif ResponseCode is "1">
<!--- transaction was processed so do something --->
</cfif>

<!--- step 8. A snippet to send to AuthorizeNet to redirect the user back to the merchant's server. --->
<!--- Note that in this example the invoice ID is being passed.  This is so you can easily find the ID based on an URL variable. --->

<cfset redirect_url = "#receipturl#?id=#form.X_INVOICE_NUM#&tid=#form.X_TRANS_ID#&ResponseCode=#ResponseCode#&AVS=#avs#&ResponseReasonText=#ResponseReasonText#">
<html><head><script language="javascript">
   <!--
    window.location="#redirect_url#";
   //-->
   </script>
</head><body><noscript><meta http-equiv="refresh" content="1;url=#redirect_url#"></noscript></body></html>

<cfelse>
<!--- error checking: the server hash and the passed hash value don't match --->
Error -- not AuthorizeNet. Check your MD5 Setting.
</cfif>

<cfelse>
<!--- error checking: The form was not passed. --->
Error -- unable to process transaction.
</cfif>

</cfoutput>
