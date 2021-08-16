using Microsoft.AspNetCore.Mvc;
using ProgramaCMV.Context;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace ProgramaCMV.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class GestorCuentaController : ControllerBase
    {
        private readonly AppDbContext context;
        public GestorCuentaController(AppDbContext context)
        {
            this.context = context;

        }

        // GET: api/<GestoresClienteController>
        [HttpGet]
        public ActionResult Get()
        {
            try
            {
                return Ok(context.TBL_CMV_CLIENTE_CUENTA.ToList());
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }

        }

        // GET api/<GestorCuentaController>/5
        [HttpGet("{id}", Name = "GetGestorC")]
        public ActionResult Get(int id)
        {
            try
            {
                var gestorCC = context.TBL_CMV_CLIENTE_CUENTA.FirstOrDefault(g => g.id_cliente_cuenta == id);
                return Ok(gestorCC);
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        /*

        // POST api/<GestorCuentaController>
        [HttpPost]
        public void Post([FromBody] string value)
        {
        }

        // PUT api/<GestorCuentaController>/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody] string value)
        {
        }

        // DELETE api/<GestorCuentaController>/5
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
        }
        */
    }
}
