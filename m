Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4C2C4320A
	for <linux-rt-users@archiver.kernel.org>; Fri, 20 Aug 2021 06:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13A3961042
	for <linux-rt-users@archiver.kernel.org>; Fri, 20 Aug 2021 06:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238406AbhHTGy6 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 20 Aug 2021 02:54:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51596 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbhHTGy6 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 20 Aug 2021 02:54:58 -0400
Date:   Fri, 20 Aug 2021 08:54:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629442459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9kl53d7aeCxXNv/rQJ1ub0yBMfk8kY80KmepxlFknQA=;
        b=LwqCXZDyp+gCyYF1YhL6oxCSwnzgeJ5aZtDcgMqWN1ru8uHUMtvohA0tvGJidA4ohBVnqP
        eilTEI6H4aiNp/tSG1IDvSGkDT5zBePPHi89vo9bNnxtHyyL54V3CPVXG8H3VaxGImj1gB
        r2PQIAbbYCfxGR5N5tLpjGlD3dKX2DuqXt4qA+U+n0xj+BpoiH+ajTTtkedPv7p0r8kvbh
        wxwwz/lYrZC41hDzLnqmkMJBcZqZmOiLb+G8QmOEiFevU79ZdvFH+Ja0ID5tEBhXXCYREm
        WEMghpKX4O1U+6++ZEnV8xfVvaETSUbeB7vsZzthcrYHCYn8DLqxRtHW00IWWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629442459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9kl53d7aeCxXNv/rQJ1ub0yBMfk8kY80KmepxlFknQA=;
        b=eWXUgwtMEg6Gb95CGvM3ZDOWK+j2B1+o0ze18G5N6Pj6Yc9kt+bkQ+LkascSx+o8si8jx8
        gDaZKmg2rzxOQnDA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Scott Wood <swood@redhat.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rcu@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Steven Price <steven.price@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] rcutorture: Avoid problematic critical section nesting
 on RT
Message-ID: <20210820065417.epdjfqsn27gmnx4x@linutronix.de>
References: <20210811201354.1976839-1-valentin.schneider@arm.com>
 <20210811201354.1976839-2-valentin.schneider@arm.com>
 <20210817121345.5iyj5epemczn3a52@linutronix.de>
 <20210817131741.evduh4fw7vyv2dzt@linutronix.de>
 <20210817144018.nqssoq475vitrqlv@linutronix.de>
 <20b9051fe47b7068ed3496bd7f5d417b1af69e3a.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20b9051fe47b7068ed3496bd7f5d417b1af69e3a.camel@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-08-19 22:23:37 [-0500], Scott Wood wrote:
> On Tue, 2021-08-17 at 16:40 +0200, Sebastian Andrzej Siewior wrote:
> > [bigeasy: remove 'preempt_disable(); local_bh_disable(); preempt_enable();
> >  local_bh_enable();' from the examples because this works on RT now. ]
> 
> Does it actually work?  If preemption is disabled during local_bh_disable,
> softirq_ctrl.lock won't be taken.  If you then get preempted between the
> preempt_enable() and the local_bh_enable(), and another task tries to do
> local_bh_disable(), won't it successfully get softirq_ctrl.lock, add to
> softirq_ctrl.cnt, and proceed right into the critical section?
> 
> Or am I missing something?

No, I mixed it up with migrate_disable/enable. I corrected it while
redoing it yesterday.

> -Scott

Sebastian
