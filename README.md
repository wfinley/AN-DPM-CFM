AN-DPM-CFM
==========

Authorize.net Direct Payment Method (DPM) for Cold Fusion

This is a rewrite of the CF_SIM sample code that Authorize.net distributes for integration of the SIM method.
This method utilizes the code used in the sample code but inserts the hidden fields that allows the payment 
to be passed as DPM.

To test the code, setup a test acccount at https://test.authorize.net/, edit vars.cfm with your variables 
and then point your browser to http://YOUR-DOMAIN-NAME/paymentform.cfm

Note that this code also used hmac.cfm and md5.cfm that are distributed in the Authorize.net sample code.  
The sample files can be downloaded here: http://developer.authorize.net/resources/files/samplecode/cf_sim.zip


