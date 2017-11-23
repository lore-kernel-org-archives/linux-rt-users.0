From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT] Revert "memcontrol: Prevent scheduling while atomic
 in cgroup code"
Date: Thu, 23 Nov 2017 17:22:54 +0100
Message-ID: <20171123162254.GA32454@linutronix.de>
References: <20171122073119.31837a3f@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <efault@gmx.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171122073119.31837a3f@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2017-11-22 07:31:19 [-0500], Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> The commit "memcontrol: Prevent scheduling while atomic in cgroup code"
> fixed this issue:
> 
>        refill_stock()
>           get_cpu_var()
>           drain_stock()
>              res_counter_uncharge()
>                 res_counter_uncharge_until()
>                    spin_lock() <== boom
> 
> But commit 3e32cb2e0a12b ("mm: memcontrol: lockless page counters") replaced
> the calls to res_counter_uncharge() in drain_stock() to the lockless
> function page_counter_uncharge(). There is no more spin lock there and no
> more reason to have that local lock.

as per v4.9+ the reported issue should not have occur due to the
locallocks. I am not sure why those were not used in first place.

The loop in page_counter_uncharge() does not look like it would take
many iterations and in worst case we could have two invocations with
interrupts off. So okay, lets revert that.

That upstream commit appeared in v3.19 and the patch in question in
v3.18.7-rt2 and v3.18 seems still to be maintained. So I guess that
v3.18 would need the locallocks that we are about to remove here. I am
not sure if any earlier versions have the patch backported.

> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Sebastian
