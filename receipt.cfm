<cfoutput>
<h1>receipt.cfm</h1>
<!---  Display the invoice ID and trans ID. --->  
<cfif isdefined('url.id')>
<strong>Invoice ID:</strong> #url.id#<br>
<strong>Transaction ID:</strong> #url.tid#<br>

<!---  Test to see if the transaction resulted in Approval, Decline or Error --->
<strong>Response Code:</strong> #url.ResponseCode#
<!---<cfif url.ResponseCode is "1">
  This transaction has been approved.
<cfelseif url.ResponseCode is "2">
  This transaction has been declined. 
<cfelseif url.ResponseCode is "3">
  There was an error processing this transaction.	
</cfif>--->
<br>

<!--- dump out the response text --->
<strong>Response Reason Text: </strong> #url.ResponseReasonText#<br>

<!---  Turn the AVS code into the corresponding text string. --->	
<cfif url.ResponseCode is "2" or  url.ResponseCode is "3">
<strong>AVS code:</strong>
<cfif url.AVS is "A">
	Address (Street) matches, ZIP does not.
<cfelseif url.AVS is "B">
	Address Information Not Provided for AVS Check.
<cfelseif url.AVS is "C">
	Street address and Postal Code not verified for international transaction due to incompatible formats. (Acquirer sent both street address and Postal Code.)
<cfelseif url.AVS is "D">
	International Transaction:  Street address and Postal Code match.
<cfelseif url.AVS is "E">
	AVS Error.
<cfelseif url.AVS is "G">
	Non U.S. Card Issuing Bank.
<cfelseif url.AVS is "N">
	No Match on Address (Street) or ZIP.
<cfelseif url.AVS is "P">
	AVS not applicable for this transaction.
<cfelseif url.AVS is "R">
	Retry. System unavailable or timed out.
<cfelseif url.AVS is "S">
	Service not supported by issuer.
<cfelseif url.AVS is "U">
	Address information is unavailable.
<cfelseif url.AVS is "W">
	9 digit ZIP matches, Address (Street) does not.
<cfelseif url.AVS is "X">
	Address (Street) and 9 digit ZIP match.
<cfelseif url.AVS is "Y">
	Address (Street) and 5 digit ZIP match.
<cfelseif url.AVS is "Z">
	5 digit ZIP matches, Address (Street) does not.
<cfelse>
	The address verification system returned an unknown value.
</cfif>

</cfif>

</cfif>
</cfoutput>
