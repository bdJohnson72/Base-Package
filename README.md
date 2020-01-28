#Base Package Description

This Package is  meant to be installed on all engagements and contains the following.

1. Custom Metadata Trigger Hander  
Extends the virutal trigger handler by overridingthe run method. Trigger Context and Trigger collections are inherited  
from the super class. The run method uses query to the the custom meta data type Trigger_Handlers__mdt to get  
the names of classes that should be instantiated during different trigger contexts.  This allows packaging without  
creating multiple dependencies due to the location of triggers. 

2. Test Data Factory  
//TODO

3. Error Handling  
//TODO
