Return-Path: <SRS0=+P7g=VA=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58E7C0650E
	for <linux-rt-users@archiver.kernel.org>; Wed,  3 Jul 2019 11:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94E51218A3
	for <linux-rt-users@archiver.kernel.org>; Wed,  3 Jul 2019 11:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfGCLm7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 3 Jul 2019 07:42:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51920 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfGCLm7 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 3 Jul 2019 07:42:59 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hidf7-0003cd-5X; Wed, 03 Jul 2019 13:42:57 +0200
Date:   Wed, 3 Jul 2019 13:42:57 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "xiaoqiang.zhao" <zhaoxiaoqiang007@gmail.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: schdule bug in 4.4.38-rt49
Message-ID: <20190703114256.3b52kbrududxq7vz@linutronix.de>
References: <55c68f08-4160-4bee-fdc5-9fc1ea86cf57@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <55c68f08-4160-4bee-fdc5-9fc1ea86cf57@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-06-26 15:35:04 [+0800], xiaoqiang.zhao wrote:
> Hi, guys:
Hi,

>     I have built a kernel 4.4.38-rt49 with CONFIG_PREEMPT_RT_FULL=y , the
> kernel crash when I run the UnixBench of spawn test case.

Can you forward to something newer, 4.4.179-rt181 for instance?

>     Here is the oops info:
…
> The call path is:
> 
>  do_fork-> copy_process -> threadgroup_change_end -> percpu_up_read(call
> preempt_disable) -> __percpu_up_read
> 
>  -> wake_up -> rt_spin_lock -> rt_spin_lock_slowlock ->  schedule(call
> preempt_disable again) -> __schedule
> 
>  -> schedule_debug -> in_aotmic_preempt_off (return true, preempt_count ==
> 2) -> __schedule_bug ( leads to kernel pagefault exception, OOPS!!)
> 
> Before schedule, we have call preempt_disable twice, this will definitely
> bump preempt_count to 2 and

something probably disabled preemption before that.

> in_atomic_preempt_off will fail.
> 
> I did not figure out:   WHY we call schedule inside rt_spin_lock_slowlock
> and under what condition this call is correct ?

if the lock is acquired you schedule out and wait und it is available
again.

Sebastian
