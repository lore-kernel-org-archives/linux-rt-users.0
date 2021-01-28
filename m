Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B89C433E0
	for <linux-rt-users@archiver.kernel.org>; Thu, 28 Jan 2021 11:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38F1864DDA
	for <linux-rt-users@archiver.kernel.org>; Thu, 28 Jan 2021 11:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbhA1LbU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 28 Jan 2021 06:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhA1LbS (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 28 Jan 2021 06:31:18 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F4DC061573
        for <linux-rt-users@vger.kernel.org>; Thu, 28 Jan 2021 03:30:38 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id g7so3796307iln.2
        for <linux-rt-users@vger.kernel.org>; Thu, 28 Jan 2021 03:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hUJKEa/UipfXfvv2BusVyq3vW6TupjBeW8m9vWaIqTo=;
        b=q0U7Ia/G4v9Iuo34xskyGWhmO5n8uHYAigBcQqNCpdZ8HagzWhMNSi8/IjYuQPRmpj
         HFoYNTiOl1fghl0970rPC43TSe2CkUuqhfQFyGv5T9Bts8FJPlUjmSK+sfTJU0RfnqJk
         bribUGKdvdmO/Jz1wuGP2vuxnGtuzh2i4xg8RPdQg3pAdNNhRSdVsds6avBGGdwW4/DC
         3zkEsh/CfsaH2Zz8tm5GzOJpxz+VAIePZvAsTcHOJ9s1z9mOnRqSDm4E2dykiIMnpC3Z
         HSR5hwYQce51FCLKX/kdK6FIO6bQ7Ll1ZNNPLAg3vOz7IL+mBin8CpeZaLTAcEQHpuGf
         t6Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hUJKEa/UipfXfvv2BusVyq3vW6TupjBeW8m9vWaIqTo=;
        b=l4D9UV+4eZsBKYtAjkU5LPggjVtl/IR5FsqYEbYidlS8hyNonfOjvQ5ZL+zz7pgfY7
         amjgMQayeRKmrAGP/xfzjrTMHFAoFrwCaQBdU3joPzS6EzUWc+gFSoUzztlPHPXyA1AP
         cQNEStpAc4V5/qjQeLAlPJPekjefE6zLrc+fNrYaC5ScmhllY/blVbavAXFar1WP4QJF
         Cdb80ZGUH5l+EYxaHqOBCg3gJan9Kcel26uB3T2XFL9uufuHmxQRYRzL6k4YoUdKroLe
         ocIluoEdsJgaJVM81u8SUU8QgCqUrRwr7L/bWctQ5KSm69at4erbrfPX9yW1tZTCXHV9
         JtkA==
X-Gm-Message-State: AOAM533ZSe2NNGbqqsmJexdWguO1oWzBSQF4JNQsZpVRqZSy70MnkA4U
        ulxO9MkqPiC/JG+7iAgLJNLq51AJal341DIPWcqVoX2GWFo=
X-Google-Smtp-Source: ABdhPJx35c+rqzd6wNn0MOdxQlDNncmn3dBWOateICgT07XS/lgFb2f6ZNQaxpHvcXDbgJd0fu3BMdrXNgt8ZxOwPoQ=
X-Received: by 2002:a92:c7b0:: with SMTP id f16mr5537674ilk.162.1611833438113;
 Thu, 28 Jan 2021 03:30:38 -0800 (PST)
MIME-Version: 1.0
References: <4fddc141-d24d-f63f-5c81-cfbfb08af442@189.cn>
In-Reply-To: <4fddc141-d24d-f63f-5c81-cfbfb08af442@189.cn>
From:   Daniel Vacek <neelx.g@gmail.com>
Date:   Thu, 28 Jan 2021 12:30:25 +0100
Message-ID: <CAA7rmPGYFV1k0XmxJ3QQYJB+xK2XWdP_eY8poEoo_G6cHNN9Jw@mail.gmail.com>
Subject: Re: preempt_disable causes big latency
To:     "chensong_2000@189.cn" <chensong_2000@189.cn>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Song,

On Thu, Jan 28, 2021 at 10:12 AM chensong_2000@189.cn
<chensong_2000@189.cn> wrote:
> Dear experts,
>
> When i was running cyclictest with ltp(kernel 4.19.90 rt, arch64),
> cyclictest got a big latecy(more than 10ms), the ftrace log shows that
> modprobe called preempt_disable for a long time, which stops cyclictest
> being switched.

This works as designed. Running a latency sensitive application has
some inherent rules. You need to stick to that rules, otherwise
excessive latencies are to be expected. The best documentation (I
believe) you can find on
https://wiki.linuxfoundation.org/realtime/start (ex.
https://rt.wiki.kernel.org/).

In short, running modprobe (loading kernel modules in general) is not
allowed. For a production system, you are supposed to set up the
machine first (loading the modules during boot or before starting the
application). The application itself is bound to allowed operations
only, otherwise it has to expect blocking and unbounded latencies.

> here is a piece of log:
>
> modprobe-4551    0...10   712.754529: preempt_disable:
> caller=0xffff0001019900c8 parent=0xffff0001019900c8
> ...
> modprobe-4551    0d..10   712.754589: irq_disable: caller=el1_irq+0x7c
> parent=0xffff0001019900dc
> modprobe-4551    0d.h10   712.754590: irq_handler_entry:    irq=2
> name=arch_timer
> modprobe-4551    0d.h20   712.754591: hrtimer_cancel:
> hrtimer=0xffff8020f4983d98
> modprobe-4551    0d.h10   712.754591: hrtimer_expire_entry:
> hrtimer=0xffff8020f4983d98 now=712720218245 function=hrtimer_wakeup/0x0
> modprobe-4551    0d.h20   712.754592: sched_waking: comm=cyclictest
> pid=2212 prio=9 target_cpu=000
> modprobe-4551    0dNh30   712.754593: sched_wakeup: cyclictest:2212 [9]
> success=1 CPU:000
> modprobe-4551    0dNh10   712.754594: hrtimer_expire_exit:
> hrtimer=0xffff8020f4983d98
> modprobe-4551    0dNh10   712.754594: irq_handler_exit:     irq=2
> ret=handled

Again, this is perfectly valid.

> Further i found
> preemptirq_delay_test(kernel/trace/preemptirq_delay_test.c) can
> reproduce it easily and got the similar ftrace log.

You can find endless ways how to introduce latency to the system.
That's why some operations are not allowed. For more details see the
mentioned documentation. ^^

> The root cause i found is in el1_irq, it checks preempt count and
> TIF_NEED_RESCHED before it goes through the path el1_preempt,
> preempt_disable just stops it happening.

As it should.

> Then i came up an idea and did an experiment,  call
> preempt_count_set(0); and set_tsk_need_resched(task); in hrtimer_wakeup
> to meet the expectation in order to reschdule.

Sounds like demolishing the pillars of the bridge, yet still expecting
it not to fall. This will break your system for sure.

> static enum hrtimer_restart hrtimer_wakeup(struct hrtimer *timer)
> {
>      struct hrtimer_sleeper *t =
>          container_of(timer, struct hrtimer_sleeper, timer);
>      struct task_struct *task = t->task;
>
>      t->task = NULL;
>      if (task)
>          wake_up_process(task);
>
>      if(preempt_count())
>          preempt_count_set(0);
>      set_tsk_need_resched(task);
>
>      return HRTIMER_NORESTART;
> }
>
> but, failed, system froze, no panic information.

Not surprised.

> Is there anyone having the same problem? i would appreciate it if you
> could share me some information in this case, many thanks.

Simply, no modprobe while running the cyclictest. The cyclictest is
supposed to be running on a machine as if the machine was in
production and definitely not tortured by arbitrary synthetic tests
(unless the test simulates a real world scenario which actually can
happen in production).
Again, all the modules should be preloaded before running cyclictest
or the production application.

Realtime system is a fragile beast and you have to handle it with special care.

Have a nice day,
Daniel

> BR
>
> Song Chen
