Return-Path: <SRS0=w7Cs=7W=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91869C433E1
	for <linux-rt-users@archiver.kernel.org>; Tue,  9 Jun 2020 16:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65AFD20774
	for <linux-rt-users@archiver.kernel.org>; Tue,  9 Jun 2020 16:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591721858;
	bh=BCQkCPQdV/9S0+gXkp9kiGnJ44MEqMOWe0MH2Te+LdY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=ywQg/ZdWMRxVWUMSvv2ia7cnjfHAwTxlZWKPou6mzWe6QqNG2CHp8ss8cPJCDAEw/
	 ZUX80D34VYqfnxJFRw4BAc+E8jB1UcX8Uul2LGgc9ehIHMjI7mRKYhHVl83oWcEjrv
	 /QLn9KjPF27zyCyGW/CJWYEDXYvKnFMLdRa1ISbA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731304AbgFIQ5e (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 9 Jun 2020 12:57:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:55152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731061AbgFIQ5e (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 9 Jun 2020 12:57:34 -0400
Received: from tzanussi-mobl (c-73-211-240-131.hsd1.il.comcast.net [73.211.240.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F06442074B;
        Tue,  9 Jun 2020 16:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591721853;
        bh=BCQkCPQdV/9S0+gXkp9kiGnJ44MEqMOWe0MH2Te+LdY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=CcFOpY+IXYCcGiBOIMnFuU7gudPqxo5AZUGfnJgxcB3mVPBZyR+GHM4gAQllvQZ73
         NPeUrGxxnGgLQjA2cbAslP5TKPYQPj8AggdN7SgEOVcA4j+k5tJuDwLS6cODaQt0b4
         waTgCYGdHIgjEXEkyqTBufQjEWygpklKYZXiP9NQ=
Message-ID: <4ccbc655514eb338a88bea28584ab5611e9a2b88.camel@kernel.org>
Subject: Re: [PATCH RT 1/2] tasklet: Address a race resulting in
 double-enqueue
From:   Tom Zanussi <zanussi@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Ramon Fried <rfried.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        Zhang Xiao <xiao.zhang@windriver.com>
Date:   Tue, 09 Jun 2020 11:57:31 -0500
In-Reply-To: <20200609163446.efp76qbjzkbtl7nk@linutronix.de>
References: <cover.1587675252.git.zanussi@kernel.org>
         <6d4c92b28c54d8ca687c29043562de943a373547.1587675252.git.zanussi@kernel.org>
         <CAGi-RUKn6k98H5v9kw7je1MChb4+Uq8EGhKO0nuXNMBy9M1_qw@mail.gmail.com>
         <b5026121af44601e4318479194357fdb956982f6.camel@kernel.org>
         <20200609154741.5kesuvl7txz4s3yu@linutronix.de>
         <e288ef193f743782df48667b6b03122bd025119f.camel@kernel.org>
         <20200609163446.efp76qbjzkbtl7nk@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Sebastian,

On Tue, 2020-06-09 at 18:34 +0200, Sebastian Andrzej Siewior wrote:
> On 2020-06-09 11:17:53 [-0500], Tom Zanussi wrote:
> > Hi Sebastian,
> 
> Hi Tom,
> 
> > I did find a problem with the patch when configured as !SMP since
> > in
> > that case the RUN flag is never set (will send a patch for that
> > shortly), but that wouldn't be the case here.
> 
> How?
> 

My test machine with !SMP and !RT doesn't boot, and in that case we
have:

#define tasklet_trylock(t) 1
#define tasklet_tryunlock(t)    1

instead of setting/clearing the RUN flag.

So the cmpxchg with RUN+CHAIN can never work and we hit the loop.

> > #if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT_FULL)
> > static inline int tasklet_trylock(struct tasklet_struct *t)
> > {
> >         return !test_and_set_bit(TASKLET_STATE_RUN, &(t)->state);
> > }
> 
> I can't tell from the backtrace if he runs with RT or without but I
> assumed RT. But yes, for !SMP && !RT it would explain it.
> 

Yeah, for me !SMP and RT works, but !SMP and !RT doesn't.

I had assumed he was talking about the samely configured kernel, but
apparently it's not.

Tom

> > It would help to be able to reproduce it, but I haven't been able
> > to
> > yet.
> > 
> > Tom
> > 
> 
> Sebastian

