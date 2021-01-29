Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563A4C433DB
	for <linux-rt-users@archiver.kernel.org>; Fri, 29 Jan 2021 03:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 139B760235
	for <linux-rt-users@archiver.kernel.org>; Fri, 29 Jan 2021 03:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbhA2Dz5 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 28 Jan 2021 22:55:57 -0500
Received: from ptr.189.cn ([183.61.185.101]:10949 "EHLO 189.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229757AbhA2Dz5 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 28 Jan 2021 22:55:57 -0500
HMM_SOURCE_IP: 10.64.10.45:46820.1270063813
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-123.150.8.42 (unknown [10.64.10.45])
        by 189.cn (HERMES) with SMTP id 14B3C100996;
        Fri, 29 Jan 2021 11:52:46 +0800 (CST)
Received: from  ([10.64.8.34])
        by gateway-151646-dep-54888d799-vh9dt with ESMTP id e4eaa99d2f014bbfa9f8cb65cf5677cc for linux-rt-users@vger.kernel.org;
        Fri Jan 29 11:52:47 2021
X-Transaction-ID: e4eaa99d2f014bbfa9f8cb65cf5677cc
X-filter-score: 
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 10.64.8.34
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
Subject: Re: preempt_disable causes big latency
To:     Daniel Vacek <neelx.g@gmail.com>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>
References: <4fddc141-d24d-f63f-5c81-cfbfb08af442@189.cn>
 <CAA7rmPGYFV1k0XmxJ3QQYJB+xK2XWdP_eY8poEoo_G6cHNN9Jw@mail.gmail.com>
From:   "chensong_2000@189.cn" <chensong_2000@189.cn>
Message-ID: <884a3f62-29d0-8727-7cfc-2e548cfa3062@189.cn>
Date:   Fri, 29 Jan 2021 11:52:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAA7rmPGYFV1k0XmxJ3QQYJB+xK2XWdP_eY8poEoo_G6cHNN9Jw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Daniel,

Thanks a lot for your kind explanation and vivid metaphors, it helps me 
have better understanding about preempt rt with the docs linked below.

Like you said, Realtime system is a fragile beast, we have a lot of work 
ahead to make it more robust and have better fault-tolerant.

Thanks again and best regards,

Song

在 2021/1/28 下午7:30, Daniel Vacek 写道:
> Hi Song,
> 
> On Thu, Jan 28, 2021 at 10:12 AM chensong_2000@189.cn
> <chensong_2000@189.cn> wrote:
>> Dear experts,
>>
>> When i was running cyclictest with ltp(kernel 4.19.90 rt, arch64),
>> cyclictest got a big latecy(more than 10ms), the ftrace log shows that
>> modprobe called preempt_disable for a long time, which stops cyclictest
>> being switched.
> 
> This works as designed. Running a latency sensitive application has
> some inherent rules. You need to stick to that rules, otherwise
> excessive latencies are to be expected. The best documentation (I
> believe) you can find on
> https://wiki.linuxfoundation.org/realtime/start (ex.
> https://rt.wiki.kernel.org/).
> 
> In short, running modprobe (loading kernel modules in general) is not
> allowed. For a production system, you are supposed to set up the
> machine first (loading the modules during boot or before starting the
> application). The application itself is bound to allowed operations
> only, otherwise it has to expect blocking and unbounded latencies.
> 
>> here is a piece of log:
>>
>> modprobe-4551    0...10   712.754529: preempt_disable:
>> caller=0xffff0001019900c8 parent=0xffff0001019900c8
>> ...
>> modprobe-4551    0d..10   712.754589: irq_disable: caller=el1_irq+0x7c
>> parent=0xffff0001019900dc
>> modprobe-4551    0d.h10   712.754590: irq_handler_entry:    irq=2
>> name=arch_timer
>> modprobe-4551    0d.h20   712.754591: hrtimer_cancel:
>> hrtimer=0xffff8020f4983d98
>> modprobe-4551    0d.h10   712.754591: hrtimer_expire_entry:
>> hrtimer=0xffff8020f4983d98 now=712720218245 function=hrtimer_wakeup/0x0
>> modprobe-4551    0d.h20   712.754592: sched_waking: comm=cyclictest
>> pid=2212 prio=9 target_cpu=000
>> modprobe-4551    0dNh30   712.754593: sched_wakeup: cyclictest:2212 [9]
>> success=1 CPU:000
>> modprobe-4551    0dNh10   712.754594: hrtimer_expire_exit:
>> hrtimer=0xffff8020f4983d98
>> modprobe-4551    0dNh10   712.754594: irq_handler_exit:     irq=2
>> ret=handled
> 
> Again, this is perfectly valid.
> 
>> Further i found
>> preemptirq_delay_test(kernel/trace/preemptirq_delay_test.c) can
>> reproduce it easily and got the similar ftrace log.
> 
> You can find endless ways how to introduce latency to the system.
> That's why some operations are not allowed. For more details see the
> mentioned documentation. ^^
> 
>> The root cause i found is in el1_irq, it checks preempt count and
>> TIF_NEED_RESCHED before it goes through the path el1_preempt,
>> preempt_disable just stops it happening.
> 
> As it should.
> 
>> Then i came up an idea and did an experiment,  call
>> preempt_count_set(0); and set_tsk_need_resched(task); in hrtimer_wakeup
>> to meet the expectation in order to reschdule.
> 
> Sounds like demolishing the pillars of the bridge, yet still expecting
> it not to fall. This will break your system for sure.
> 
>> static enum hrtimer_restart hrtimer_wakeup(struct hrtimer *timer)
>> {
>>       struct hrtimer_sleeper *t =
>>           container_of(timer, struct hrtimer_sleeper, timer);
>>       struct task_struct *task = t->task;
>>
>>       t->task = NULL;
>>       if (task)
>>           wake_up_process(task);
>>
>>       if(preempt_count())
>>           preempt_count_set(0);
>>       set_tsk_need_resched(task);
>>
>>       return HRTIMER_NORESTART;
>> }
>>
>> but, failed, system froze, no panic information.
> 
> Not surprised.
> 
>> Is there anyone having the same problem? i would appreciate it if you
>> could share me some information in this case, many thanks.
> 
> Simply, no modprobe while running the cyclictest. The cyclictest is
> supposed to be running on a machine as if the machine was in
> production and definitely not tortured by arbitrary synthetic tests
> (unless the test simulates a real world scenario which actually can
> happen in production).
> Again, all the modules should be preloaded before running cyclictest
> or the production application.
> 
> Realtime system is a fragile beast and you have to handle it with special care.
> 
> Have a nice day,
> Daniel
> 
>> BR
>>
>> Song Chen
> 
