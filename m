From: Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 1/2] sched/debug: Inform the number of rt/dl task that can
 migrate
Date: Thu, 22 Jun 2017 15:02:30 +0200
Message-ID: <ce253162-3a0d-863c-17a9-e6f5511ee91e@redhat.com>
References: <cover.1498068819.git.bristot@redhat.com>
 <9d7f19113ac410735707e0f179853100e9918c0d.1498068819.git.bristot@redhat.com>
 <20170622092934.jokgiprvf5m7krdi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
        "Luis Claudio R . Goncalves" <lgoncalv@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170622092934.jokgiprvf5m7krdi@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 06/22/2017 11:29 AM, Ingo Molnar wrote:
> Note that this patch breaks in various cross-builds - here's the Alpha defconfig 
> build:
> 
> /home/mingo/tip/kernel/sched/debug.c: In function 'print_rt_rq':
> /home/mingo/tip/kernel/sched/debug.c:556:60: error: 'struct rt_rq' has no member 
> named 'rt_nr_migratory'
>   SEQ_printf(m, "  .%-30s: %lu\n", #x, (unsigned long)(rt_rq->x))
>                                                             ^
> /home/mingo/tip/kernel/sched/debug.c:33:17: note: in definition of macro 
> 'SEQ_printf'
>    seq_printf(m, x);  \
> ...

Oops...

The rt_nr_migratory is conditioned to:

#ifdef CONFIG_SMP

Sorry for the miss attention, I will fix this.

-- Daniel
