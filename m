Return-Path: <SRS0=7Euv=5F=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7502C4332E
	for <linux-rt-users@archiver.kernel.org>; Fri, 20 Mar 2020 00:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A78C32076C
	for <linux-rt-users@archiver.kernel.org>; Fri, 20 Mar 2020 00:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbgCTAtC (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 19 Mar 2020 20:49:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgCTAtC (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 19 Mar 2020 20:49:02 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8005620754;
        Fri, 20 Mar 2020 00:49:00 +0000 (UTC)
Date:   Thu, 19 Mar 2020 20:48:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     ben.hutchings@codethink.co.uk, Chris.Paterson2@renesas.com,
        bigeasy@linutronix.de, LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: Re: 4.19.106-rt44 -- boot problems with irqwork: push most work
 into softirq context
Message-ID: <20200319204859.5011a488@gandalf.local.home>
In-Reply-To: <20200319232225.GA7878@duo.ucw.cz>
References: <20200228170837.3fe8bb57@gandalf.local.home>
        <20200319214835.GA29781@duo.ucw.cz>
        <20200319232225.GA7878@duo.ucw.cz>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, 20 Mar 2020 00:22:25 +0100
Pavel Machek <pavel@denx.de> wrote:

> On Thu 2020-03-19 22:48:35, Pavel Machek wrote:
> > Hi!

Hi Pavel!

> >   
> > > I'm pleased to announce the 4.19.106-rt44 stable release.
> > > 
> > > 
> > > This release is just an update to the new stable 4.19.106 version
> > > and no RT specific changes have been made.
> > > 
> > > 
> > > You can get this release via the git tree at:
> > > 
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
> > > 
> > >   branch: v4.19-rt
> > >   Head SHA1: 0f2960c75dd68d339f0aff2935f51652b5625fbf  
> > 
> > This brought some problems for me. de0-nano board now fails to boot in
> > cca 50% of cases if I move these patches on top of -cip tree.
> > 
> > This is example of failed job:
> > 
> > https://lava.ciplatform.org/scheduler/job/13037
> > 
> > de0-nano is 32-bit arm, should be based on Altera SoCFPGA if I understand
> > things correctly.
> > 
> > "fc9f4631a290 irqwork: push most work into softirq context" touches
> > area of the panic above. I tried to revert it on top of the full
> > series, and tests passed twice so far...  
> 
> Test passed 7 times now. So yes, reverting this fixes de0-nano
> boot. Any ideas what might be wrong?
> 
> I'll be running it few more times.
> 
> https://gitlab.com/cip-project/cip-kernel/linux-cip/pipelines/127953471
> 

Looks like you are running this without PREEMPT_RT enabled.

Does this patch help?

-- Steve


diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 2940622da5b3..0ca75c77536b 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -146,8 +146,9 @@ bool irq_work_needs_cpu(void)
 	raised = this_cpu_ptr(&raised_list);
 	lazy = this_cpu_ptr(&lazy_list);
 
-	if (llist_empty(raised) && llist_empty(lazy))
-		return false;
+	if (llist_empty(raised) || arch_irq_work_has_interrupt())
+		if (llist_empty(lazy))
+			return false;
 
 	/* All work should have been flushed before going offline */
 	WARN_ON_ONCE(cpu_is_offline(smp_processor_id()));
