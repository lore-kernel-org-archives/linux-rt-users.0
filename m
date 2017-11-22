From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [BUG] 4.4.x-rt - memcg: refill_stock() use get_cpu_light() has
 data corruption issue
Date: Wed, 22 Nov 2017 06:59:55 -0500
Message-ID: <20171122065955.15ac5039@gandalf.local.home>
References: <05AA4EC5C6EC1D48BE2CDCFF3AE0B8A637F78A15@CNMAILEX04.lenovo.com>
        <20171121225002.0704d679@vmware.local.home>
        <1511329005.8762.0.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Haiyang HY1 Tan <tanhy1@lenovo.com>,
        "'bigeasy@linutronix.de'" <bigeasy@linutronix.de>,
        "'linux-rt-users@vger.kernel.org'" <linux-rt-users@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        Tong Tong3 Li <litong3@lenovo.com>,
        Feng Feng24 Liu <liufeng24@lenovo.com>,
        Jianqiang1 Lu <lujq1@lenovo.com>,
        Hongyong HY2 Zang <zanghy2@lenovo.com>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1511329005.8762.0.camel@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 22 Nov 2017 06:36:45 +0100
Mike Galbraith <efault@gmx.de> wrote:

> On Tue, 2017-11-21 at 22:50 -0500, Steven Rostedt wrote:
> > 
> > Does it work if you revert the patch?  
> 
> That would restore the gripe.  How about this..

Would it?

The gripe you report is:

       refill_stock()
          get_cpu_var()
          drain_stock()
             res_counter_uncharge()
                res_counter_uncharge_until()
                   spin_lock() <== boom


But commit 3e32cb2e0a1 ("mm: memcontrol: lockless page counters")
changed that code to this:

 static void drain_stock(struct memcg_stock_pcp *stock)
 {
        struct mem_cgroup *old = stock->cached;
 
        if (stock->nr_pages) {
-               unsigned long bytes = stock->nr_pages * PAGE_SIZE;
-
-               res_counter_uncharge(&old->res, bytes);
+               page_counter_uncharge(&old->memory, stock->nr_pages);
                if (do_swap_account)
-                       res_counter_uncharge(&old->memsw, bytes);
+                       page_counter_uncharge(&old->memsw, stock->nr_pages);
                stock->nr_pages = 0;
        }

Where we replaced res_counter_uncharge() which is this:

u64 res_counter_uncharge_until(struct res_counter *counter,
                               struct res_counter *top,
                               unsigned long val)
{
        unsigned long flags;
        struct res_counter *c;
        u64 ret = 0;

        local_irq_save(flags);
        for (c = counter; c != top; c = c->parent) {
                u64 r;
                spin_lock(&c->lock);
                r = res_counter_uncharge_locked(c, val);
                if (c == counter)
                        ret = r;
                spin_unlock(&c->lock);
        }
        local_irq_restore(flags);
        return ret;
}

u64 res_counter_uncharge(struct res_counter *counter, unsigned long val)
{
        return res_counter_uncharge_until(counter, NULL, val);
}

and has that spin lock, to this:

void page_counter_cancel(struct page_counter *counter, unsigned long nr_pages)
{
	long new;

	new = atomic_long_sub_return(nr_pages, &counter->count);
	/* More uncharges than charges? */
	WARN_ON_ONCE(new < 0);
}

void page_counter_uncharge(struct page_counter *counter, unsigned long nr_pages)
{
	struct page_counter *c;

	for (c = counter; c; c = c->parent)
		page_counter_cancel(c, nr_pages);
}

You see. No more spin lock to gripe about. No boom in your scenario.

-- Steve
