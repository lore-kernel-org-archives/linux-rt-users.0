From: john stultz <johnstul@us.ibm.com>
Subject: Re: [ANNOUNCE] 2.6.31-rc6-rt2
Date: Tue, 18 Aug 2009 15:31:20 -0700
Message-ID: <1f1b08da0908181531v77a2ebc2m53a20512f5266334@mail.gmail.com>
References: <alpine.LFD.2.00.0902112332370.415@localhost.localdomain>
	 <alpine.LFD.2.00.0905221459030.3570@localhost.localdomain>
	 <alpine.LFD.2.00.0906101803210.3367@localhost.localdomain>
	 <alpine.LFD.2.00.0906121800590.3369@localhost.localdomain>
	 <alpine.LFD.2.00.0906151117440.2800@localhost.localdomain>
	 <alpine.LFD.2.00.0906170903370.2800@localhost.localdomain>
	 <alpine.LFD.2.00.0906231418500.2767@localhost.localdomain>
	 <alpine.LFD.2.00.0907092020410.2768@localhost.localdomain>
	 <alpine.LFD.2.00.0907300006250.2936@localhost.localdomain>
	 <alpine.LFD.2.00.0908162207370.2782@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Carsten Emde <ce@ceag.ch>,
	Clark Williams <williams@redhat.com>,
	Frank Rowand <frank.rowand@am.sony.com>,
	Robin Gareus <robin@gareus.org>,
	Gregory Haskins <ghaskins@novell.com>,
	Philippe Reynes <philippe.reynes@isismpp.fr>,
	Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>,
	Will Schmidt <will_schmidt@vnet.ibm.com>,
	Darren Hart <dvhltc@us.ibm.com>, Jan Blunck <jblunck@suse.de>,
	Sven-Thorsten Dietrich <sdietrich@novell.com>,
	Jon Masters <jcm@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-px0-f196.google.com ([209.85.216.196]:49479 "EHLO
	mail-px0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896AbZHRWbT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 18 Aug 2009 18:31:19 -0400
In-Reply-To: <alpine.LFD.2.00.0908162207370.2782@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, Aug 16, 2009 at 1:41 PM, Thomas Gleixner<tglx@linutronix.de> wr=
ote:
> We are pleased to announce the next update to our new preempt-rt
> series.
>
> =A0 =A0- update to 2.6.31-rc6
>

I'm seeing some bad scheduler behavior with this patch. I've seen
occasional bad behavior with 2.6.29-rt as well, but with .31-rt its
much worse.

I'm running a SCHED_OTHER cpubound benchmark  (censored to
xxxxxxxxxxxxx in the logs) that runs for a number of minutes. With
2.6.31-rc6 I'm seeing really poor numbers and if I cat
/proc/sched_debug I see all of the cpu bound tasks are  running on the
same cpu, while the other procs are basically idle. See the log below:

Any thoughts on how to debug this?

thanks
-john


Sched Debug Version: v0.09, 2.6.31-rc6-rt2 #2
now at 1293360.710541 msecs
  .jiffies                                 : 4295960656
  .sysctl_sched_latency                    : 60.000000
  .sysctl_sched_min_granularity            : 12.000000
  .sysctl_sched_wakeup_granularity         : 15.000000
  .sysctl_sched_child_runs_first           : 0.000001
  .sysctl_sched_features                   : 113917

cpu#0, 2193.531 MHz
  .nr_running                    : 4
  .load                          : 4096
  .nr_switches                   : 4053338
  .nr_load_updates               : 1293349
  .nr_uninterruptible            : 43
  .next_balance                  : 4295.960682
  .curr->pid                     : 3515
  .clock                         : 1293360.013589
  .cpu_load[0]                   : 181618
  .cpu_load[1]                   : 181618
  .cpu_load[2]                   : 181618
  .cpu_load[3]                   : 181618
  .cpu_load[4]                   : 181618
  .rt.rt_nr_running              : 0
  .rt.rt_nr_uninterruptible      : -2
  .rto_schedule                  : 1302873
  .rto_schedule_tail             : 0
  .rto_wakeup                    : 0
  .rto_pulled                    : 0
  .rto_pushed                    : 0
  .yld_count                     : 1
  .sched_switch                  : 0
  .sched_count                   : 8418031
  .sched_goidle                  : 731106
  .ttwu_count                    : 2747402
  .ttwu_local                    : 2742052
  .bkl_count                     : 543

cfs_rq[0]:
  .exec_clock                    : 567085.631142
  .MIN_vruntime                  : 852341.508897
  .min_vruntime                  : 852341.017669
  .max_vruntime                  : 852341.709960
  .spread                        : 0.201063
  .spread0                       : 0.000000
  .nr_running                    : 4
  .load                          : 4096
  .nr_spread_over                : 0

rt_rq[0]:
  .rt_nr_running                 : 0
  .rt_throttled                  : 0
  .rt_time                       : 0.887671
  .rt_runtime                    : 950.000000

runnable tasks:
            task   PID         tree-key  switches  prio
exec-runtime         sum-exec        sum-sleep
-----------------------------------------------------------------------=
-----------------------------------
 xxxxxxxxxxxxx.g  3512    852341.508897    138832   120
852341.508897    135653.402650       434.695150
 xxxxxxxxxxxxx.g  3513    852341.709960    138782   120
852341.709960    135605.356113       182.677943
 xxxxxxxxxxxxx.g  3514    852341.654901    138935   120
852341.654901    135610.255788       237.499811
Rxxxxxxxxxxxxx.g  3515    852341.017669    138914   120
852341.017669    135610.205043       229.113644

cpu#1, 2193.531 MHz
  .nr_running                    : 1
  .load                          : 1024
  .nr_switches                   : 2971216
  .nr_load_updates               : 1292739
  .nr_uninterruptible            : 3
  .next_balance                  : 4295.960659
  .curr->pid                     : 3555
  .clock                         : 1293360.140904
  .cpu_load[0]                   : 356068
  .cpu_load[1]                   : 266796
  .cpu_load[2]                   : 222179
  .cpu_load[3]                   : 199897
  .cpu_load[4]                   : 188742
  .rt.rt_nr_running              : 0
  .rt.rt_nr_uninterruptible      : -2
  .rto_schedule                  : 1308223
  .rto_schedule_tail             : 0
  .rto_wakeup                    : 0
  .rto_pulled                    : 0
  .rto_pushed                    : 0
  .yld_count                     : 0
  .sched_switch                  : 0
  .sched_count                   : 2971729
  .sched_goidle                  : 1288705
  .ttwu_count                    : 1658086
  .ttwu_local                    : 1650416
  .bkl_count                     : 652

cfs_rq[1]:
  .exec_clock                    : 13844.952496
  .MIN_vruntime                  : 0.000001
  .min_vruntime                  : 53350.708275
  .max_vruntime                  : 0.000001
  .spread                        : 0.000000
  .spread0                       : -798990.309394
  .nr_running                    : 1
  .load                          : 1024
  .nr_spread_over                : 6

rt_rq[1]:
  .rt_nr_running                 : 0
  .rt_throttled                  : 0
  .rt_time                       : 0.521663
  .rt_runtime                    : 950.000000

runnable tasks:
            task   PID         tree-key  switches  prio
exec-runtime         sum-exec        sum-sleep
-----------------------------------------------------------------------=
-----------------------------------
R            cat  3555     53321.260707         6   120
53321.260707         0.652065        10.616066

cpu#2, 2193.531 MHz
  .nr_running                    : 0
  .load                          : 0
  .nr_switches                   : 2925158
  .nr_load_updates               : 1292419
  .nr_uninterruptible            : -23
  .next_balance                  : 4295.960659
  .curr->pid                     : 0
  .clock                         : 1293360.258470
  .cpu_load[0]                   : 177522
  .cpu_load[1]                   : 177522
  .cpu_load[2]                   : 177522
  .cpu_load[3]                   : 177522
  .cpu_load[4]                   : 177522
  .rt.rt_nr_running              : 0
  .rt.rt_nr_uninterruptible      : -2
  .rto_schedule                  : 1295099
  .rto_schedule_tail             : 0
  .rto_wakeup                    : 0
  .rto_pulled                    : 0
  .rto_pushed                    : 0
  .yld_count                     : 0
  .sched_switch                  : 0
  .sched_count                   : 2925161
  .sched_goidle                  : 1293820
  .ttwu_count                    : 1630779
  .ttwu_local                    : 1630221
  .bkl_count                     : 0

cfs_rq[2]:
  .exec_clock                    : 53.516855
  .MIN_vruntime                  : 0.000001
  .min_vruntime                  : 102.147228
  .max_vruntime                  : 0.000001
  .spread                        : 0.000000
  .spread0                       : -852238.870441
  .nr_running                    : 0
  .load                          : 0
  .nr_spread_over                : 0

rt_rq[2]:
  .rt_nr_running                 : 0
  .rt_throttled                  : 0
  .rt_time                       : 0.374001
  .rt_runtime                    : 950.000000

runnable tasks:
            task   PID         tree-key  switches  prio
exec-runtime         sum-exec        sum-sleep
-----------------------------------------------------------------------=
-----------------------------------

cpu#3, 2193.531 MHz
  .nr_running                    : 0
  .load                          : 0
  .nr_switches                   : 2924897
  .nr_load_updates               : 1292090
  .nr_uninterruptible            : -23
  .next_balance                  : 4295.960659
  .curr->pid                     : 0
  .clock                         : 1293360.383163
  .cpu_load[0]                   : 177522
  .cpu_load[1]                   : 177522
  .cpu_load[2]                   : 177522
  .cpu_load[3]                   : 177522
  .cpu_load[4]                   : 177522
  .rt.rt_nr_running              : 0
  .rt.rt_nr_uninterruptible      : -2
  .rto_schedule                  : 1294829
  .rto_schedule_tail             : 0
  .rto_wakeup                    : 0
  .rto_pulled                    : 0
  .rto_pushed                    : 0
  .yld_count                     : 0
  .sched_switch                  : 0
  .sched_count                   : 2924899
  .sched_goidle                  : 1293542
  .ttwu_count                    : 1630794
  .ttwu_local                    : 1630705
  .bkl_count                     : 0

cfs_rq[3]:
  .exec_clock                    : 60.101923
  .MIN_vruntime                  : 0.000001
  .min_vruntime                  : 382.606699
  .max_vruntime                  : 0.000001
  .spread                        : 0.000000
  .spread0                       : -851958.410970
  .nr_running                    : 0
  .load                          : 0
  .nr_spread_over                : 0

rt_rq[3]:
  .rt_nr_running                 : 0
  .rt_throttled                  : 0
  .rt_time                       : 0.365285
  .rt_runtime                    : 950.000000

runnable tasks:
            task   PID         tree-key  switches  prio
exec-runtime         sum-exec        sum-sleep
-----------------------------------------------------------------------=
-----------------------------------
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
