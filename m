From: "Jaswinder Singh" <jaswinderlinuxrt@gmail.com>
Subject: [PATCH] Re: loadavg vs loadavgrt
Date: Sat, 22 Dec 2007 12:09:59 +0530
Message-ID: <1985e0f60712212239u2e265d56va02b4fa8161a138e@mail.gmail.com>
References: <1985e0f60712200235v61e78b99s646149e0d27f125b@mail.gmail.com>
	 <Pine.LNX.4.58.0712201147390.17621@gandalf.stny.rr.com>
	 <1985e0f60712202058h50e6cd74ne047ff85221a3e3b@mail.gmail.com>
	 <20071221125405.GE19965@unix.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Steven Rostedt" <rostedt@goodmis.org>,
	RT <linux-rt-users@vger.kernel.org>,
	"Ingo Molnar" <mingo@elte.hu>
To: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.185]:42216 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbXLVGkB (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 22 Dec 2007 01:40:01 -0500
Received: by rv-out-0910.google.com with SMTP id k20so699086rvb.1
        for <linux-rt-users@vger.kernel.org>; Fri, 21 Dec 2007 22:40:00 -0800 (PST)
In-Reply-To: <20071221125405.GE19965@unix.sh>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 12/21/07, Luis Claudio R. Goncalves <lclaudio@uudg.org> wrote:
> On Fri, Dec 21, 2007 at 10:28:39AM +0530, Jaswinder Singh wrote:
> | On Dec 20, 2007 10:19 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> | >
> | > So the numbers are bogus!
> | >
> |
> | Thanks, understood :)
> |
> | root@192.168.1.253:~# cat /proc/loadavg
> | 0.00 0.00 0.02 1/52 1159
> |
> | This seems loadavg is calculating average for non-RT tasks.
> |
> | I think loadavg should be loadavg(all RT Tasks) + loadavg(all non-RT
> | tasks) , it means loadavg should be all Tasks(RT + non-RT)  running on
> | the machine.
> |
> | In RT we introduced loadavgrt, but we changed the meaning of loadavg.
>
> In fact, we haven't changed the meaning at all. The question is that in
> some cases the calculation happens in sync with some kernel threads
> dispatch and that makes system load _artificially_ equal to the number of
> processors in the system. Have fun reading kernel/timer.c (calc_load()) and
> understanding the logic behind it. All the answers lie there...
>
> | Currently loadavgrt is correct it is trying to calculate average of RT
> tasks.
> | But currently loadavg is loadavgnonrt, it should be loadavg (for all
> Tasks)
> |

Here is the patch which fix this problem, now loadavg >= loadavgrt

With this patch, I am getting:
root@192.168.1.253:~# cat /proc/loadavg
0.99 0.82 0.42 1/46 1013
root@192.168.1.253:~# cat /proc/loadavgrt
0.99 0.82 0.42 0/46 1014
root@192.168.1.253:~#

diff -urN linux-2.6.23-rt3.org/kernel/timer.c linux-2.6.23-rt3/kernel/timer.c
--- linux-2.6.23-rt3.org/kernel/timer.c 2007-12-22 11:50:00.000000000 +0530
+++ linux-2.6.23-rt3/kernel/timer.c     2007-12-22 12:01:10.000000000 +0530
@@ -967,13 +967,17 @@
                active_rt_tasks = count_active_rt_tasks();
 #endif
                do {
-                       CALC_LOAD(avenrun[0], EXP_1, active_tasks);
-                       CALC_LOAD(avenrun[1], EXP_5, active_tasks);
-                       CALC_LOAD(avenrun[2], EXP_15, active_tasks);
 #ifdef CONFIG_PREEMPT_RT
+                       CALC_LOAD(avenrun[0], EXP_1, active_tasks +
active_rt_tasks);
+                       CALC_LOAD(avenrun[1], EXP_5, active_tasks +
active_rt_tasks);
+                       CALC_LOAD(avenrun[2], EXP_15, active_tasks +
active_rt_tasks);
                        CALC_LOAD(avenrun_rt[0], EXP_1, active_rt_tasks);
                        CALC_LOAD(avenrun_rt[1], EXP_5, active_rt_tasks);
                        CALC_LOAD(avenrun_rt[2], EXP_15, active_rt_tasks);
+#else
+                       CALC_LOAD(avenrun[0], EXP_1, active_tasks);
+                       CALC_LOAD(avenrun[1], EXP_5, active_tasks);
+                       CALC_LOAD(avenrun[2], EXP_15, active_tasks);
 #endif
                        count += LOAD_FREQ;


Thank you,

Jaswinder Singh.
