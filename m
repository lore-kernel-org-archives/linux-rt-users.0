Return-Path: <SRS0=c0v5=6H=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D28EC55186
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Apr 2020 13:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4639320857
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Apr 2020 13:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbgDWNGE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 23 Apr 2020 09:06:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:45098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726685AbgDWNGE (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 23 Apr 2020 09:06:04 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35B572076C;
        Thu, 23 Apr 2020 13:06:03 +0000 (UTC)
Date:   Thu, 23 Apr 2020 09:06:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Daniel Wagner <dwagner@suse.de>
Subject: Re: [PREEMPT_RT] 8250 IRQ lockup when flooding serial console (was
 Re: [ANNOUNCE] v5.4.28-rt19)
Message-ID: <20200423090601.2439e64f@gandalf.local.home>
In-Reply-To: <20200423104559.rgplz6rqk6sg4kz7@linutronix.de>
References: <20200330144712.cwcz5ejal4ankeoi@linutronix.de>
        <nycvar.YEU.7.76.2004231017470.4730@gjva.wvxbf.pm>
        <nycvar.YFH.7.76.2004231111550.19713@cbobk.fhfr.pm>
        <20200423104559.rgplz6rqk6sg4kz7@linutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, 23 Apr 2020 12:45:59 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2020-04-23 11:12:59 [+0200], Jiri Kosina wrote:
> > On Thu, 23 Apr 2020, Jiri Kosina wrote:
> >   
> > > > I'm pleased to announce the v5.4.28-rt19 patch set.   
> > > 
> > > First, I don't believe this is necessarily a regression coming with this 
> > > particular version, but this is the first kernel where I tried this and it 
> > > crashed.  
> > 
> > I just tried with 5.6.4-rt3, and I can make it explode exactly the same 
> > way:  
> 
> I though I dealt with it. In the past it triggered also with threadirqs
> on !RT but this isn't the case anymore. It still explodes on RT. Let me
> look…

Good, something to look for as a backport ;-)

BTW, I haven't released a new 5.4-rt because the default one is triggering
a large latency somewhere, and makes my tests fail. I'm trying to dig into
the cause when I get time.

-- Steve
