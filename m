Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE53C433DB
	for <linux-rt-users@archiver.kernel.org>; Thu, 28 Jan 2021 09:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3F9164DDA
	for <linux-rt-users@archiver.kernel.org>; Thu, 28 Jan 2021 09:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbhA1JH7 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 28 Jan 2021 04:07:59 -0500
Received: from ptr.189.cn ([183.61.185.102]:12643 "EHLO 189.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231984AbhA1JG6 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 28 Jan 2021 04:06:58 -0500
HMM_SOURCE_IP: 10.64.10.45:54476.1160266308
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-123.150.8.42 (unknown [10.64.10.45])
        by 189.cn (HERMES) with SMTP id 9ECF21006EF
        for <linux-rt-users@vger.kernel.org>; Thu, 28 Jan 2021 17:04:03 +0800 (CST)
Received: from  ([10.64.8.34])
        by gateway-151646-dep-54888d799-vh9dt with ESMTP id d24062c369f64773a4bc178d0a6c0a14 for linux-rt-users@vger.kernel.org;
        Thu Jan 28 17:04:03 2021
X-Transaction-ID: d24062c369f64773a4bc178d0a6c0a14
X-filter-score: 
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 10.64.8.34
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
From:   "chensong_2000@189.cn" <chensong_2000@189.cn>
Subject: preempt_disable causes big latency
Message-ID: <4fddc141-d24d-f63f-5c81-cfbfb08af442@189.cn>
Date:   Thu, 28 Jan 2021 17:04:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


Dear experts,

When i was running cyclictest with ltp(kernel 4.19.90 rt, arch64), 
cyclictest got a big latecy(more than 10ms), the ftrace log shows that 
modprobe called preempt_disable for a long time, which stops cyclictest 
being switched.

here is a piece of log:

modprobe-4551    0...10   712.754529: preempt_disable: 
caller=0xffff0001019900c8 parent=0xffff0001019900c8
...
modprobe-4551    0d..10   712.754589: irq_disable: caller=el1_irq+0x7c 
parent=0xffff0001019900dc
modprobe-4551    0d.h10   712.754590: irq_handler_entry:    irq=2 
name=arch_timer
modprobe-4551    0d.h20   712.754591: hrtimer_cancel: 
hrtimer=0xffff8020f4983d98
modprobe-4551    0d.h10   712.754591: hrtimer_expire_entry: 
hrtimer=0xffff8020f4983d98 now=712720218245 function=hrtimer_wakeup/0x0
modprobe-4551    0d.h20   712.754592: sched_waking: comm=cyclictest 
pid=2212 prio=9 target_cpu=000
modprobe-4551    0dNh30   712.754593: sched_wakeup: cyclictest:2212 [9] 
success=1 CPU:000
modprobe-4551    0dNh10   712.754594: hrtimer_expire_exit: 
hrtimer=0xffff8020f4983d98
modprobe-4551    0dNh10   712.754594: irq_handler_exit:     irq=2 
ret=handled

Further i found 
preemptirq_delay_test(kernel/trace/preemptirq_delay_test.c) can 
reproduce it easily and got the similar ftrace log.

The root cause i found is in el1_irq, it checks preempt count and 
TIF_NEED_RESCHED before it goes through the path el1_preempt, 
preempt_disable just stops it happening.

Then i came up an idea and did an experiment,  call 
preempt_count_set(0); and set_tsk_need_resched(task); in hrtimer_wakeup 
to meet the expectation in order to reschdule.

static enum hrtimer_restart hrtimer_wakeup(struct hrtimer *timer)
{
     struct hrtimer_sleeper *t =
         container_of(timer, struct hrtimer_sleeper, timer);
     struct task_struct *task = t->task;

     t->task = NULL;
     if (task)
         wake_up_process(task);

     if(preempt_count())
         preempt_count_set(0);
     set_tsk_need_resched(task);

     return HRTIMER_NORESTART;
}

but, failed, system froze, no panic information.

Is there anyone having the same problem? i would appreciate it if you 
could share me some information in this case, many thanks.

BR

Song Chen



