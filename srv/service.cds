using { nergal.master as master , nergal.trans as trans } from '../db/demo';


service myService {
   
    entity students as projection on master.students ;
    
    entity standars as projection on master.standars ;
    
    entity Books as projection on master.Books ;
    
    entity rantals as projection on trans.rantals
}