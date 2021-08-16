using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ProgramaCMV.Context;
using ProgramaCMV.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace ProgramaCMV.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class GestoresClienteController : ControllerBase
    {
        private readonly AppDbContext context;
        public GestoresClienteController(AppDbContext context)
        {
            this.context = context;

        }
        // GET: api/<GestoresClienteController>
        [HttpGet]
        public ActionResult Get()
        {

            try
            {
                return Ok(context.TBL_CMV_CLIENTE.ToList());
            }
            catch(Exception e)
            {
                return BadRequest(e.Message);
            }
            
        }

        // GET api/<GestoresClienteController>/5
        [HttpGet("{id}", Name ="GetGestor")]
        public ActionResult Get(int id)
        {
            try
            {
                var gestor = context.TBL_CMV_CLIENTE.FirstOrDefault(g => g.id_cliente == id);
                return Ok(gestor);
            }
            catch(Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        // POST api/<GestoresClienteController>
        [HttpPost]
        public ActionResult Post([FromBody] gestoresBD gestor)
        {
            try
            {
                gestor.fecha_alta = DateTime.UtcNow;
                context.TBL_CMV_CLIENTE.Add(gestor);
                context.SaveChanges();
                return CreatedAtRoute("GetGestor", new { id = gestor.id_cliente }, gestor);
            }
            catch(Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        // PUT api/<GestoresClienteController>/5
        [HttpPut("{id}")]
        public ActionResult Put(int id, [FromBody] gestoresBD gestor)
        {
            try
            {
                if (gestor.id_cliente == id)
                {
                    context.Entry(gestor).State = EntityState.Modified;
                    context.SaveChanges();
                    return CreatedAtRoute("GetGestor", new { id = gestor.id_cliente }, gestor);
                }
                else
                {
                    return BadRequest();
                }
             }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        // DELETE api/<GestoresClienteController>/5
        [HttpDelete("{id}")]
        public ActionResult Delete(int id)
        {
            try
            {
                var gestor = context.TBL_CMV_CLIENTE.FirstOrDefault(g => g.id_cliente == id);
                if(gestor != null)
                {
                    context.TBL_CMV_CLIENTE.Remove(gestor);
                    context.SaveChanges();

                    return Ok(id);
                }
                else
                {
                    return BadRequest();
                }

            }catch(Exception e)

            {
                return BadRequest(e.Message);
            }
        }
    }
}
