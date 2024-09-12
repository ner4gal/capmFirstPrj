namespace nergal;
using {nergal.commons as commons} from './commons';
using { cuid , managed ,temporal } from '@sap/cds/common';

context master {
     entity students : commons.Address {
      key ID : commons.guID;
      NAME : String(80);
      AGE : Integer;
      CLASS : Association to one standars;
      GENDER : String(1);
      CITY : String(80);
   };

   entity standars {
      key ID : commons.guID;
      CLASSNAME : String(80);
      SECTIONS : Int16;
      CLASSTEACHER : String(80);
   
   };

   entity  Books {
      key ID : commons.guID;
      TITLE : String(80);
      AUTHOR : String(80);
      PRICE : Decimal(10,2);
      PUBLISHER : String(80);
   };

}
context trans {

    
      entity rantals : cuid,temporal,managed {
      students : Association to master.students;
      Books : Association to master.Books;
   }
   
}
 
  