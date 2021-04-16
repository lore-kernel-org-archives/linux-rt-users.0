Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF92C433B4
	for <linux-rt-users@archiver.kernel.org>; Fri, 16 Apr 2021 07:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDE8F61166
	for <linux-rt-users@archiver.kernel.org>; Fri, 16 Apr 2021 07:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238871AbhDPHQK (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 16 Apr 2021 03:16:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38169 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234996AbhDPHQI (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 16 Apr 2021 03:16:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618557343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mf2tujoAE7cJX5e0nUVsPCVgQ/PqTodNNPyz8OZlUdA=;
        b=Ladrl4J3pNxXoAl0BeczmVDH/z2hbdpbT6Hb5Cl3lEXe+sy12K3lxQPe8GvjFv70HjG6pw
        Yy9lbSlReEAfWNtmGKwnvyE1q2NTyZM083g+IwSjdmWRNcJXQirywf07FUJ4Nwyi5CcGMT
        Zlv3/5vfBeLpYsjRSdrDXS80VFjZ2zE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-WBQ05WVRMx24ZhaKxMZWjg-1; Fri, 16 Apr 2021 03:15:32 -0400
X-MC-Unique: WBQ05WVRMx24ZhaKxMZWjg-1
Received: by mail-wm1-f69.google.com with SMTP id j3-20020a1c55030000b029012e7c06101aso1779533wmb.5
        for <linux-rt-users@vger.kernel.org>; Fri, 16 Apr 2021 00:15:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Mf2tujoAE7cJX5e0nUVsPCVgQ/PqTodNNPyz8OZlUdA=;
        b=IZw1rG4wKPyqwfwHnLGzkqumHSCShZzXu9HfZQyRnhCTv1ZZazHMOsVUmyP97RK+rm
         NptlBJYxqjPrZOSUQnKl7cR4yqoidBQm611Bj0PZ6je8G54jJIRn7C80hs1ckeY7Effk
         wpNOZRLo4jiEkt1ftTdV6v1FkJIqH/WqoXqHoMdYZloffKUDkJDOGL4pcMdp4ClXh1Y3
         ZYwpV/UlPRX8nu+B4l12YJc6chzAno3UwKtI716t3Du7XX7+EnU6NLuBSPb84gLn3FdB
         fBOQd/Eoe8jdLnSLaHHlm8fVJqdThZiWaliIH9i/SvaqcNbSPXawvg6U8Ugt8V43ZGUk
         LL4w==
X-Gm-Message-State: AOAM532MogKSlwb9n6VnKQnCD3ShVtxZR960WmXwCzZjj+jxGG2BrRIH
        ZyyXvj5Pgaz63M3cXC+V+cn53HWEDB1SmyIu+W6w4QZEaPNdHiX2JuCovrtF2sxbnPZGXi3TRuJ
        4S3NdUEzw/3kE0wuME4x0lvaFaw4=
X-Received: by 2002:a7b:cd07:: with SMTP id f7mr6929126wmj.119.1618557331647;
        Fri, 16 Apr 2021 00:15:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHKzejqV6peUAN5wTKqIIuepE4dhodCniCGexuPk8FMCbH3XSJJzDpOts/HKzbWsRN0EaeSw==
X-Received: by 2002:a7b:cd07:: with SMTP id f7mr6929095wmj.119.1618557331464;
        Fri, 16 Apr 2021 00:15:31 -0700 (PDT)
Received: from x1.bristot.me (nat-cataldo.sssup.it. [193.205.81.5])
        by smtp.gmail.com with ESMTPSA id e13sm9113946wrg.72.2021.04.16.00.15.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 00:15:31 -0700 (PDT)
Subject: Re: [PATCH] kernel:irq:manage: request threaded irq with a specified
 priority
To:     chensong <chensong_2000@189.cn>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        keescook@chromium.org, gregkh@linuxfoundation.org, maz@kernel.org,
        joe@perches.com, romain.perier@gmail.com, john.garry@huawei.com
References: <1618294774-24370-1-git-send-email-chensong_2000@189.cn>
 <875z0qzigk.ffs@nanos.tec.linutronix.de>
 <4a355b66-3803-586b-56c7-ce715b5e59cc@189.cn>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <b31443b4-b460-142b-b1b7-024eafd2e245@redhat.com>
Date:   Fri, 16 Apr 2021 09:15:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <4a355b66-3803-586b-56c7-ce715b5e59cc@189.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 4/16/21 6:57 AM, chensong wrote:
> 
> 
> On 2021/4/13 下午4:39, Thomas Gleixner wrote:
>> On Tue, Apr 13 2021 at 14:19, Song Chen wrote:
>>> In general, irq handler thread will be assigned a default priority which
>>> is MAX_RT_PRIO/2, as a result, no one can preempt others.
>>>
>>> Here is the case I found in a real project, an interrupt int_a is
>>> coming, wakes up its handler handler_a and handler_a wakes up a
>>> userspace RT process task_a.
>>>
>>> However, if another irq handler handler_b which has nothing to do
>>> with any RT tasks is running when int_a is coming, handler_a can't
>>> preempt handler_b, as a result, task_a can't be waken up immediately
>>> as expected until handler_b gives up cpu voluntarily. In this case,
>>> determinism breaks.
>>
>> It breaks because the system designer failed to assign proper priorities
>> to the irq threads int_a, int_b and to the user space process task_a.
> 
> yes, it's designers' responsibility to assign proper priorities, but
> kernel is also obliged to provide interfaces for those designers.

There is no optimal priority assignment for fixed priority schedulers without a
prior knowledge of all tasks (and their timing behavior, e.g., exec time,
activation pattern...). So, the developer will never know what is the best
priority. Such fine tune should be done by the user.

> 
> chrt can help designers in this case, however, the truth is lot of customers are
> not familiar with it.

And making this change in C in kernel is just turning it even more complex.

what's more, chrt can also apply to userspace rt task, but
> userspace also has sched_setscheduler to assgin proper priority inside code like
> cyclictest, why can't driver writers have another choice?

The developer of task_a can also use sched_setscheduler() to adjust the priority
of the handler_a - or even better, decrease the priority of the handler_b as it
is not that important. The developer is supposed to know how to change priority
because task_a is RT too.

Note that the user sets the priority on cyclictest (-p....).

-- Daniel

