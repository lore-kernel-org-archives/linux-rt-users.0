Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3653C4338F
	for <linux-rt-users@archiver.kernel.org>; Fri, 20 Aug 2021 04:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1C0860F9F
	for <linux-rt-users@archiver.kernel.org>; Fri, 20 Aug 2021 04:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbhHTEML (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 20 Aug 2021 00:12:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55768 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230508AbhHTEML (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 20 Aug 2021 00:12:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629432689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0XvUZ+5BWgTwpJh88VGaw844XRBWGMqqjISDFqgaRlY=;
        b=MDaRtGfUx9y8afzMzDRRb5sw1oNK6h2Tuyes/5wt+kfONyLCIrCkSvgH0f7il7n5ft7sih
        YcngGfpEL5qhGyoL0J9mn7yzy5cxlVU4/ZqZ7m+fHXwCLDV+QsLHuJTxbLUD4mk+GkB3jt
        +TwtRTJ9MJ7UjNzutn3viel+uZmZpsI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-Ux-jbRLdMxOdAUcuOKHHpg-1; Fri, 20 Aug 2021 00:11:22 -0400
X-MC-Unique: Ux-jbRLdMxOdAUcuOKHHpg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF6911008070;
        Fri, 20 Aug 2021 04:11:19 +0000 (UTC)
Received: from ovpn-113-78.phx2.redhat.com (ovpn-113-78.phx2.redhat.com [10.3.113.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EA11A189C4;
        Fri, 20 Aug 2021 04:11:12 +0000 (UTC)
Message-ID: <561ab28b18c31fbc221f4cb0c4df6db9b0538675.camel@redhat.com>
Subject: Re: [PATCH] rcutorture: Avoid problematic critical section nesting
 on RT
From:   Scott Wood <swood@redhat.com>
To:     paulmck@kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rcu@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
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
Date:   Thu, 19 Aug 2021 23:11:12 -0500
In-Reply-To: <20210819182035.GF4126399@paulmck-ThinkPad-P17-Gen-1>
References: <20210811201354.1976839-1-valentin.schneider@arm.com>
         <20210811201354.1976839-2-valentin.schneider@arm.com>
         <20210817121345.5iyj5epemczn3a52@linutronix.de>
         <20210817131741.evduh4fw7vyv2dzt@linutronix.de>
         <20210817144018.nqssoq475vitrqlv@linutronix.de>
         <20210818224651.GY4126399@paulmck-ThinkPad-P17-Gen-1>
         <20210819153927.clqxr4f7qegpflbr@linutronix.de>
         <20210819154708.3efz6jtgwtuhpeds@linutronix.de>
         <20210819182035.GF4126399@paulmck-ThinkPad-P17-Gen-1>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, 2021-08-19 at 11:20 -0700, Paul E. McKenney wrote:
> On Thu, Aug 19, 2021 at 05:47:08PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2021-08-19 17:39:29 [+0200], To Paul E. McKenney wrote:
> > > +	/*
> > > +	 * Ideally these sequences would be detected in debug builds
> > > +	 * (regardless of RT), but until then don't stop testing
> > > +	 * them on non-RT.
> > > +	 */
> > > +	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> > > +		/*
> > > +		 * Can't release the outermost rcu lock in an irq disabled
> > > +		 * section without preemption also being disabled, if irqs
> > > +		 * had ever been enabled during this RCU critical section
> > > +		 * (could leak a special flag and delay reporting the qs).
> > > +		 */
> > > +		if ((oldmask & RCUTORTURE_RDR_RCU) &&
> > > +		    (mask & RCUTORTURE_RDR_IRQ) &&
> > > +		    !(mask & preempts))
> > > +			mask |= RCUTORTURE_RDR_RCU;
> > 
> > This piece above, I don't understand. I had it running for a while and
> > it didn't explode. Let me try TREE01 for 30min without that piece.
> 
> This might be historical.  There was a time when interrupts being
> disabled across rcu_read_unlock() meant that preemption had to have
> been disabled across the entire RCU read-side critical section.
> 
> I am not seeing a purpose for it now, but I could easily be missing
> something, especially given my tenuous grasp of RT.

Yeah, I think this was to deal with not having the irq work stuff in RT
at the time.

-Scott

