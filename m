Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C04C4742C
	for <linux-rt-users@archiver.kernel.org>; Mon, 16 Nov 2020 11:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD235221F8
	for <linux-rt-users@archiver.kernel.org>; Mon, 16 Nov 2020 11:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="xT+SqK9/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbgKPK1O (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 16 Nov 2020 05:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgKPK1N (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 16 Nov 2020 05:27:13 -0500
X-Greylist: delayed 42855 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 16 Nov 2020 02:27:13 PST
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBA1C0613CF;
        Mon, 16 Nov 2020 02:27:13 -0800 (PST)
Received: from mail.natalenko.name (vulcan.natalenko.name [IPv6:fe80::5400:ff:fe0c:dfa0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 02C6189DC12;
        Mon, 16 Nov 2020 11:27:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1605522430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sj6OiBdO7loZZMxCiHWmGm/4jUgM9stnYplzGZbEaPs=;
        b=xT+SqK9/GEXSJK0vb8FES4Ticw6nqxiEIq3iDkQhGDvPhdDkTKEl7fF8dnvdFycalbRtir
        dAcab73XL+cbaJtt3jFNqa0MU48G1syTYESR7O3KYFkCWyZM8TVD5LrJMvXYDT63UDSBax
        6LMFNcVv0fVgelscsgL1zQ35Bj5FqX0=
MIME-Version: 1.0
Date:   Mon, 16 Nov 2020 11:27:09 +0100
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org
Subject: Re: WARNING at kernel/sched/core.c:2013
 migration_cpu_stop+0x2e3/0x330
In-Reply-To: <jhj3619y63v.mognet@arm.com>
References: <a1fd0d9c6c8cd90a74879b61467ae48d@natalenko.name>
 <jhj3619y63v.mognet@arm.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <41d6aca71c6a52df8437cdb7b4a1b1c4@natalenko.name>
X-Sender: oleksandr@natalenko.name
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi.

On 16.11.2020 11:00, Valentin Schneider wrote:
> On 15/11/20 22:32, Oleksandr Natalenko wrote:
>> I'm running v5.10-rc3-rt7 for some time, and I came across this splat 
>> in
>> dmesg:
>> 
>> ```
>> [118769.951010] ------------[ cut here ]------------
>> [118769.951013] WARNING: CPU: 19 PID: 146 at kernel/sched/core.c:2013
> 
> Err, I didn't pick up on this back then, but isn't that check bogus? If 
> the
> task is enqueued elsewhere, it's valid for it not to be affined
> 'here'. Also that is_migration_disabled() check within is_cpu_allowed()
> makes me think this isn't the best thing to call on a remote task.
> 
> ---
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 1218f3ce1713..47d5b677585f 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2010,7 +2010,7 @@ static int migration_cpu_stop(void *data)
>  		 * valid again. Nothing to do.
>  		 */
>  		if (!pending) {
> -			WARN_ON_ONCE(!is_cpu_allowed(p, cpu_of(rq)));
> +			WARN_ON_ONCE(!cpumask_test_cpu(task_cpu(p), p->cpus_ptr));
>  			goto out;
>  		}

Not sure whether the check is legitimate, but FWIW I've managed to put a 
test task [1] (it spawns a lot of threads and applies affinity) into a 
permanent unkillable D state here:

```
[<0>] affine_move_task+0x2d3/0x620
[<0>] __set_cpus_allowed_ptr+0x164/0x210
[<0>] sched_setaffinity+0x21a/0x300
[<0>] __x64_sys_sched_setaffinity+0x8c/0xc0
[<0>] do_syscall_64+0x33/0x40
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
```

I think this corresponds to something around here:

```
$ scripts/faddr2line kernel/sched/core.o affine_move_task+0x2d3
affine_move_task+0x2d3/0x620:
arch_atomic_fetch_sub at 
/home/pf/linux-pf-edge/src/linux-5.10/./arch/x86/include/asm/atomic.h:190
(inlined by) atomic_fetch_sub_release at 
/home/pf/linux-pf-edge/src/linux-5.10/./include/asm-generic/atomic-instrumented.h:221
(inlined by) __refcount_sub_and_test at 
/home/pf/linux-pf-edge/src/linux-5.10/./include/linux/refcount.h:272
(inlined by) __refcount_dec_and_test at 
/home/pf/linux-pf-edge/src/linux-5.10/./include/linux/refcount.h:315
(inlined by) refcount_dec_and_test at 
/home/pf/linux-pf-edge/src/linux-5.10/./include/linux/refcount.h:333
(inlined by) affine_move_task at 
/home/pf/linux-pf-edge/src/linux-5.10/kernel/sched/core.c:2334
```

or:

```
2332     wait_for_completion(&pending->done);
2333
2334     if (refcount_dec_and_test(&pending->refs))
2335         wake_up_var(&pending->refs);
```

I'm not positive about this being directly related to the original 
report, but I think it is still worth mentioning.

Thanks.

[1] https://gitlab.com/post-factum/burn_scheduler

-- 
   Oleksandr Natalenko (post-factum)
