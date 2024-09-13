module.exports = (srv) => {

    srv.on('nergal' , req => `hello ${req.data.name}`);
    
}