Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B446C433B4
	for <linux-rt-users@archiver.kernel.org>; Mon, 26 Apr 2021 18:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BC1561076
	for <linux-rt-users@archiver.kernel.org>; Mon, 26 Apr 2021 18:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234123AbhDZSRU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 26 Apr 2021 14:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbhDZSRU (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 26 Apr 2021 14:17:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3D5C061574;
        Mon, 26 Apr 2021 11:16:37 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619460995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AHCsbCINwquHCC6obELde1nEQozsYpFcoZNX5wyKzFc=;
        b=1DrvPQ2ZmpAF3/f9DX3TmlLiEVBuZyUhyMwLaxrdmAN9xlUOsRka/4z+jmgK6rGOM+u5Hz
        j+Pj8vpSS/u7nFOaIiJF0O0nCaPrFD0eJWxs5ViNFhCahLCjbGyF0sSw5NLYZ44o4MpuYI
        RaKrkN4Y6GLsF9N75O4Kj/rIGkFMQk9ZZjYRx2M5mw0mPYZzaDQCfipOjdFXHj7GsVFffX
        j9iTuxRaiMEFyzWLrszdPIhk94ku3aVw7e+kvyoX1/oXLz0LTXmT3fbZDPqsBkYxfIsSvs
        Y51ZjQQeJFq0Q8VBX6yjTeFwZDOxUOF1v4RpMMADWFUTV7g3I+33VOdkYcrAGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619460995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AHCsbCINwquHCC6obELde1nEQozsYpFcoZNX5wyKzFc=;
        b=3sc6MvKYcZjN8CH0aiWBsyauKAvHhq0huZ52O8XDEVh8bZ871nJRs1Os+hAgPezwj5kW2L
        cpw6jYTsICoVDsAA==
To:     Andrew Halaney <ahalaney@redhat.com>, bigeasy@linutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Chunyu Hu <chuhu@redhat.com>
Subject: Re: [RT PATCH] locking/rwsem-rt: Remove might_sleep() in __up_read()
In-Reply-To: <20210426164229.mbrsrjpmmhp7ehna@halaneylaptop>
References: <20210406221952.50399-1-ahalaney@redhat.com> <20210426164229.mbrsrjpmmhp7ehna@halaneylaptop>
Date:   Mon, 26 Apr 2021 20:16:34 +0200
Message-ID: <877dkoud19.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, Apr 26 2021 at 11:42, Andrew Halaney wrote:
> On Tue, Apr 06, 2021 at 05:19:52PM -0500, Andrew Halaney wrote:
>> There's no chance of sleeping here, the reader is giving up the
>> lock and possibly waking up the writer who is waiting on it.
>> 
>> Reported-by: Chunyu Hu <chuhu@redhat.com>
>> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
>> ---
>> Hello,
>> 
>> I ran into a warning caused by this, and I think the warning is
>> incorrect. Please let me know if I'm wrong!
>> I'm working off of linux-5.12.y-rt, but this applies cleanly to older
>> stable branches as well.
>> 
>> Thanks,
>> Andrew
>> 
>>  kernel/locking/rwsem-rt.c | 1 -
>>  1 file changed, 1 deletion(-)
>> 
>> diff --git a/kernel/locking/rwsem-rt.c b/kernel/locking/rwsem-rt.c
>> index 274172d5bb3a..b61edc4dcb73 100644
>> --- a/kernel/locking/rwsem-rt.c
>> +++ b/kernel/locking/rwsem-rt.c
>> @@ -198,7 +198,6 @@ void __up_read(struct rw_semaphore *sem)
>>  	if (!atomic_dec_and_test(&sem->readers))
>>  		return;
>>  
>> -	might_sleep();
>>  	raw_spin_lock_irq(&m->wait_lock);
>>  	/*
>>  	 * Wake the writer, i.e. the rtmutex owner. It might release the
>> -- 
>> 2.30.2
>
> Just a gentle follow up, any feedback?

Looks correct. Will go into the next rt-release.

Thanks,

        tglx
