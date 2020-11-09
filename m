Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5205C388F7
	for <linux-rt-users@archiver.kernel.org>; Mon,  9 Nov 2020 14:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7609B206E3
	for <linux-rt-users@archiver.kernel.org>; Mon,  9 Nov 2020 14:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731070AbgKIOhI (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 9 Nov 2020 09:37:08 -0500
Received: from mail.monom.org ([188.138.9.77]:59508 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729976AbgKIOhI (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 9 Nov 2020 09:37:08 -0500
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 432BA500596;
        Mon,  9 Nov 2020 15:37:04 +0100 (CET)
Received: from localhost (unknown [94.31.100.251])
        by mail.monom.org (Postfix) with ESMTPSA id E263E500108;
        Mon,  9 Nov 2020 15:37:03 +0100 (CET)
Date:   Mon, 9 Nov 2020 15:37:03 +0100
From:   Daniel Wagner <wagi@monom.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.10-rc2-rt4
Message-ID: <20201109143703.ps7gxhqrirhntilr@beryllium.lan>
References: <20201103195731.erjkgyzxzzjylhui@linutronix.de>
 <20201104103809.bhl2iorbwv6xowtw@beryllium.lan>
 <20201104104617.ueefmpdou4t3t2ce@linutronix.de>
 <20201104111948.vpykh3ptmysqhmve@beryllium.lan>
 <20201104124746.74jdsig3dffomv3k@beryllium.lan>
 <20201104130930.llx56gtqt532h7c7@linutronix.de>
 <20201104160650.b63zqof74wohgpa2@beryllium.lan>
 <20201106105447.2lasulgjrbqdhnlh@linutronix.de>
 <20201106161413.7c65uxenamy474uh@beryllium.lan>
 <20201109124718.ljf7inok4zakkjed@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109124718.ljf7inok4zakkjed@linutronix.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, Nov 09, 2020 at 01:47:18PM +0100, Sebastian Andrzej Siewior wrote:
> So it is the new migrate-disable code? If you have stable 100us you
> should be able bisect it within the few commits between rt13 and rt14.

Okay, I'll start a bissect in this range.

> this looks odd. So rt1 has 415, rt2 has 399 and rt3 has 420 so lets say
> it is the same. And then rt4 should reduce it to 340. The only part that
> could have some influence is the are the highmem/kmap patches. But for
> ARM64 these are still a nop and in both cases kmap_atomic() disables
> migrate & page-fault.
> 
> Are you sure those numbers always reproducible and not something that
> goes wrong and sometimes it is captured at 300us and sometimes 400us.

These test run only very short with hackbench as worlkload (5 minutes).
Though I running these tests now for more than year with v4.4-rt and
some times the newer -rt releases and I've never seen the latency
numbers above 200us unless something was broken. Given that 5 minutes is
not really long, I'll let those test run for longer to see if I get the
same results when they run for one hour.

> I've been staring at the code of signaltest on Friday and I might need
> to stare longer to figure out what it does.

I hear you. Anyway, I gave the current head a run with lazy preemption
disabled as you asked for.

I had to add two ifdefs to get it compiling first:

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3fce6bbbeb5b..5a58ead3cf00 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1800,7 +1800,9 @@ void migrate_disable(void)
        preempt_disable();
        this_rq()->nr_pinned++;
        p->migration_disabled = 1;
+#ifdef CONFIG_PREEMPT_LAZY
        preempt_lazy_disable();
+#endif
        preempt_enable();
 }
 EXPORT_SYMBOL_GPL(migrate_disable);
@@ -1829,7 +1831,9 @@ void migrate_enable(void)
        barrier();
        p->migration_disabled = 0;
        this_rq()->nr_pinned--;
+#ifdef CONFIG_PREEMPT_LAZY
        preempt_lazy_enable();
+#endif
        preempt_enable();
 
        trace_sched_migrate_enable_tp(p);


5.10.0-rc2-rt4 vs 5.10.0-rc2-rt4(lazy preemption disabled)

  0_cyclicdeadline     t2-max-latency       pass/pass                274.00/     61.00     349.18%
  0_cyclicdeadline     t2-avg-latency       pass/pass                217.00/     19.00    1042.11%
  0_cyclicdeadline     t2-min-latency       pass/pass                 11.00/      1.00    1000.00%
  0_cyclicdeadline     t1-max-latency       pass/pass                113.00/    132.00     -14.39%
  0_cyclicdeadline     t1-avg-latency       pass/pass                 21.00/     24.00     -12.50%
  0_cyclicdeadline     t1-min-latency       pass/pass                  1.00/      1.00       0.00%
  0_cyclicdeadline     t0-max-latency       pass/pass                258.00/    110.00     134.55%
  0_cyclicdeadline     t0-avg-latency       pass/pass                140.00/     19.00     636.84%
  0_cyclicdeadline     t0-min-latency       pass/pass                  5.00/      1.00     400.00%
  0_cyclictest         t3-max-latency       pass/pass                 90.00/    118.00     -23.73%
  0_cyclictest         t3-avg-latency       pass/pass                 33.00/     30.00      10.00%
  0_cyclictest         t3-min-latency       pass/pass                 11.00/     11.00       0.00%
  0_cyclictest         t2-max-latency       pass/pass                 93.00/     96.00      -3.12%
  0_cyclictest         t2-avg-latency       pass/pass                 28.00/     29.00      -3.45%
  0_cyclictest         t2-min-latency       pass/pass                 11.00/     11.00       0.00%
  0_cyclictest         t1-max-latency       pass/pass                125.00/    138.00      -9.42%
  0_cyclictest         t1-avg-latency       pass/pass                 30.00/     29.00       3.45%
  0_cyclictest         t1-min-latency       pass/pass                 11.00/     11.00       0.00%
  0_cyclictest         t0-max-latency       pass/pass                 95.00/     97.00      -2.06%
  0_cyclictest         t0-avg-latency       pass/pass                 30.00/     30.00       0.00%
  0_cyclictest         t0-min-latency       pass/pass                 11.00/     11.00       0.00%
  0_pi-stress          pi-stress            fail/fail                  0.00/      0.00       0.00%
  0_pmqtest            t7-6-max-latency     pass/pass                 69.00/     76.00      -9.21%
  0_pmqtest            t7-6-avg-latency     pass/pass                 20.00/     19.00       5.26%
  0_pmqtest            t7-6-min-latency     pass/pass                 15.00/     14.00       7.14%
  0_pmqtest            t5-4-max-latency     pass/pass                 90.00/     95.00      -5.26%
  0_pmqtest            t5-4-avg-latency     pass/pass                 20.00/     19.00       5.26%
  0_pmqtest            t5-4-min-latency     pass/pass                 15.00/     14.00       7.14%
  0_pmqtest            t3-2-max-latency     pass/pass                 71.00/     74.00      -4.05%
  0_pmqtest            t3-2-avg-latency     pass/pass                 20.00/     18.00      11.11%
  0_pmqtest            t3-2-min-latency     pass/pass                 15.00/     14.00       7.14%
  0_pmqtest            t1-0-max-latency     pass/pass                113.00/    110.00       2.73%
  0_pmqtest            t1-0-avg-latency     pass/pass                 24.00/     22.00       9.09%
  0_pmqtest            t1-0-min-latency     pass/pass                 16.00/     14.00      14.29%
  0_ptsematest         t7-6-max-latency     pass/pass                 66.00/     67.00      -1.49%
  0_ptsematest         t7-6-avg-latency     pass/pass                 15.00/     15.00       0.00%
  0_ptsematest         t7-6-min-latency     pass/pass                 11.00/     11.00       0.00%
  0_ptsematest         t5-4-max-latency     pass/pass                 75.00/     67.00      11.94%
  0_ptsematest         t5-4-avg-latency     pass/pass                 15.00/     15.00       0.00%
  0_ptsematest         t5-4-min-latency     pass/pass                 11.00/     11.00       0.00%
  0_ptsematest         t3-2-max-latency     pass/pass                 68.00/     78.00     -12.82%
  0_ptsematest         t3-2-avg-latency     pass/pass                 15.00/     15.00       0.00%
  0_ptsematest         t3-2-min-latency     pass/pass                 11.00/     11.00       0.00%
  0_ptsematest         t1-0-max-latency     pass/pass                116.00/    106.00       9.43%
  0_ptsematest         t1-0-avg-latency     pass/pass                 17.00/     17.00       0.00%
  0_ptsematest         t1-0-min-latency     pass/pass                 11.00/     11.00       0.00%
  0_rt-migrate-test    t4-p55-avg           pass/pass                121.00/    127.00      -4.72%
  0_rt-migrate-test    t4-p55-tot           pass/pass               6076.00/   6369.00      -4.60%
  0_rt-migrate-test    t4-p55-min           pass/pass                 31.00/     28.00      10.71%
  0_rt-migrate-test    t4-p55-max           pass/pass                234.00/    230.00       1.74%
  0_rt-migrate-test    t3-p54-avg           pass/pass                121.00/    119.00       1.68%
  0_rt-migrate-test    t3-p54-tot           pass/pass               6082.00/   5968.00       1.91%
  0_rt-migrate-test    t3-p54-min           pass/pass                 33.00/     33.00       0.00%
  0_rt-migrate-test    t3-p54-max           pass/pass                262.00/    211.00      24.17%
  0_rt-migrate-test    t2-p53-avg           pass/pass                123.00/    126.00      -2.38%
  0_rt-migrate-test    t2-p53-tot           pass/pass               6161.00/   6302.00      -2.24%
  0_rt-migrate-test    t2-p53-min           pass/pass                 35.00/     34.00       2.94%
  0_rt-migrate-test    t2-p53-max           pass/pass                228.00/    204.00      11.76%
  0_rt-migrate-test    t1-p52-avg           pass/pass                159.00/    172.00      -7.56%
  0_rt-migrate-test    t1-p52-tot           pass/pass               7990.00/   8636.00      -7.48%
  0_rt-migrate-test    t1-p52-min           pass/pass                 40.00/     43.00      -6.98%
  0_rt-migrate-test    t1-p52-max           pass/pass                253.00/    273.00      -7.33%
  0_rt-migrate-test    t0-p51-avg           pass/pass               7374.00/   8583.00     -14.09%
  0_rt-migrate-test    t0-p51-tot           pass/pass             368726.00/ 429192.00     -14.09%
  0_rt-migrate-test    t0-p51-min           pass/pass                 59.00/     55.00       7.27%
  0_rt-migrate-test    t0-p51-max           pass/pass              20208.00/  20227.00      -0.09%
  0_signaltest         t0-max-latency       pass/pass                340.00/    385.00     -11.69%
  0_signaltest         t0-avg-latency       pass/pass                 53.00/     55.00      -3.64%
  0_signaltest         t0-min-latency       pass/pass                 24.00/     24.00       0.00%
  0_sigwaittest        t7-6-max-latency     pass/pass                347.00/    322.00       7.76%
  0_sigwaittest        t7-6-avg-latency     pass/pass                 27.00/     26.00       3.85%
  0_sigwaittest        t7-6-min-latency     pass/pass                 17.00/     17.00       0.00%
  0_sigwaittest        t5-4-max-latency     pass/pass                248.00/    288.00     -13.89%
  0_sigwaittest        t5-4-avg-latency     pass/pass                 26.00/     25.00       4.00%
  0_sigwaittest        t5-4-min-latency     pass/pass                 17.00/     17.00       0.00%
  0_sigwaittest        t3-2-max-latency     pass/pass                197.00/    226.00     -12.83%
  0_sigwaittest        t3-2-avg-latency     pass/pass                 25.00/     24.00       4.17%
  0_sigwaittest        t3-2-min-latency     pass/pass                 18.00/     17.00       5.88%
  0_sigwaittest        t1-0-max-latency     pass/pass                179.00/    213.00     -15.96%
  0_sigwaittest        t1-0-avg-latency     pass/pass                 29.00/     28.00       3.57%
  0_sigwaittest        t1-0-min-latency     pass/pass                 18.00/     17.00       5.88%
  0_svsematest         t7-6-max-latency     pass/pass                 85.00/     76.00      11.84%
  0_svsematest         t7-6-avg-latency     pass/pass                 17.00/     16.00       6.25%
  0_svsematest         t7-6-min-latency     pass/pass                 13.00/     12.00       8.33%
  0_svsematest         t5-4-max-latency     pass/pass                 66.00/     70.00      -5.71%
  0_svsematest         t5-4-avg-latency     pass/pass                 17.00/     16.00       6.25%
  0_svsematest         t5-4-min-latency     pass/pass                 13.00/     12.00       8.33%
  0_svsematest         t3-2-max-latency     pass/pass                 99.00/     73.00      35.62%
  0_svsematest         t3-2-avg-latency     pass/pass                 17.00/     15.00      13.33%
  0_svsematest         t3-2-min-latency     pass/pass                 13.00/     12.00       8.33%
  0_svsematest         t1-0-max-latency     pass/pass                121.00/    127.00      -4.72%
  0_svsematest         t1-0-avg-latency     pass/pass                 19.00/     18.00       5.56%
  0_svsematest         t1-0-min-latency     pass/pass                 13.00/     12.00       8.33%


cyclicdeadline seems heavily affected by the change.
