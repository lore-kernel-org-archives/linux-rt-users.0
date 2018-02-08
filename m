From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 11/20 v2] tracing: Add symbol type to function based
 events
Date: Thu, 8 Feb 2018 10:59:00 -0500
Message-ID: <20180208105900.71a8ee8c@gandalf.local.home>
References: <20180207202402.253089656@goodmis.org>
        <20180207202816.348135328@goodmis.org>
        <20180208112031.GB30958@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        linux-rt-users@vger.kernel.org, linux-trace-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
To: Jiri Olsa <jolsa@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180208112031.GB30958@krava>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 8 Feb 2018 12:20:31 +0100
Jiri Olsa <jolsa@redhat.com> wrote:

> > +Symbols (function names)
> > +========================
> > +
> > +To display kallsyms "%pS" type of output, use the special type "symbol".
> > +
> > +Again, using gdb to find the offset of the "func" field of struct work_struct
> > +
> > +(gdb) printf "%d\n", &((struct work_struct *)0)->func
> > +24  
> 
> you could also use Arnaldo's pahole for this, seems like less typing:
> 
>   $ pahole ./vmlinux -C work_struct
>   die__process_function: tag not supported (INVALID)!
>   struct work_struct {
>           atomic_long_t              data;                 /*     0     8 */
>           struct list_head           entry;                /*     8    16 */
>           work_func_t                func;                 /*    24     8 */
> 
> it's in 'dwarves' package

Nice, I'll have to document that:

 $ pahole ./vmlinux -C net_device |grep perm
        unsigned char              perm_addr[32];        /*   558    32 */


-- Steve
