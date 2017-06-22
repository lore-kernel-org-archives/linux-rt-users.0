From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 1/2] sched/debug: Inform the number of rt/dl task that
 can migrate
Date: Thu, 22 Jun 2017 11:29:34 +0200
Message-ID: <20170622092934.jokgiprvf5m7krdi@gmail.com>
References: <cover.1498068819.git.bristot@redhat.com>
 <9d7f19113ac410735707e0f179853100e9918c0d.1498068819.git.bristot@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
        "Luis Claudio R . Goncalves" <lgoncalv@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Daniel Bristot de Oliveira <bristot@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9d7f19113ac410735707e0f179853100e9918c0d.1498068819.git.bristot@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Daniel Bristot de Oliveira <bristot@redhat.com> wrote:

> Add the value of the rt_rq.rt_nr_migratory and dl_rq.dl_nr_migratory
> to the sched_debug output, for instance:
> 
> rt_rq[0]:
>   .rt_nr_running                 : 2
>   .rt_nr_migratory               : 1     <--- Like this
>   .rt_throttled                  : 0
>   .rt_time                       : 828.645877
>   .rt_runtime                    : 1000.000000
> 
> This is useful to debug problems related to the dl/rt schedulers.
> 
> This also fixes the format of some variables, that were unsigned, rather
> than signed.
> 
> [ I am sending this patch to be able to demonstrate       ]
> [ the problem in the kernel-rt, however, this patch can   ]
> [ be merged in the vanilla kernel, if people decide it    ]
> [ is worth having it.                                     ]

Note that this patch breaks in various cross-builds - here's the Alpha defconfig 
build:

/home/mingo/tip/kernel/sched/debug.c: In function 'print_rt_rq':
/home/mingo/tip/kernel/sched/debug.c:556:60: error: 'struct rt_rq' has no member 
named 'rt_nr_migratory'
  SEQ_printf(m, "  .%-30s: %lu\n", #x, (unsigned long)(rt_rq->x))
                                                            ^
/home/mingo/tip/kernel/sched/debug.c:33:17: note: in definition of macro 
'SEQ_printf'
   seq_printf(m, x);  \
...

Thanks,

	Ingo
