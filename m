Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA08C433EF
	for <linux-rt-users@archiver.kernel.org>; Fri, 17 Jun 2022 14:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382833AbiFQOqc (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 17 Jun 2022 10:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382552AbiFQOqb (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 17 Jun 2022 10:46:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE0EA427D0
        for <linux-rt-users@vger.kernel.org>; Fri, 17 Jun 2022 07:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655477189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9WJ3fcpXL0f2WOS1lh4X7CDZ3Ewdk0gaVvZYQvOA7jA=;
        b=d+rJIo9fNstpU1X52hJPrUAmMGTnhuVSTgZJxHx5yiPtBQ4cisIRDhWuE1pnzCV7bC7GWh
        tx1aWNFGVWyWWluaLAdj8+BPtU1wjIVqOBmxhMtMVlCyCpZmnU2bPvxYTfXV2xiDtIRST2
        4NA1TwnLZMfj1U5+T1d5YTWoCAbdJuI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-iNM8x0QLP7WCFxMJqx-TqA-1; Fri, 17 Jun 2022 10:46:28 -0400
X-MC-Unique: iNM8x0QLP7WCFxMJqx-TqA-1
Received: by mail-qk1-f199.google.com with SMTP id bl27-20020a05620a1a9b00b0069994eeb30cso5180062qkb.11
        for <linux-rt-users@vger.kernel.org>; Fri, 17 Jun 2022 07:46:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=9WJ3fcpXL0f2WOS1lh4X7CDZ3Ewdk0gaVvZYQvOA7jA=;
        b=ucoyflzZCJAKLdxTTLDPp6d2J6Q1cme6QriyML0RUCOMG+SMedwdsDQhLNTXotn1jd
         Yvtl4o6sT8FC2b2KAOgnBK43VzNJ/dFH8poHMB1WMHxsmYtN6/K3OkkH9inDgJEvZgt8
         LE8Zln2ONdItq6TdjJV7HkBj+eVYJkyoGYpHo0Jnj7DQRfSqMCe1niWmXIDPTNa7e2Ap
         G4pw4KWm7NQNxFJSMs2OZ2WwZ/khjp2PeoOJ2m8Rh9ngAcjPwW8C70cLxw8SqeTYCLvE
         SW+Q7EvMz+mvLykMY/5bAYcwCsuqJZW2+XSscc03Q9+fZ+kI0iZgMUsU9YY8jiAcU3QJ
         43cw==
X-Gm-Message-State: AJIora+ATc86hKemYOeh5KLRlBP1NBdKKoK/FU26Cn/F8fmVpCq93cAx
        FRe2NULDpUikpsAIDSepGY0+PDWDDa2AjiWtqLlDT4g7W4iEvvVCLa+vUnVba288EsNOOB15lJq
        vfBovG+WVscT5zlrRXSKWkbp2nY8=
X-Received: by 2002:ad4:5c4a:0:b0:464:5920:7c1a with SMTP id a10-20020ad45c4a000000b0046459207c1amr8736676qva.58.1655477188329;
        Fri, 17 Jun 2022 07:46:28 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tAXwW2mpsUavrlypnLTFvGbZu5tQk5+gn1Z1EAvySMi1FHasDEGVadg1bRJOm3lqNdYXoCAg==
X-Received: by 2002:ad4:5c4a:0:b0:464:5920:7c1a with SMTP id a10-20020ad45c4a000000b0046459207c1amr8736646qva.58.1655477188058;
        Fri, 17 Jun 2022 07:46:28 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id a15-20020ac85b8f000000b00304e38fb3dasm4813173qta.35.2022.06.17.07.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 07:46:27 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Tao Zhou <tao.zhou@linux.dev>, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, linux-rt-users@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <jlelli@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: Re: [PATCH] panic, kexec: Don't mutex_trylock() in __crash_kexec()
In-Reply-To: <YqyHGxPCgiXuep3/@alley>
References: <20220616123709.347053-1-vschneid@redhat.com>
 <Yqxaf6V+hvCSXQSM@geo.homenetwork>
 <xhsmhh74j7biy.mognet@vschneid.remote.csb> <YqyHGxPCgiXuep3/@alley>
Date:   Fri, 17 Jun 2022 15:46:23 +0100
Message-ID: <xhsmhczf773gg.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 17/06/22 15:52, Petr Mladek wrote:
> On Fri 2022-06-17 12:52:05, Valentin Schneider wrote:
>> If you look at __crash_kexec() in isolation yes, but if you look at panic()
>> and nmi_panic() only a single NMI can get in there. I think that is also
>> true for invocations via crash_kexec().
>
> It is true that panic() could be called only once, see this code
> in panic():
>
> 	 * Only one CPU is allowed to execute the panic code from here. For
> 	this_cpu = raw_smp_processor_id();
> 	old_cpu  = atomic_cmpxchg(&panic_cpu, PANIC_CPU_INVALID, this_cpu);
>
> 	if (old_cpu != PANIC_CPU_INVALID && old_cpu != this_cpu)
> 		panic_smp_self_stop();
>
>
> One the other hand, the aproach with two variables is strage
> and brings exactly these questions.
>
> If a trylock is enough that the mutex can be replaced by two
> simple atomic operations. The mutex would be needed only
> when a user really would need to wait for another one.
>
>
> 	atomic_t crash_kexec_lock;
>
> 	/* trylock part */
> 	if (atomic_cmpxchg_acquire(&crash_kexec_lock, 0, 1) != 0)
> 		return -EBUSY;
>
> 	/* do anything guarded by crash_kexec_lock */
>
> 	/* release lock */
> 	atomic_set_release(&crash_kexec_lock, 0);
>
> The _acquire, _release variants will do the barriers correctly.
>

Looks saner! I can't think of anything wrong with it so I'll shove that in
v2. Thanks!

> Best Regards,
> Petr

