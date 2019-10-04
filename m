Return-Path: <SRS0=K3q3=X5=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E845C47404
	for <linux-rt-users@archiver.kernel.org>; Fri,  4 Oct 2019 16:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20DBB222BE
	for <linux-rt-users@archiver.kernel.org>; Fri,  4 Oct 2019 16:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbfJDQaq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 4 Oct 2019 12:30:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37365 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfJDQaq (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 4 Oct 2019 12:30:46 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iGQTa-0007bq-JS; Fri, 04 Oct 2019 18:30:42 +0200
Date:   Fri, 4 Oct 2019 18:30:42 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Daniel Wagner <dwagner@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: vmalloc: Use the vmap_area_lock to protect
 ne_fit_preload_node
Message-ID: <20191004163042.jpiau6dlxqylbpfh@linutronix.de>
References: <20191003090906.1261-1-dwagner@suse.de>
 <20191004153728.c5xppuqwqcwecbe6@linutronix.de>
 <20191004162041.GA30806@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191004162041.GA30806@pc636>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-10-04 18:20:41 [+0200], Uladzislau Rezki wrote:
> On Fri, Oct 04, 2019 at 05:37:28PM +0200, Sebastian Andrzej Siewior wrote:
> > If you post something that is related to PREEMPT_RT please keep tglx and
> > me in Cc.
> > 
> > On 2019-10-03 11:09:06 [+0200], Daniel Wagner wrote:
> > > Replace preempt_enable() and preempt_disable() with the vmap_area_lock
> > > spin_lock instead. Calling spin_lock() with preempt disabled is
> > > illegal for -rt. Furthermore, enabling preemption inside the
> > 
> > Looking at it again, I have reasonable doubt that this
> > preempt_disable() is needed.
> > 
> The intention was to preload a current CPU with one extra object in
> non-atomic context, thus to use GFP_KERNEL permissive parameters. I.e.
> that allows us to avoid any allocation(if we stay on the same CPU)
> when we are in atomic context do splitting.

You could have been migrated to another CPU before the first
preempt_disable(). You could have been migrated to another CPU while
memory has been allocated.
I don't really see the point of that preempt_disable() besides keeping
debug code quiet.

> If we have migrate_disable/enable, then, i think preempt_enable/disable
> should be replaced by it and not the way how it has been proposed
> in the patch.

I don't think this patch is appropriate for upstream.

Sebastian
