﻿using Opal_Exe201.Data.Models;
using Opal_Exe201.Data.Repositories.GenericRepository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Opal_Exe201.Data.Repositories.SeedRepositories
{
    public class SeedRepository : GenericRepository<Seed>, ISeedRepository
    {
        public SeedRepository(OpalExeContext context) : base(context)
        {
        }
    }
}