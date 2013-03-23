From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RT LATENCY] 249 microsecond latency caused by slub's
 unfreeze_partials() code.
Date: Fri, 22 Mar 2013 23:51:13 -0400
Message-ID: <1364010673.6345.156.camel@gandalf.local.home>
References: <1363906545.6345.81.camel@gandalf.local.home>
	 <0000013d92c37ff3-5fb85400-bec1-4eda-8ba1-332566884c59-000000@email.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <clark@redhat.com>
To: Christoph Lameter <cl@linux.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0000013d92c37ff3-5fb85400-bec1-4eda-8ba1-332566884c59-000000@email.amazonses.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2013-03-22 at 15:41 +0000, Christoph Lameter wrote:

> The control is via the cpu_partial field in /sys/kernel/slab/<cache>/
> 
> There is also slabs_cpu_partial which gives a view as to how many objects
> are cached in each per cpu structure. Do a cat
> 
> /sys/kernel/*/slabs_cpu_partial to get a view of what the situation is.
> Any abnormally high numbers?
> 
> The default for the number of per cpu partial objects should be 30 or so.

I just triggered another latency:

hackbenc-31634   5d..31 103261.991668: sched_switch:         hackbench:31634 [120] D ==> hackbench:36093 [120]
hackbenc-36093   5d...0 103261.991670: funcgraph_entry:      ! 225.665 us |  unfreeze_partials();
hackbenc-36093   5d...0 103261.991897: funcgraph_entry:                   |  smp_apic_timer_interrupt() {
hackbenc-36093   5d.h10 103261.991897: hrtimer_expire_entry: hrtimer=0xffff881f5ca7fe88 now=103293011955940 function=hrtimer_wakeup/0x0
hackbenc-36093   5d.h30 103261.991898: sched_wakeup:         cyclictest:8946 [4] success=1 CPU:005
hackbenc-36093   5dN..0 103261.991901: funcgraph_exit:         3.589 us   |  }
hackbenc-36093   5d..30 103261.991902: sched_switch:         hackbench:36093 [120] R ==> cyclictest:8946 [4]

I did a: cat /sys/kernel/slab/*/slabs_cpu_partial > slab_partials

I uploaded it here:

http://rostedt.homelinux.com/private/slab_partials

See anything I should be worried about?

Thanks,

-- Steve
