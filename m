Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECB3C2B9F7
	for <linux-rt-users@archiver.kernel.org>; Wed, 26 May 2021 10:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF68360551
	for <linux-rt-users@archiver.kernel.org>; Wed, 26 May 2021 10:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbhEZK2Q (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 26 May 2021 06:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233793AbhEZK2P (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 26 May 2021 06:28:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079EEC061574
        for <linux-rt-users@vger.kernel.org>; Wed, 26 May 2021 03:26:43 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622024801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OIiy72qhwIWoavgdNgJhAv6Oahc961SSYDC30Z5XVL8=;
        b=P72qVhskytt86nslLKRBkdNI7r6GcyYHv1RxHjPNlahJ/EsN6IS7U2h2Owih8b4fOfD99E
        y3EToQq9AkiFzQzRjFVXDPDjdVaiR2IRgUgjVctqAmWgKS26416vSy/z0nAuDmgjHHnIzA
        beA1+Jwqs9QPrOYr6D6arawN5JIGKSeNLp8zy9emrMZ4puPPHuaLxW4N7ni70Gn4WrEC1Y
        3EGQpsP7LbNVTPAcf+NZeDr26zx/BrN7LYz41+5QvwWSZzbye4Fbji8OqbiKPiyDCfvl2W
        QIIqYWaCFRuVL1Nb3lLKQ95Uw3tewj3hnijNYI5N1jVKNGS5aIsRewv0weluqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622024801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OIiy72qhwIWoavgdNgJhAv6Oahc961SSYDC30Z5XVL8=;
        b=90+rVDxl6C996Tam4uCZnltNbZCiCQvHaRy9z+04Wb2lXtUXt69qkmvt7/6LNrtxMJWXXn
        XkyI5ugbG7r8AgBA==
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Dipen Patel <dipenp@nvidia.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: Multi pthreaded RT application - mlock doubt
In-Reply-To: <YK4HT42yr02J1Gp1@lx-t490>
References: <896cf71c-f610-961a-9d30-8a82d433e0f6@nvidia.com> <YKymwnknCImO30CU@lx-t490> <95b1b0f8-4957-f9cb-0cf7-82c79d819c38@nvidia.com> <YK4HT42yr02J1Gp1@lx-t490>
Date:   Wed, 26 May 2021 12:26:40 +0200
Message-ID: <87mtshbxjz.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Dipen,

On 2021-05-26, "Ahmed S. Darwish" <a.darwish@linutronix.de> wrote:
>> Original example shown in above link uses the
>> prove_thread_stack_use_is_safe same way. I just extended it to call it
>> locally and calculate it locally because of the mutli thread.
>
> As I said, the example is wrong, and it is not authoritative. It is just
> an old obsolete wiki that no one maintains anymore.

This example is confusing to say the least. But it will work as expected
with only 1 thread.

>> static void *my_rt_thread(void *args)
>> {
> ...
>> 	int last_majflt = 0, last_minflt = 0;
> ...

Creating threads will cause page faults. Since you are now creating
multiple threads and your thread function immediately calls getrusage(),
the first threads are "seeing" the page faults of the later threads
being created. For example, if you add a sleep() here before calling
getrusage() and give the threads a chance to start up, then you will see
no more page faults.

>>
>>    	getrusage(RUSAGE_SELF, &usage);
>>
>>    	printf("[%d]Pagefaults, Major:%ld, Minor:%ld \n",pthread_self(),
>>    	       usage.ru_majflt - last_majflt,
>>    	       usage.ru_minflt - last_minflt);
>>
>> 	last_majflt = usage.ru_majflt;
>>    	last_minflt = usage.ru_minflt;
>>
>>    	prove_thread_stack_use_is_safe(MY_STACK_SIZE);
>>
>> 	getrusage(RUSAGE_SELF, &usage);
>>
>>    	printf("[%d]After stack usage:Pagefaults, Major:%ld, Minor:%ld \n",pthread_self(),
>>    	       usage.ru_majflt - last_majflt,
>>    	       usage.ru_minflt - last_minflt);
>>
>
> You're just measuring the effect of stack prefaulting, which will
> obviously generate page faults (as expected).

For the main task this would be correct. But the thread stacks come from
the heap, which was already prefaulted.

In general, avoiding page faults for threaded real-time tasks that
dynamically allocate memory is rather complex. If you are using glibc,
you need to understand how it manages memory for threads.

https://sourceware.org/glibc/wiki/MallocInternals

Setting M_ARENA_MAX can help here.

But in general, just make sure your real-time threads have all the
memory they need (allocated and prefaulted and _not_ given back to the
heap) before they start their real-time activity.

John Ogness
