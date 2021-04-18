Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D90C433B4
	for <linux-rt-users@archiver.kernel.org>; Sun, 18 Apr 2021 14:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C41E86121D
	for <linux-rt-users@archiver.kernel.org>; Sun, 18 Apr 2021 14:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbhDROkY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 18 Apr 2021 10:40:24 -0400
Received: from mta.189.cn ([121.14.53.140]:2984 "EHLO 189.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229446AbhDROkY (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 18 Apr 2021 10:40:24 -0400
X-Greylist: delayed 331 seconds by postgrey-1.27 at vger.kernel.org; Sun, 18 Apr 2021 10:40:23 EDT
HMM_SOURCE_IP: 10.64.8.43:62133.785399503
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-14.215.91.3 (unknown [10.64.8.43])
        by 189.cn (HERMES) with SMTP id 56EE1BEE6F;
        Sun, 18 Apr 2021 22:33:52 +0800 (CST)
Received: from  ([172.27.8.53])
        by gateway-151646-dep-84df4bfd9c-f7wst with ESMTP id a77c5bff261d4c33a3c6760c7ca68f8f for john.garry@huawei.com;
        Sun Apr 18 22:33:54 2021
X-Transaction-ID: a77c5bff261d4c33a3c6760c7ca68f8f
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
 <4a355b66-3803-586b-56c7-ce715b5e59cc@189.cn>
 <87fszqvbnu.ffs@nanos.tec.linutronix.de>
From:   chensong <chensong_2000@189.cn>
Message-ID: <ead00ef1-40f6-2c22-efea-63ab4752228f@189.cn>
Date:   Sun, 18 Apr 2021 22:33:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87fszqvbnu.ffs@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Daniel & tglx,

Points taken and thanks a lot for such detailed explanations.

BR

Song

On 2021/4/16 下午5:09, Thomas Gleixner wrote:
> On Fri, Apr 16 2021 at 12:57, chensong wrote:
>> On 2021/4/13 下午4:39, Thomas Gleixner wrote:
>>> It breaks because the system designer failed to assign proper priorities
>>> to the irq threads int_a, int_b and to the user space process task_a.
>>
>> yes, it's designers' responsibility to assign proper priorities, but
>> kernel is also obliged to provide interfaces for those designers.
> 
> The interface exists. sched_setscheduler(2)
> 
>> chrt can help designers in this case, however, the truth is lot of
>> customers are not familiar with it.
> 
> The truth is that real-time systems need to be carefully designed and
> parametrized. And that's only possible when _all_ of the system
> components and their constraints are known. Trying to solve it at the
> device driver level of a single device is impossible and a guarantee for
> fail.
> 
> If the customer does not know how to do it, then I really have to ask
> why he's trying to use a real-time system at all. There is no real-time
> system which magically tunes itself by pulling the overall system
> constraints out of thin air.
>   
>> what's more, chrt can also apply to userspace rt task, but userspace
>> also has sched_setscheduler to assgin proper priority inside code like
>> cyclictest, why can't driver writers have another choice?
> 
> There is a very simple reason: The driver writer cannot know about the
> requirements of the complete system which is composed of kernel, drivers
> and user space applications, unless the driver writer is fully aware of
> the overall system design and constraints.
> 
> How is that supposed to work on a general purpose kernel which is
> utilized for a gazillion of different use cases which all have different
> expectations?
> 
> It simply cannot work because default A will only work for usecase A and
> be completely wrong for all others.
> 
>> Further, what if irq handlear thread has to run on the expected priority
>> at the very beginning? This patch helps.
> 
> There is no such thing as the expected priority of an interrupt thread
> which can be applied upfront.
> 
> There are ~5400 instances of request*irq() in the kernel source and
> there is no way to make priority decisions for them which work for every
> RT system out there.
> 
> The kernel sets a default and the system designer, admin, user has to
> take care of tuning it to match the expectations and constraints of his
> particular application scenario.
> 
> The kernel provides an userspace interface to do that. That interface
> might be a bit awkward to use, but there are tools out there which help
> with that, and if at all we can think about providing a better and
> easier to use interface for this.
> 
> Trying to solve that at the kernel level is putting the cart before the
> horse.
> 
> Thanks,
> 
>          tglx
> 
