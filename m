Return-Path: <SRS0=wEKt=D3=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70E2C433DF
	for <linux-rt-users@archiver.kernel.org>; Tue, 20 Oct 2020 11:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EF722224A
	for <linux-rt-users@archiver.kernel.org>; Tue, 20 Oct 2020 11:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GyHAqiEU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YmyiKU/3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393434AbgJTLic (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 20 Oct 2020 07:38:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38510 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393425AbgJTLib (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 20 Oct 2020 07:38:31 -0400
Date:   Tue, 20 Oct 2020 13:38:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603193910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j20Wy6gG/n2n2fPcOmtdQ3PyWhUGXdRpcMX2S7N3jpQ=;
        b=GyHAqiEUjuE+MlmlPxVF0s9SxA3io7EY9NP9LkQPJOanrIZlaJRnEoXdy9Ob2qLLUvlc47
        QBvDopqpp9DTYYZP/f4s2JlHLd8/BHsVbIRkr5aN8EC1WVhKsXqsCVpBTsZF8IFmVyxtJd
        1JNViHeahOvClk4v36Sl9S8WM268/F6TdhhXRAI2WuK6us4+V5fgKhHkSr+IekjcPh9Fxe
        bcH8lHJB90Lim1nzHJQVoE+pTKOdZbD+0jXSFv96WgqCA9yL2OPeHOaS660wvaylyk+1AK
        Xzw7yaRANwk3XnT462DrMLg+emo4XaJKE9Xy559M1Ue5pwj884OsLVsOwl7H+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603193910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j20Wy6gG/n2n2fPcOmtdQ3PyWhUGXdRpcMX2S7N3jpQ=;
        b=YmyiKU/3wGwAZxucoCTkp+LcyOJZoClm5EiLpLCrEW5L2dZaMDyO5NUtRUl0c86Dl6GzCi
        1UBkJ8feOOpAeiAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Christian Eggers <ceggers@arri.de>, tglx@linutronix.de,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: sched: system doesn't boot since  "sched: Add new
 migrate_disable() implementation"
Message-ID: <20201020113828.fv7ui4h3gkrcpqoc@linutronix.de>
References: <1654655.1jrfHnk7pZ@n95hx1g2>
 <20201019150935.koqbk57dmahhomdc@linutronix.de>
 <20201020113009.GR2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201020113009.GR2628@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-10-20 13:30:09 [+0200], Peter Zijlstra wrote:
> On Mon, Oct 19, 2020 at 05:09:35PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2020-10-19 12:21:06 [+0200], Christian Eggers wrote:
> > > I have problems with the latest 5.9-rt releases on i.MX6ULL (!CONFIG_=
SMP):
> > >=20
> > =E2=80=A6
> > > Any hints?
> >=20
> > Thank you for the report. The reason is the migrate_disable()
> > implementation for !SMP.
>=20
> This should fix things I suppose. I'll fold it in.

It will. It will also break lazy-preemption. Each time a sleeping lock
is acquired there is also migrate_disable() and the migrate-disable
counter is !=3D 0 (even for UP). The result is that a wake up for a
SCHED_OTHER task with mg counter !=3D 0 will not lead to context switch
(same like preemption counter !=3D 0). The difference is that a wake up
for a RT task ignores this counter and perform a context switch anyway.

That way we have RT wake ups on time but avoid stumbling from one lock
to another.

> ---
> --- a/include/linux/preempt.h
> +++ b/include/linux/preempt.h
> @@ -378,7 +378,12 @@ static inline void preempt_notifier_init
>  extern void migrate_disable(void);
>  extern void migrate_enable(void);
> =20
> -#else /* !(CONFIG_SMP && CONFIG_PREEMPT_RT) */
> +#elif defined(CONFIG_PREEMPT_RT)
> +
> +static inline void migrate_disable(void) { }
> +static inline void migrate_enable(void { }
> +
> +#else /* !CONFIG_PREEMPT_RT */
> =20
>  /**
>   * migrate_disable - Prevent migration of the current task

Sebastian
