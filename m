Return-Path: <SRS0=yCAb=37=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DD2C35242
	for <linux-rt-users@archiver.kernel.org>; Tue, 11 Feb 2020 20:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA1D320842
	for <linux-rt-users@archiver.kernel.org>; Tue, 11 Feb 2020 20:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581451579;
	bh=hKlaBGAcDtCZzXr/VXWsDGOk9uMWMQUv0CbXBLU4re0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=yJe2xPNJ1uHbqfycPRHgilcr1/hKl608I1VXVWIEW8Ar7rX10t9KxRgZtjtsBVmd1
	 OtjnS2MMeLQdsCPn3jonyKEiK+a5ulI/ctkyWOkKkwxNssFU9uUcapqYu196bqvbtX
	 tA4RHsWbwtJ/VSNUt3tG12sGY1EVLG9Nof2poiF0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729948AbgBKUGT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 11 Feb 2020 15:06:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:56770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727682AbgBKUGT (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 11 Feb 2020 15:06:19 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B158F206ED;
        Tue, 11 Feb 2020 20:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581451579;
        bh=hKlaBGAcDtCZzXr/VXWsDGOk9uMWMQUv0CbXBLU4re0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=wTpbbhScCUHG0RTGw1ZvnCPlqPTIvrZKn7dncslY2y10aT9ws86jSCm7EPeEh8Rb+
         V4V+1AukBxfFGFkF24H0uoQv6FsowrepLVUS7hEmjjOdqrjL4ww2CNNtIdxTX/69OM
         OhcV7WMzBF2oN/KreQQ3OnpW5f2rCHdBPjHc66+M=
Message-ID: <1581451577.3636.5.camel@kernel.org>
Subject: Re: [PATCH 4.14-rt] Fix wrong-variable use in
 irq_set_affinity_notifier
From:   Tom Zanussi <zanussi@kernel.org>
To:     Joe Korty <joe.korty@concurrent-rt.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>
Date:   Tue, 11 Feb 2020 14:06:17 -0600
In-Reply-To: <20200211184006.GA53490@zipoli.concurrent-rt.com>
References: <20200211140007.GA6791@zipoli.concurrent-rt.com>
         <20200211174915.mh5bntkysztjmjdd@linutronix.de>
         <20200211184006.GA53490@zipoli.concurrent-rt.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Joe,

On Tue, 2020-02-11 at 13:40 -0500, Joe Korty wrote:
> On Tue, Feb 11, 2020 at 06:49:15PM +0100, Sebastian Andrzej Siewior
> wrote:
> > On 2020-02-11 09:00:07 [-0500], Joe Korty wrote:
> > > 4.14-rt: Fix wrong-variable use in irq_set_affinity_notifier.
> > > 
> > > The bug was introduced in the 4.14-rt patch
> > >  
> > >    0461-genirq-Handle-missing-work_struct-in-
> > > irq_set_affinit.patch
> > > 
> > > The symptom is a NULL pointer panic in the i40e driver on
> > > system shutdown.
> > 
> > ???
> > > 4.19-rt and above do not have this problem due to a refactoring.
> > 
> > That would be Tom's to pick. Is v4.14-RT the only one affected? I
> > was
> > under the impression that we fixed it already in each stable rt
> > tree.
> 
> A quick grep of all the -rt patch files in kernel.org/../projects/rt,
> newer
> than May, 2019, shows that 4.14 is the only one needing a fix.
> 

Yeah, what happened here was that I screwed up when fixing a merge
conflict, and inadvertently changed old_notify->work to notify->work in
the fix.

Thanks for pointing this out - I'll include your patch doing the right
thing in the next update, coming up shortly..

Tom

>     patch-4.14.170-rt74.patch.xz:
>     +		kthread_cancel_work_sync(&notify->work);
>     patch-4.4.208-rt191.patch.xz:
>     patch-3.18.18-rt15.patch.xz:
>     patch-5.0.21-rt16.patch.xz:
>     patch-5.2.21-rt14.patch.xz:
>     patch-5.4.17-rt9.patch.xz:
>     patch-4.9.201-rt134.patch.xz:
> 
> > 
> > > Signed-off-by: Joe Korty <Joe.Korty@concurrent-rt.com>
> > > 
> > > Index: b/kernel/irq/manage.c
> > > =================================================================
> > > ==
> > > --- a/kernel/irq/manage.c
> > > +++ b/kernel/irq/manage.c
> > > @@ -353,7 +353,7 @@ irq_set_affinity_notifier(unsigned int i
> > >  
> > >  	if (old_notify) {
> > >  #ifdef CONFIG_PREEMPT_RT_BASE
> > > -		kthread_cancel_work_sync(&notify->work);
> > > +		kthread_cancel_work_sync(&old_notify->work);
> > >  #else
> > >  		cancel_work_sync(&old_notify->work);
> > >  #endif
> > 
> > Sebastian
> 
> 
