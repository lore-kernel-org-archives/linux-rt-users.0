Return-Path: <SRS0=gcb+=EK=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3B1C2D0A3
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Nov 2020 13:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8152E20780
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Nov 2020 13:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="keRKoXlK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H703sIwu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729227AbgKDN0T (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 4 Nov 2020 08:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729198AbgKDN0S (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 4 Nov 2020 08:26:18 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96ECEC0613D3;
        Wed,  4 Nov 2020 05:26:18 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604496377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X/y979eVJRsQpBS3uTHsEVTLszhMzUjou+ruEut+S9s=;
        b=keRKoXlK9BNK4il+KjFMvHwcVKtTQAY5CIRfZMZWu3ZBdswM7KDnajE9B+yNzy2ySIxPXD
        pdljSMaFwptkjkOOBzUx9Gm5IgeVJ7ygNXzpJpdDsyqzbk5Z+aWn97NeWfgT97TNgjXP+z
        LvypjSCXj/76tsMNJRFcRSzF9psbA5CwqfmoXdZIbSJyqCycHD3kl6YG3q4yQI25jkCyt4
        2m/wDfJn5yVXzBNijo3v3XkJfXvBlq/xGEhHeDeUxURYqiWnmR3fB88WsjmlsJKlQVD6Wo
        Fqde30u9/tju2tJVTlcBCuLUb95zvoFWFn8Qe3L30QU6UmB9B8vGvLkuIrp0Uw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604496377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X/y979eVJRsQpBS3uTHsEVTLszhMzUjou+ruEut+S9s=;
        b=H703sIwu528AJqL8IC960f6xJ+Ji5K2/HvtrgPmB92y34aE2d4Kut122s6Mh/SiaC2ssWn
        jmCRIJMDlPFcHBCA==
To:     Mike Galbraith <efault@gmx.de>,
        Gratian Crisan <gratian.crisan@ni.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Brandon Streiff <brandon.streiff@ni.com>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        James Minor <james.minor@ni.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: BUG_ON(!newowner) in fixup_pi_state_owner()
In-Reply-To: <871rh9mkvr.fsf@nanos.tec.linutronix.de>
References: <87a6w6x7bb.fsf@ni.com> <878sbixbk4.fsf@ni.com> <2376f4e71c638aee215a4911e5efed14c5adf56e.camel@gmx.de> <5f536491708682fc3b86cb5b7bc1e05ffa3521e7.camel@gmx.de> <874km5mnbf.fsf@nanos.tec.linutronix.de> <871rh9mkvr.fsf@nanos.tec.linutronix.de>
Date:   Wed, 04 Nov 2020 14:26:16 +0100
Message-ID: <87v9ell0cn.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Nov 04 2020 at 12:17, Thomas Gleixner wrote:
> On Wed, Nov 04 2020 at 11:24, Thomas Gleixner wrote:
>> On Wed, Nov 04 2020 at 08:42, Mike Galbraith wrote:
>>> On Wed, 2020-11-04 at 01:56 +0100, Mike Galbraith wrote:
>>> --- a/kernel/futex.c
>>> +++ b/kernel/futex.c
>>> @@ -2383,7 +2383,18 @@ static int fixup_pi_state_owner(u32 __us
>>>  		 * Since we just failed the trylock; there must be an owner.
>>>  		 */
>>>  		newowner = rt_mutex_owner(&pi_state->pi_mutex);
>>> -		BUG_ON(!newowner);
>>> +
>>> +		/*
>>> +		 * Why? Because I know what I'm doing with these beasts?  Nope,
>>> +		 * but what the hell, a busy restart loop let f_boosted become
>>> +		 * owner, so go for it. Box still boots, works, no longer makes
>>> +		 * boom with fbomb_v2, and as an added bonus, didn't even blow
>>> +		 * futextests all up.  Maybe it'll help... or not, we'll see.
>>> +		 */
>>> +		if (unlikely(!newowner)) {
>>> +			err = -EAGAIN;
>>> +			goto handle_err;
>>
>> Yes, that cures it, but does not really explain why newowner is
>> NULL. Lemme stare more.
>
> Aside of that it's going to create inconsistent state in the worst
> case. There is something really fishy in the trace Gratian provided....

Ok. With some more info added to the trace I could convince myself, that
Gratians trace is not so fishy at all and that Mike's fix is actually
the right thing to do.

I'll post that with a proper comment and changelog. Mike, can I add your
Signed-off-by to the thing?
