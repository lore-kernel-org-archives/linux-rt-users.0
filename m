Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA036C433ED
	for <linux-rt-users@archiver.kernel.org>; Fri, 16 Apr 2021 04:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D76D6113B
	for <linux-rt-users@archiver.kernel.org>; Fri, 16 Apr 2021 04:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237288AbhDPE6b (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 16 Apr 2021 00:58:31 -0400
Received: from ptr.189.cn ([183.61.185.103]:11423 "EHLO 189.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229555AbhDPE6a (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 16 Apr 2021 00:58:30 -0400
HMM_SOURCE_IP: 10.64.8.31:18705.380823691
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-14.215.91.1 (unknown [10.64.8.31])
        by 189.cn (HERMES) with SMTP id 9DB16101C25;
        Fri, 16 Apr 2021 12:57:48 +0800 (CST)
Received: from  ([172.27.8.53])
        by gateway-151646-dep-84df4bfd9c-c55qc with ESMTP id 778ad9260a3d4fc2ac2e7d0a48db4b6f for john.garry@huawei.com;
        Fri Apr 16 12:57:49 2021
X-Transaction-ID: 778ad9260a3d4fc2ac2e7d0a48db4b6f
X-filter-score: 
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 172.27.8.53
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
Subject: Re: [PATCH] kernel:irq:manage: request threaded irq with a specified
 priority
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, keescook@chromium.org,
        gregkh@linuxfoundation.org, maz@kernel.org, joe@perches.com,
        romain.perier@gmail.com, john.garry@huawei.com
References: <1618294774-24370-1-git-send-email-chensong_2000@189.cn>
 <875z0qzigk.ffs@nanos.tec.linutronix.de>
From:   chensong <chensong_2000@189.cn>
Message-ID: <4a355b66-3803-586b-56c7-ce715b5e59cc@189.cn>
Date:   Fri, 16 Apr 2021 12:57:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <875z0qzigk.ffs@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On 2021/4/13 下午4:39, Thomas Gleixner wrote:
> On Tue, Apr 13 2021 at 14:19, Song Chen wrote:
>> In general, irq handler thread will be assigned a default priority which
>> is MAX_RT_PRIO/2, as a result, no one can preempt others.
>>
>> Here is the case I found in a real project, an interrupt int_a is
>> coming, wakes up its handler handler_a and handler_a wakes up a
>> userspace RT process task_a.
>>
>> However, if another irq handler handler_b which has nothing to do
>> with any RT tasks is running when int_a is coming, handler_a can't
>> preempt handler_b, as a result, task_a can't be waken up immediately
>> as expected until handler_b gives up cpu voluntarily. In this case,
>> determinism breaks.
> 
> It breaks because the system designer failed to assign proper priorities
> to the irq threads int_a, int_b and to the user space process task_a.

yes, it's designers' responsibility to assign proper priorities, but 
kernel is also obliged to provide interfaces for those designers.

chrt can help designers in this case, however, the truth is lot of 
customers are not familiar with it. what's more, chrt can also apply to 
userspace rt task, but userspace also has sched_setscheduler to assgin 
proper priority inside code like cyclictest, why can't driver writers 
have another choice?

Further, what if irq handlear thread has to run on the expected priority 
at the very beginning? This patch helps.

BR

Song

> 
> That's not solvable at the kernel level.
> 
> Thanks,
> 
>          tglx
> 
> 
