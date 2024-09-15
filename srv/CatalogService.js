const { addRefToWhereIfNecessary } = require("@sap/cds/libx/odata/utils");

module.exports = cds.service.impl(async function() {

      const {POs} = this.entities;

      this.on('boost',async(req) => {
        console.log('aa gaya');
        
        //start a db transaction 
         try {
          const ID = req.params[0];
          const tx = cds.tx(req);

          //cds  qury languge - communicate to DB in agnostic maner 
  
          await tx.update(POs).with({
               GROSS_AMOUNT: {'+=':20000 }
          }).where(ID);
         }catch (error){
          return "Error"+ error.toString();
         }
       
      });

      this.on('largestOrder',async(req) => {
        console.log('aa gaya');
        
        //start a db transaction 
         try {
          //const ID = req.params[0];
          const tx = cds.tx(req);
          const recordData = tx.read(POs).orderBy({
            GROSS_AMOUNT: 'desc'
          }).limit(1);
          
         }catch (error){
          return "Error"+ error.toString();
         }
       
      });

});