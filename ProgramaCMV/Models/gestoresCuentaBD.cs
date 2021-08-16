using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace ProgramaCMV.Models
{
    public class gestoresCuentaBD
    {
        [Key]
        public int id_cliente_cuenta { get; set; }
        public int id_cliente { get; set; }
        public int id_cuenta { get; set; }
        public decimal saldo_actual { get; set; }
        public DateTime fecha_contratacion { get; set; }
        public DateTime fecha_ultimo_movimiento { get; set; }


    }
}
