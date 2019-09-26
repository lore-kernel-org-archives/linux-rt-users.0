Return-Path: <SRS0=fYRI=XV=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8C2C4360C
	for <linux-rt-users@archiver.kernel.org>; Thu, 26 Sep 2019 21:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CB5A222C3
	for <linux-rt-users@archiver.kernel.org>; Thu, 26 Sep 2019 21:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRLT+ReD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbfIZVr4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 26 Sep 2019 17:47:56 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38459 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfIZVr4 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 26 Sep 2019 17:47:56 -0400
Received: by mail-pf1-f194.google.com with SMTP id h195so270450pfe.5;
        Thu, 26 Sep 2019 14:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6AGLv4CWuVuelWFvRQBEfZ9A0Ad8T6D5GdQVJKzqPh4=;
        b=XRLT+ReDlTIRTYrAMObucH4IwHfcTygZSkBOF9wPdZWNgaNHD56Sg79F9VAMZqRi3o
         aumhv6ZVW3PtuVXQczDN8UWeZUhGrQHyXLel0xpJqnQf2ExR0hbPAIa6hxUlfoMBYfeJ
         Q+pwoXOWZhynsL0oM/DhRo9gVJN/eZGDaifGA/2fE2cYit9MUx/x/sheRICmHk5vNrrx
         9uSRJ5H0wA+LJJGFIZhhjpYP9g2rrrmNcrphztjStIwF/mEvFRfJnLPmkeMCRHMqIlya
         8XHsGxzClik9iSAo+ZMuCqxJoSgddBsJmNlLZhcN1Ht/hmWaP0LKlE6Ji7CdI4DWHwoy
         GwFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6AGLv4CWuVuelWFvRQBEfZ9A0Ad8T6D5GdQVJKzqPh4=;
        b=mzto+LCBZu3kgypja8EXxAjoSpu11SZM6FG65NWvJ5b1981wgSrXXXuLACHyY0L0i4
         tDVnypbr8J7lG0iidNAK/FEuOTCYLrUYxwUt8AJiVmLWc5ZI4iGdu3ezlJzhkWk2nTcj
         mMnzTR1ngf8Q8l/12mjNpZC5zm29aUPt6rR/99RT5r8/OjnNZn3kxkdv/g/jj4zymWMX
         papW+Kl5UzpOE3dQkA1r+rK5kxsM5+LWVuvUSAj3n6X9caTL/W+deuhF6CC6iyTeqaJM
         G+hIvH4Ny6CgeMAYPHD5aQgYyy7pAED0llqTtYkMfWqyUKVGLhlkgDctytqKS+7Cyc3H
         ZSuA==
X-Gm-Message-State: APjAAAUFpKNpV19W11ThtPO1POSPCNQjcA3eXzdbzZ1CbRUwA5FSWCfh
        sntpMrgQYN1qjNglVIz3CeU=
X-Google-Smtp-Source: APXvYqzGvXHvWOz50sJ2rqxHIoGNO24ksVFby3tHB9I9BJBonAzzipwGngYkWvKtuFbv+qlf3O6JOw==
X-Received: by 2002:a62:3844:: with SMTP id f65mr108201pfa.142.1569534475392;
        Thu, 26 Sep 2019 14:47:55 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id g12sm223317pfb.97.2019.09.26.14.47.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2019 14:47:54 -0700 (PDT)
Subject: Re: [RT PATCH 1/3] hrtimer: Use READ_ONCE to access timer->base in
 hrimer_grab_expiry_lock()
To:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Julien Grall <julien.grall@arm.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        maz@kernel.org, rostedt@goodmis.org
References: <20190821092409.13225-1-julien.grall@arm.com>
 <20190821092409.13225-2-julien.grall@arm.com>
 <20190821134437.efc3cs55o7uatrpj@linutronix.de>
 <alpine.DEB.2.21.1908211549040.2223@nanos.tec.linutronix.de>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <4352c04c-b424-e73c-1de6-26bab2dc1579@gmail.com>
Date:   Thu, 26 Sep 2019 14:47:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1908211549040.2223@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On 8/21/19 6:50 AM, Thomas Gleixner wrote:
> On Wed, 21 Aug 2019, Sebastian Andrzej Siewior wrote:
> 
>> On 2019-08-21 10:24:07 [+0100], Julien Grall wrote:
>>> The update to timer->base is protected by the base->cpu_base->lock().
>>> However, hrtimer_grab_expirty_lock() does not access it with the lock.
>>>
>>> So it would theorically be possible to have timer->base changed under
>>> our feet. We need to prevent the compiler to refetch timer->base so the
>>> check and the access is performed on the same base.
>>
>> It is not a problem if the timer's bases changes. We get here because we
>> want to help the timer to complete its callback.
>> The base can only change if the timer gets re-armed on another CPU which
>> means is completed callback. In every case we can cancel the timer on
>> the next iteration.
> 
> It _IS_ a problem when the base changes and the compiler reloads
> 
>    CPU0	  	       	   	CPU1
>    base = timer->base;
> 
>    lock(base->....);
> 				switch base
> 
>    reload
> 	base = timer->base;
> 
>    unlock(base->....);
> 

It seems we could hit a similar problem in lock_hrtimer_base()

 base = timer->base;

 if (likely(base != &migration_base)) {

     <reload base : could point to &migration_base>

     raw_spin_lock_irqsave(&base->cpu_base->lock, *flags);

Probably not a big deal, since migration_base-cpu_base->lock can be locked just fine,
(without lockdep complaining that the lock has not been initialized since we use raw_ variant),
but this could cause unnecessary false sharing.


diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 0d4dc241c0fb498036c91a571e65cb00f5d19ba6..fa881c03e0a1a351186a8d8f798dd7471067a951 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -164,7 +164,7 @@ struct hrtimer_clock_base *lock_hrtimer_base(const struct hrtimer *timer,
 	struct hrtimer_clock_base *base;
 
 	for (;;) {
-		base = timer->base;
+		base = READ_ONCE(timer->base);
 		if (likely(base != &migration_base)) {
 			raw_spin_lock_irqsave(&base->cpu_base->lock, *flags);
 			if (likely(base == timer->base))


