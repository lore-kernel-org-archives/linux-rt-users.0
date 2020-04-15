Return-Path: <SRS0=USbd=57=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DBCC2BA19
	for <linux-rt-users@archiver.kernel.org>; Wed, 15 Apr 2020 11:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 738B920732
	for <linux-rt-users@archiver.kernel.org>; Wed, 15 Apr 2020 11:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896807AbgDOLNC (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 15 Apr 2020 07:13:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49465 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2896797AbgDOLMp (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 15 Apr 2020 07:12:45 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jOfy8-0007Ia-4g; Wed, 15 Apr 2020 13:12:36 +0200
Date:   Wed, 15 Apr 2020 13:12:35 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Juri Lelli <juri.lelli@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.6.2-rt1
Message-ID: <20200415111235.6gomftgifn62dylp@linutronix.de>
References: <20200403170443.pzm24672qo4hufcm@linutronix.de>
 <20200408070013.GB14300@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200408070013.GB14300@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-04-08 09:00:13 [+0200], Juri Lelli wrote:
> Hi,
Hi,

> On 03/04/20 19:04, Sebastian Andrzej Siewior wrote:
> > Dear RT folks!
> > 
> > I'm pleased to announce the v5.6.2-rt1 patch set. 
> > 
> > Changes since v5.4.28-rt19:
> > 
> >   - Rebase to v5.6.2
> 
> I was reviewing the new set and I couldn't find v5.4.28-rt19
> 6dbbc833c99f ("mm: perform lru_add_drain_all() remotely"). Don't think
> it has been squashed either.
> 
> Am I wrong? If not, why was that left out?

I was going to drop it from v5.4 but kept it last minute. I announced in
	https://lkml.kernel.org/r/20200309171350.kjb3pdjazhxm2li2@linutronix.de

that the problem it fixes is not limited to RT so we need a solution for
both config switches. The current plan for local-locks is not to work
cross CPU because it breaks the local_irq_save() / preempt_disable()
replacement which is something this patch relies on.
The worker triggered via vmstat_update() is also blocked if the user
task runs at an elevated priority for longer time.

> Thanks!
> 
> Juri

Sebastian
