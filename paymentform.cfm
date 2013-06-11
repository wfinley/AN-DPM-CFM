<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
  "http://www.w3.org/TR/html4/loose.dtd">
<HTML lang='en'>
<HEAD>
  <TITLE> DPM Implementation </TITLE>
	
	<style>
        fieldset {
            overflow: auto;
            border: 0;
            margin: 0;
            padding: 0; }

        fieldset div {
            float: left; 
             margin: 5px;}

        fieldset.centered div {
            text-align: center; }

        label {
            color: #183b55;
            display: block;
            margin: 5px; }

        label img {
            display: block;
            margin-bottom: 5px; }

        input.text {
            border: 1px solid #bfbab4;
            margin: 0 4px 8px 0;
            padding: 6px;
            color: #1e1e1e;
            -webkit-border-radius: 5px;
            -moz-border-radius: 5px;
            border-radius: 5px;
            -webkit-box-shadow: inset 0px 5px 5px #eee;
            -moz-box-shadow: inset 0px 5px 5px #eee;
            box-shadow: inset 0px 5px 5px #eee; }
        .submit {
            display: block;
            background-color: #76b2d7;
            border: 1px solid #766056;
            color: #3a2014;
            margin: 13px 0;
            padding: 8px 16px;
            -webkit-border-radius: 12px;
            -moz-border-radius: 12px;
            border-radius: 12px;
            font-size: 14px;
            -webkit-box-shadow: inset 3px -3px 3px rgba(0,0,0,.5), inset 0 3px 3px rgba(255,255,255,.5), inset -3px 0 3px rgba(255,255,255,.75);
            -moz-box-shadow: inset 3px -3px 3px rgba(0,0,0,.5), inset 0 3px 3px rgba(255,255,255,.5), inset -3px 0 3px rgba(255,255,255,.75);
            box-shadow: inset 3px -3px 3px rgba(0,0,0,.5), inset 0 3px 3px rgba(255,255,255,.5), inset -3px 0 3px rgba(255,255,255,.75); }
        </style>
        
</HEAD>
<BODY>
<h1>paymentform.cfm</h1>
<cfoutput>
<cfinclude template="vars.cfm">

<!--- the parameters for the payment can be configured here / the API Login ID and Transaction Key must be replaced with valid values --->
<cfset amount="5.00">

<!--- If an amount or description were posted to this page, the defaults are overidden --->
<cfif IsDefined("FORM.amount")>
  <cfset amount=FORM.amount>
</cfif>
<cfif IsDefined("FORM.description")>
  <cfset description=FORM.description>
</cfif>
<!--- also check to see if the amount or description were sent using the GET method --->
<cfif IsDefined("URL.amount")>
  <cfset amount=URL.amount>
</cfif>
<cfif IsDefined("URL.description")>
  <cfset description=URL.description>
</cfif>

<!--- an invoice is generated using the date and time --->
<cfset invoice=DateFormat(Now(),"yyyymmdd") & TimeFormat(Now(),"HHmmss")>

<!--- a sequence number is randomly generated --->
<cfset sequence=RandRange(1, 1000)>

<!--- a timestamp is generated --->
<cfset timestamp=DateDiff("s", "January 1 1970 00:00", DateConvert('local2UTC', Now())) >

<!--- The following lines generate the SIM fingerprint --->
<cf_hmac data="#loginID#^#sequence#^#timestamp#^#amount#^" key="#transactionKey#">
<cfset fingerprint=#digest#>

<!--- Print the Amount and Description to the screen.--->
<p><strong>Amount:</strong> #amount# </p>
<p><strong>Invoice:</strong> #invoice#  </p>

<hr>

<!--- Create the HTML form containing necessary SIM post values --->
<FORM method='post' action='#posturl#' >


<!--- passed to create timestamping option --->
<INPUT type='hidden' name='x_invoice_num' value='#invoice#' />
<INPUT type='hidden' name='x_fp_sequence' value='#sequence#' />
<INPUT type='hidden' name='x_fp_timestamp' value='#timestamp#' />
<INPUT type='hidden' name='x_fp_hash' value='#fingerprint#' />
	
<input type="hidden" name="x_amount" value="5.00">
<input type="hidden" name="x_delim_data" value="TRUE">
<input type="hidden" name="x_login" value="#loginID#">
<input type="hidden" name="x_relay_response" value="TRUE">
<input type="hidden" name="x_relay_url" value="#relayurl#">
<input type="hidden" name="x_version" value="3.1">
<input type="hidden" name="x_delim_char" value=",">
<INPUT type='hidden' name='x_timestamp' value='#timestamp#' />
<INPUT type='hidden' name='x_sequence' value='#sequence#' />
<INPUT type='hidden' name='x_duplicate_window' value='0' />

<!--- this is the payment form as grabbed from the DPM sample --->
	<fieldset>
                <div>
                    <label>Credit Card Number</label>
                    <input type="text" class="text" size="15" name="x_card_num" value="6011000000000012"></input>
                </div>
                <div>
                    <label>Exp.</label>
                    <input type="text" class="text" size="4" name="x_exp_date" value="04/17"></input>
                </div>
                <div>
                    <label>CCV</label>
                    <input type="text" class="text" size="4" name="x_card_code" value="782"></input>
                </div>
            </fieldset>
            <fieldset>
                <div>
                    <label>First Name</label>
                    <input type="text" class="text" size="15" name="x_first_name" value="John"></input>
                </div>
                <div>
                    <label>Last Name</label>
                    <input type="text" class="text" size="14" name="x_last_name" value="Doe"></input>
                </div>
            </fieldset>
            <fieldset>
                <div>
                    <label>Address</label>
                    <input type="text" class="text" size="26" name="x_address" value="123 Main Street"></input>
                </div>
                <div>
                    <label>City</label>
                    <input type="text" class="text" size="15" name="x_city" value="Boston"></input>
                </div>
            </fieldset>
            <fieldset>
                <div>
                    <label>State</label>
                    <input type="text" class="text" size="4" name="x_state" value="MA"></input>
                </div>
                <div>
                    <label>Zip Code</label>
                    <input type="text" class="text" size="9" name="x_zip" value="02142"></input>
                </div>
                <div>
                    <label>Country</label>
                    <input type="text" class="text" size="22" name="x_country" value="US"></input>
                </div>
            </fieldset>
            <input type="submit" value="BUY" class="submit buy">
           
</FORM>
</BODY>
</HTML>

</cfoutput>
