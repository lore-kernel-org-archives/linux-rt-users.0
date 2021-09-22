Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFD2C433EF
	for <linux-rt-users@archiver.kernel.org>; Wed, 22 Sep 2021 13:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62717611C0
	for <linux-rt-users@archiver.kernel.org>; Wed, 22 Sep 2021 13:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbhIVNEH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 22 Sep 2021 09:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbhIVNEG (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 22 Sep 2021 09:04:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB419C061574;
        Wed, 22 Sep 2021 06:02:36 -0700 (PDT)
Date:   Wed, 22 Sep 2021 15:02:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632315753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h80mGahjWAPAQCwA1UEeNw0vIPRf5vV9P1wK+v0qIF4=;
        b=nlSPxJn5EL0FCUhl1E+4vZO2DXsHZT6LTX+M5xPUG11+7ICfgOiP9//Z3NIJK9RWuV+fVz
        Zead/ZCyoLMA2YW6kCibflDUZ+YhBoUpPMEFWxNNtrM2eKDL49IvYU236dOGhK8Q01jl+F
        BbTmOeEeO1RVhb8ZzYvDEfOR15Q7fAs/tnsbseypRhb8ccLndqpasxqZwMsNTAu73t7dLP
        CqbUv56ihCRnlYFCqPeY35jW5gzmgjTSm2EaPzOnxzE08QXp+zciNpoW0ZD2dIdaIogZf0
        vv+eVNbhyZoMr1ifnJ5TFahFYV62Y0tSmUJRS90Rj3UUoSko71J6X6XXcIawvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632315753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h80mGahjWAPAQCwA1UEeNw0vIPRf5vV9P1wK+v0qIF4=;
        b=zN6Rqxt1YMi5qIJBlwqj5QSghKz+ZowFfgLur6kgKBMLUFuQhzw21oNBJ6jZnhVPOT7fhx
        GkGntCws2WChlpCQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rcu@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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
Subject: Re: rcu/tree: Protect rcu_rdp_is_offloaded() invocations on RT
Message-ID: <20210922130232.vm7rgkdszfhejf34@linutronix.de>
References: <20210811201354.1976839-1-valentin.schneider@arm.com>
 <20210811201354.1976839-4-valentin.schneider@arm.com>
 <874kae6n3g.ffs@tglx>
 <87pmt163al.ffs@tglx>
 <20210921234518.GB100318@lothringen>
 <20210922063208.ltf7sdou4tr5yrnc@linutronix.de>
 <20210922111012.GA106513@lothringen>
 <20210922112731.dvauvxlhx5suc7qd@linutronix.de>
 <20210922113820.GC106513@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210922113820.GC106513@lothringen>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-09-22 13:38:20 [+0200], Frederic Weisbecker wrote:
> > The part with rcutree.use_softirq=0 on RT does not make it any better,
> > right?
> 
> The rcuc kthread disables softirqs before calling rcu_core(), so it behaves
> pretty much the same as a softirq. Or am I missing something?

Oh, no you don't.

> > So you rely on some implicit behaviour which breaks with RT such as:
> > 
> >                               CPU 0
> >            -----------------------------------------------
> >            RANDOM TASK-A                      RANDOM TASK-B
> >            ------                             -----------
> >            int *X = &per_cpu(CPUX, 0)         int *X = &per_cpu(CPUX, 0)
> >            int A, B;                          
> > 					      spin_lock(&D);
> >            spin_lock(&C);
> > 	   				      WRITE_ONCE(*X, 0);
> >            A = READ_ONCE(*X);
> >                                               WRITE_ONCE(*X, 1);
> >            B = READ_ONCE(*X);
> > 
> > while spinlock C and D are just random locks not related to CPUX but it
> > just happens that they are held at that time. So for !RT you guarantee
> > that A == B while it is not the case on RT.
> 
> Not sure which spinlocks you are referring to here. Also most RCU spinlocks
> are raw.

I was bringing an example where you also could rely on implicit locking
provided by spin_lock() which breaks on RT.

Sebastian
