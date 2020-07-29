package ar.edu.unq.bd2.tp.futbolrest;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import ar.edu.unq.bd2.tp.futbol.domain.Bandera;
import ar.edu.unq.bd2.tp.persistence.BanderaHome;

@Path("bandera")
public class BanderaService {

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    @Path("{equipo}")
    public Bandera getBandera(@PathParam("equipo") String equipo) {
       return BanderaHome.getInstance().find(equipo);
    }

    @PUT
    @Consumes(MediaType.APPLICATION_JSON)
    @Path("update")
    public void getBandera(Bandera bandera) {
        BanderaHome.getInstance().update(bandera);
    }

}
