Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7300C4338F
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Aug 2021 13:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E21C60F43
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Aug 2021 13:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237511AbhHDNcx (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 4 Aug 2021 09:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236732AbhHDNcw (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 4 Aug 2021 09:32:52 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5130C0613D5
        for <linux-rt-users@vger.kernel.org>; Wed,  4 Aug 2021 06:32:39 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id j18-20020a17090aeb12b029017737e6c349so5784892pjz.0
        for <linux-rt-users@vger.kernel.org>; Wed, 04 Aug 2021 06:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=85UHwPYLE5ZveQneqV4WLF2MU/xjzX/UPKrCzzHnB14=;
        b=q2ARy0ItDKIN/bKfZowVKNhSCk1iR23sFUCsXF9F5e2O8S7yQM9vDKyTDAU+cATUeB
         qcS46CMlVcYBPrL9nXZfr3FhktzUIvdNGGT00a9h9Yz65TDCpYXQqtFYQOi492pI8YU3
         YjO2iNAJkR0KR4JEA9OJZGM4RfAg00/NNZoplDkoqEhP+7RZkIdnFWEaprwSBMV+Yw3H
         DryOMHYy/5SjMe1BCeh4DFSh42ZK4Sc+fSRiDk2lYuah2WinVjsJBAPizq8nOcCLAd7T
         xbn5JiNS8W6g3HCXlqvzmeUeckAh4NGYbS+8zfGS0pgWyj70SFdZHtynbJi65c2ecvH7
         da9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=85UHwPYLE5ZveQneqV4WLF2MU/xjzX/UPKrCzzHnB14=;
        b=N3WcuppGESGiVM8EJp7wX5i8ajk/U/a6kJDUJ6vX4ElmACGcWQvulKfOTmPDYCCuBO
         1tLWxIys24l9l6HZbFbUUN5jWxg7O4W+He+VIrljiUlSj+7RX3cqKZ79+adNehaCWcDL
         CGCIJWlMf49+xUJotRXZ+ouGgkQftOu3u7FGh5aeXRwVX2FK4uhEPLALJhh01fdb6H6D
         X9/J9elyDBGOAq2NrGloYtabR9Aw3izMd+cRX2OzaH9VgS+R+nFDu7ipFXD8bFmlh3Z4
         bJdmOVwR8sHTsWwsnMni/gg92N6BdKhsowYHgJJ19+taLuCXMq+EgxqaoB47vTHh5l2q
         wqfw==
X-Gm-Message-State: AOAM531Os9gZb0B+Aw5D2RJFbYwPXnyFcU2c1w2eiR5u5echgxTN++k8
        GmN2GkU2G3sp/THHRQKtBZ0cfA==
X-Google-Smtp-Source: ABdhPJzjzNXBg+QlL6+ONsT+jwbXMjDobWWv90yVRoQxU18drn+IHw5pzpernyaOISh3X6tOFb/NuA==
X-Received: by 2002:a17:90a:4549:: with SMTP id r9mr28108180pjm.147.1628083959247;
        Wed, 04 Aug 2021 06:32:39 -0700 (PDT)
Received: from [192.168.1.116] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id l14sm6249066pjz.19.2021.08.04.06.32.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 06:32:38 -0700 (PDT)
Subject: Re: [ANNOUNCE] v5.14-rc4-rt4
To:     Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Daniel Wagner <wagi@monom.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
References: <20210802162750.santic4y6lzcet5c@linutronix.de>
 <20210804082418.fbibprcwtzyt5qax@beryllium.lan>
 <20210804104340.fhdjwn3hruymu3ml@linutronix.de>
 <20210804104803.4nwxi74sa2vwiujd@linutronix.de>
 <20210804110057.chsvt7l5xpw7bo5r@linutronix.de>
 <20210804131731.GG8057@worktop.programming.kicks-ass.net>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4f549344-1040-c677-6a6a-53e243c5f364@kernel.dk>
Date:   Wed, 4 Aug 2021 07:32:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210804131731.GG8057@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 8/4/21 7:17 AM, Peter Zijlstra wrote:
> On Wed, Aug 04, 2021 at 01:00:57PM +0200, Sebastian Andrzej Siewior wrote:
>> On 2021-08-04 12:48:05 [+0200], To Daniel Wagner wrote:
>>> On 2021-08-04 12:43:42 [+0200], To Daniel Wagner wrote:
>>>> Odd. Do you have a config for that, please?
>>>
>>> No need.
>>> | [   90.202543] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:35
>>> | [   90.202549] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 2047, name: iou-wrk-2041
>>> | [   90.202555] CPU: 5 PID: 2047 Comm: iou-wrk-2041 Tainted: G        W         5.14.0-rc4-rt4+ #89
>>> | [   90.202561] Call Trace:
>> …
>>> | [   90.202588]  rt_spin_lock+0x19/0x70
>>> | [   90.202593]  ___slab_alloc+0xcb/0x7d0
>> …
>>> | [   90.202618]  kmem_cache_alloc_trace+0x79/0x1f0
>>> | [   90.202621]  io_wqe_dec_running.isra.0+0x98/0xe0
>>> | [   90.202625]  io_wq_worker_sleeping+0x37/0x50
>>> | [   90.202628]  schedule+0x30/0xd0
>>>
>>> le look.
>>
>> So this is due to commit
>>   685fe7feedb96 ("io-wq: eliminate the need for a manager thread")
>>
>> introduced in the v5.13-rc1 merge window. The call chain is
>>   schedule()
>>    sched_submit_work()
>>     preempt_disable();
>>     io_wq_worker_sleeping()
>>       raw_spin_lock_irq(&worker->wqe->lock);
>>       io_wqe_dec_running(worker);
>>        io_queue_worker_create()
>>         kmalloc(sizeof(*cwd), GFP_ATOMIC);
>>
>> The lock wqe::lock has been turned into a raw_spinlock_t in commit
>>    95da84659226d ("io_wq: Make io_wqe::lock a raw_spinlock_t")
>>
>> after a careful analysis of the code at that time. This commit breaks
>> things. Is this really needed?
> 
> Urgh, doing allocs from schedule seems really yuck. Can we please not do
> this?

Agree, I have an idea of how to get rid of it. Let me experiment a bit...

-- 
Jens Axboe

