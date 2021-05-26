Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45924C2B9F7
	for <linux-rt-users@archiver.kernel.org>; Wed, 26 May 2021 08:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18C25613F1
	for <linux-rt-users@archiver.kernel.org>; Wed, 26 May 2021 08:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbhEZIcp (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 26 May 2021 04:32:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53598 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbhEZIcp (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 26 May 2021 04:32:45 -0400
Date:   Wed, 26 May 2021 10:31:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622017873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KeR5qzd3ADxTkDCKp5F4VXJBnJnqoZVfbkukyREk81Q=;
        b=yfWg/DIhVSrjUAmahLMiUAdJFTXK+2dEY7CupEaURb6C8d0GICy1XYNiSua5yGTRJ344QF
        ns0DrBJY+gZwDAdRFYW9NvvnE5SLbT+kaiL4blasZ6wTd4asTj9wi5o3bCpsOfJJ27ZAfB
        HRXMkU45KZLfni57kWemy5D7OUhgoYWIMBtKxnM0YRAlGS0x+7M/xqPqK1peDUbiQCzcTj
        viNNKWzFZ0dGjnXaQ1V48FF0jVz2FRHjO+olwzocIo3nWA93GUE1qRq35RN9aAaT+4f36f
        lAa/QPBYKuP7LfieACr0r8VeMdPEy5m2qQZ8aRp5w1oddZyudKUu3KSbGXC7Sw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622017873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KeR5qzd3ADxTkDCKp5F4VXJBnJnqoZVfbkukyREk81Q=;
        b=zNVCxX2jAjqvxOFVk7yo2xtFmTQqncHfeLbO30ukAL9B3SfZV7KHvMXskbVU2ZVDhwBmZT
        twyHwM8l9FdVl5BA==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: Multi pthreaded RT application - mlock doubt
Message-ID: <YK4HT42yr02J1Gp1@lx-t490>
References: <896cf71c-f610-961a-9d30-8a82d433e0f6@nvidia.com>
 <YKymwnknCImO30CU@lx-t490>
 <95b1b0f8-4957-f9cb-0cf7-82c79d819c38@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95b1b0f8-4957-f9cb-0cf7-82c79d819c38@nvidia.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, May 25, 2021, Dipen Patel wrote:
...
> Original example shown in above link uses the
> prove_thread_stack_use_is_safe same way. I just extended it to call it
> locally and calculate it locally because of the mutli thread.

As I said, the example is wrong, and it is not authoritative. It is just
an old obsolete wiki that no one maintains anymore.

The same problem exists in the program you posted:

> static void prove_thread_stack_use_is_safe(int stacksize)
> {
>  	volatile char buffer[stacksize];
>  	int i;
>
>    	for (i = 0; i < stacksize; i += sysconf(_SC_PAGESIZE))
>    		buffer[i] = i;
> }
...
> static void *my_rt_thread(void *args)
> {
...
> 	int last_majflt = 0, last_minflt = 0;
...
>
>    	getrusage(RUSAGE_SELF, &usage);
>
>    	printf("[%d]Pagefaults, Major:%ld, Minor:%ld \n",pthread_self(),
>    	       usage.ru_majflt - last_majflt,
>    	       usage.ru_minflt - last_minflt);
>
> 	last_majflt = usage.ru_majflt;
>    	last_minflt = usage.ru_minflt;
>
>    	prove_thread_stack_use_is_safe(MY_STACK_SIZE);
>
> 	getrusage(RUSAGE_SELF, &usage);
>
>    	printf("[%d]After stack usage:Pagefaults, Major:%ld, Minor:%ld \n",pthread_self(),
>    	       usage.ru_majflt - last_majflt,
>    	       usage.ru_minflt - last_minflt);
>

You're just measuring the effect of stack prefaulting, which will
obviously generate page faults (as expected).

Given your original email in this thread, it seems you're conflicting
mlockall() with page faults.

mlockall() just forces physical memory pages ** already mapped through
the process address space ** to be memory-resident; i.e., not getting
swapped.  Even with MCL_CURRENT| MCL_FUTURE, mlockall() does not prevent
"demand paging" page faults: it only says that if your process got
allocated a phsyical memory page, it will not get swapped.

So, technically, the mlockall() effect will start only after
prove_thread_stack_use_is_safe() gets allocated real/physical memory
pages by its code which prefauls the stack.

The source of confusion, I guess, is that
prove_thread_stack_use_is_safe() is horribly named. In its first
invocation, it does not "prove" anything, it is actually the entity
prefaulting the thread stack.

Hope this helps,

--
Ahmed S. Darwish
Linutronix GmbH
