module.exports = cds.service.impl(async function() {

      const {POs} = this.entities

      this.on('boost',async(req) => {
        console.log('aa gaya');
        
        //start a db transaction 

        const tx = cds.tx(req);




      });

});