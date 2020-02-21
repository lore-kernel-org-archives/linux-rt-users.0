Return-Path: <SRS0=P7c/=4J=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F288EC35656
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Feb 2020 16:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC94824653
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Feb 2020 16:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbgBUQVz (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 Feb 2020 11:21:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:32810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727213AbgBUQVz (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 Feb 2020 11:21:55 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04A6D20578;
        Fri, 21 Feb 2020 16:21:53 +0000 (UTC)
Date:   Fri, 21 Feb 2020 11:21:52 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Sebastian Sewior <bigeasy@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] tracing: Fix trace entry and trace common fields for
 preempt_lazy_count
Message-ID: <20200221112152.031b4230@gandalf.local.home>
In-Reply-To: <20200221161030.GC657629@krava>
References: <20200221153541.681468-1-jolsa@kernel.org>
        <20200221104922.5ea8bb5f@gandalf.local.home>
        <20200221161030.GC657629@krava>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, 21 Feb 2020 17:10:30 +0100
Jiri Olsa <jolsa@redhat.com> wrote:

> On Fri, Feb 21, 2020 at 10:49:22AM -0500, Steven Rostedt wrote:
> > On Fri, 21 Feb 2020 16:35:41 +0100
> > Jiri Olsa <jolsa@kernel.org> wrote:
> >   
> > > When commit 65fd07df3588 added preempt_lazy_count into 'struct trace_entry'
> > > it did not add 4 bytes padding. Also we need to update the common fields
> > > for tracepoint, otherwise some tools (bpftrace) stop working due to missing
> > > common fields.
> > > 
> > > Fixes: 65fd07df3588 ("x86: Support for lazy preemption")
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  include/linux/trace_events.h | 2 ++
> > >  kernel/trace/trace_events.c  | 3 +++
> > >  2 files changed, 5 insertions(+)
> > > 
> > > diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> > > index f3b1ef07e4a5..51a3f5188923 100644
> > > --- a/include/linux/trace_events.h
> > > +++ b/include/linux/trace_events.h
> > > @@ -65,6 +65,8 @@ struct trace_entry {
> > >  	unsigned short		migrate_disable;
> > >  	unsigned short		padding;
> > >  	unsigned char		preempt_lazy_count;
> > > +	unsigned char		padding1;
> > > +	unsigned short		padding2;  
> > 
> > 
> > Wait! I don't have these changes in my tree, nor do I see them in
> > Linus's. This really bloats the trace events! This header is very
> > sensitive to size and just willy nilly adding to it is unacceptable.
> > It's like adding to the page_struct. This gets added to *every* event,
> > and a single byte added, causes 1M extra for a million events (very
> > common in tracing). It causes 1G extra for a billion events.  
> 
> I'm on top of:
>   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git
>   v5.4.19-rt11-rebase
> 

Ug, I now see it:

struct trace_entry {
	unsigned short		type;
	unsigned char		flags;
	unsigned char		preempt_count;
	int			pid;
	unsigned short		migrate_disable;
	unsigned short		padding;
	unsigned char		preempt_lazy_count;
};

Which adds a ton of bloat.

> > 
> > Let's find a better way to handle this.  
> 
> I can fix the bpftrace tool I guess, through it's not
> so convenient the way it's used in it

Not as inconvenient as dropping events due to wasted space in the ring
buffer. Note, this is attached to function tracing events. Any increase
here will cause more function events to be dropped.

Why is migrate disable a short? Is there going to be more that 256
nesting?

-- Steve
