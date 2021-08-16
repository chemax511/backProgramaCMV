using Microsoft.EntityFrameworkCore;
using ProgramaCMV.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ProgramaCMV.Context
{
    public class AppDbContext :DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options)
        {

        }
        public DbSet<gestoresBD> TBL_CMV_CLIENTE { get; set; }

        public DbSet<gestoresCuentaBD> TBL_CMV_CLIENTE_CUENTA { get; set; }


    }
}
