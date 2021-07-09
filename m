Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D544C07E9B
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Jul 2021 13:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D1ED61376
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Jul 2021 13:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbhGINvS (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 9 Jul 2021 09:51:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58762 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbhGINvS (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 9 Jul 2021 09:51:18 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625838514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hVC3cXAhgYnSipbuuxux93KDFOSs/oL3p5xOhmYvtWo=;
        b=cWB3cxoJSaVuRcaSa8q85BHUo4we2u+X4Z+9zJeJYLSEMt1u/AxV8omDcjeMPkUch38RdB
        4G/NN+3C6hjxQb+6oNDncQgrSeyTsPL1/2vJheRqMqXoBxygtPHIwSXvAn/Ag9tg6yBR6R
        lToodPh9HSQwZuY51xCfq55RTDBlS81/4JmgnMF34eeIf+iGtAH0qRBVTFIDC6cK5QSWaB
        EZJEuwbO9Z6baMalA1qXgCLJtAXzyyYDZr7EwpSM4cdO4sJpdOJ7Uk00+AM45LDT69RzTk
        xW0DkdYNc82xPlugRnR+Bm+ovk/54C+TomUscxvIGNXFXWD3pvwMwrPEtQQrTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625838514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hVC3cXAhgYnSipbuuxux93KDFOSs/oL3p5xOhmYvtWo=;
        b=iDLmk7mU5iLGJJ3gsdnwKgDnHOn+R5VCbr4dfEEIj2KXnaInxLJhwsO6/El4OO/x8CM7d/
        Shkj7Ql4xt6vHxAg==
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, Chunyu Hu <chuhu@redhat.com>,
        stable-rt@vger.kernel.org
Subject: Re: [RT PATCH] locking/rwsem-rt: Remove might_sleep() in __up_read()
In-Reply-To: <20210708195125.zxqsxy5bpccgxb2n@halaneylaptop>
References: <20210406221952.50399-1-ahalaney@redhat.com> <20210426164229.mbrsrjpmmhp7ehna@halaneylaptop> <877dkoud19.ffs@nanos.tec.linutronix.de> <20210708195125.zxqsxy5bpccgxb2n@halaneylaptop>
Date:   Fri, 09 Jul 2021 15:48:33 +0200
Message-ID: <87bl7boaxa.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Andrew,

On Thu, Jul 08 2021 at 14:51, Andrew Halaney wrote:

Cc+ stable-rt folks and leave context untrimmed.

> On Mon, Apr 26, 2021 at 08:16:34PM +0200, Thomas Gleixner wrote:
>> On Mon, Apr 26 2021 at 11:42, Andrew Halaney wrote:
>> > On Tue, Apr 06, 2021 at 05:19:52PM -0500, Andrew Halaney wrote:
>> >> There's no chance of sleeping here, the reader is giving up the
>> >> lock and possibly waking up the writer who is waiting on it.
>> >> 
>> >> Reported-by: Chunyu Hu <chuhu@redhat.com>
>> >> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
>> >> ---
>> >> Hello,
>> >> 
>> >> I ran into a warning caused by this, and I think the warning is
>> >> incorrect. Please let me know if I'm wrong!
>> >> I'm working off of linux-5.12.y-rt, but this applies cleanly to older
>> >> stable branches as well.
>> >>
>> >> Thanks,
>> >> Andrew
>> >> 
>> >>  kernel/locking/rwsem-rt.c | 1 -
>> >>  1 file changed, 1 deletion(-)
>> >> 
>> >> diff --git a/kernel/locking/rwsem-rt.c b/kernel/locking/rwsem-rt.c
>> >> index 274172d5bb3a..b61edc4dcb73 100644
>> >> --- a/kernel/locking/rwsem-rt.c
>> >> +++ b/kernel/locking/rwsem-rt.c
>> >> @@ -198,7 +198,6 @@ void __up_read(struct rw_semaphore *sem)
>> >>  	if (!atomic_dec_and_test(&sem->readers))
>> >>  		return;
>> >>  
>> >> -	might_sleep();
>> >>  	raw_spin_lock_irq(&m->wait_lock);
>> >>  	/*
>> >>  	 * Wake the writer, i.e. the rtmutex owner. It might release the
>> >> -- 
>> >> 2.30.2
>> >
>> > Just a gentle follow up, any feedback?
>> 
>> Looks correct. Will go into the next rt-release.
>> 
>> Thanks,
>> 
>>         tglx
>> 
>
> Hi Thomas,
>
> I see a new release (v5.13-rt1) was created, and with it rwsem
> was overhauled entirely making this patch pointless for linux-rt-devel.
>
> That being said, it's a little unclear to me how RT only patches
> make their way to the maintained branches over in linux-stable-rt.
> I think it should be applied to:
>  v4.9-rt
>  v4.14-rt
>  v4.19-rt
>  v5.4-rt
>  v5.10-rt
> to remove the incorrect warning, unless those branches plan to backport
> the latest RT patchset with the new rwsem implementation. Is there a
> proper way for me signal that?

See Cc.

Thanks,

        tglx
