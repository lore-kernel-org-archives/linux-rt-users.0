Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940AFC433ED
	for <linux-rt-users@archiver.kernel.org>; Fri, 30 Apr 2021 00:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F64A61446
	for <linux-rt-users@archiver.kernel.org>; Fri, 30 Apr 2021 00:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbhD3A3P (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 29 Apr 2021 20:29:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31880 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229519AbhD3A3M (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 29 Apr 2021 20:29:12 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-567-atfkaTJcMOGHQiTk5YFZ9g-1; Thu, 29 Apr 2021 20:28:22 -0400
X-MC-Unique: atfkaTJcMOGHQiTk5YFZ9g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E880107ACE8;
        Fri, 30 Apr 2021 00:28:20 +0000 (UTC)
Received: from lclaudio.dyndns.org (ovpn-117-234.phx2.redhat.com [10.3.117.234])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E39655DF26;
        Fri, 30 Apr 2021 00:28:19 +0000 (UTC)
Received: by lclaudio.dyndns.org (Postfix, from userid 1000)
        id 661BE3C0053; Thu, 29 Apr 2021 21:28:18 -0300 (-03)
Date:   Thu, 29 Apr 2021 21:28:18 -0300
From:   "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
To:     Daniel Wagner <wagi@monom.org>
Cc:     Joe Korty <joe.korty@concurrent-rt.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] 4.9.263-rt177: Balance local_irq_{disable,enable} in
 irq_forced_thread_fn
Message-ID: <YItPIl/SixfK+Hm1@uudg.org>
References: <20210427221009.GA23708@zipoli.concurrrent-rt.com>
 <YIiUjUo0PqJh+782@uudg.org>
 <20210428071153.meilcgaarpznqndv@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210428071153.meilcgaarpznqndv@beryllium.lan>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Apr 28, 2021 at 09:11:53AM +0200, Daniel Wagner wrote:
> Hi,
> 
> On Tue, Apr 27, 2021 at 07:47:41PM -0300, Luis Claudio R. Goncalves wrote:
> > On Tue, Apr 27, 2021 at 06:10:09PM -0400, Joe Korty wrote:
> > > Balance local_irq_{disable,enable} usage in irq_forced_thread_fn
> > > 
> > > Re: 0152-genirq-Allow-disabling-of-softirq-processing-in-irq-.patch
> > > 
> > > In 4.9.263-rt177, irq_forced_thread_fn has potentially unbalanced calls to
> > > local_irq_disable ... local_irq_enable.  This is probably not intentional.
> > > 
> > > I am not absolutely sure what the proper fix is.  Attached is an example
> > > of what that might look like.
> > > 
> > > [ Issue detected via compiler warning, using a sufficiently advanced gcc ]
> > > 
> > > Signed-off-by: Joe Korty <joe.korty@concurrent-rt.com>
> > 
> > Joe, I fell a bit behind on v4.9-rt and intend to get up to date this
> > weekend. I am now satisfied with my current backport of the futex changes
> > from v4.9.264 and my 96h of pi_stress testing.
> > 
> > Your patch makes sense, taking v4.19-rt as reference, but I will wait
> > for comments from the wise people you listed on the Cc: before taking
> > action.
> 
> I had to resolve the same merge conflict in v4.4-rt. The fix from Joe
> resolve to the same solution I've done in v4.4-rt

I will add this patch to the next v4.9-rt without the extra empty line.

Thank you both,
Luis
 
> > 
> > Best regards,
> > Luis
> > 
> > > 
> > > Index: b/kernel/irq/manage.c
> > > ===================================================================
> > > --- a/kernel/irq/manage.c
> > > +++ b/kernel/irq/manage.c
> > > @@ -1035,6 +1035,9 @@ irq_forced_thread_fn(struct irq_desc *de
> > >  		atomic_inc(&desc->threads_handled);
> > >  
> > >  	irq_finalize_oneshot(desc, action);
> > > +
> 
> Nit there is no new line here in upstream, dd652c6ab49b ("genirq:
> Disable interrupts for force threaded handlers")
> 
> > > +	if (!IS_ENABLED(CONFIG_PREEMPT_RT_BASE))
> > > +		local_irq_enable();
> > >  	/*
> > >  	 * Interrupts which have real time requirements can be set up
> > >  	 * to avoid softirq processing in the thread handler. This is
> > > @@ -1043,8 +1046,6 @@ irq_forced_thread_fn(struct irq_desc *de
> > >  	if (irq_settings_no_softirq_call(desc))
> > >  		_local_bh_enable();
> > >  	else
> > > -		if (!IS_ENABLED(CONFIG_PREEMPT_RT_BASE))
> > > -			local_irq_enable();
> > >  		local_bh_enable();
> > >  	return ret;
> > >  }
> > ---end quoted text---
> 
> Thanks,
> Daniel
---end quoted text---

