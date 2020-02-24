Return-Path: <SRS0=opgi=4M=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F57EC35679
	for <linux-rt-users@archiver.kernel.org>; Mon, 24 Feb 2020 10:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6202320726
	for <linux-rt-users@archiver.kernel.org>; Mon, 24 Feb 2020 10:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgBXKBH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 24 Feb 2020 05:01:07 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49332 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgBXKBG (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 24 Feb 2020 05:01:06 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1j6AXw-0007ak-Iq; Mon, 24 Feb 2020 11:01:04 +0100
Date:   Mon, 24 Feb 2020 11:01:04 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>,
        linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH RT] tracing: make preempt_lazy and migrate_disable
 counter smaller
Message-ID: <20200224100104.sbupmfe2oehmsrrb@linutronix.de>
References: <20200221153541.681468-1-jolsa@kernel.org>
 <20200221104922.5ea8bb5f@gandalf.local.home>
 <20200221161030.GC657629@krava>
 <20200221112152.031b4230@gandalf.local.home>
 <20200221163735.53wt2fqoajcuj2js@linutronix.de>
 <20200221174419.7r5zxfkvz4yrndi2@linutronix.de>
 <20200221204957.GE657629@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200221204957.GE657629@krava>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-02-21 21:49:57 [+0100], Jiri Olsa wrote:
> On Fri, Feb 21, 2020 at 06:44:19PM +0100, Sebastian Andrzej Siewior wrote:
> > The migrate_disable counter should not exceed 255 so it is enough to
> > store it in an 8bit field.
> > With this change we can move the `preempt_lazy_count' member into the
> > gap so the whole struct shrinks by 4 bytes to 12 bytes in total.
> > 
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
> >  include/linux/trace_events.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> > index f3b1ef07e4a5f..c8b3f06cb5ed7 100644
> > --- a/include/linux/trace_events.h
> > +++ b/include/linux/trace_events.h
> > @@ -62,9 +62,9 @@ struct trace_entry {
> >  	unsigned char		flags;
> >  	unsigned char		preempt_count;
> >  	int			pid;
> > -	unsigned short		migrate_disable;
> > -	unsigned short		padding;
> > +	unsigned char		migrate_disable;
> >  	unsigned char		preempt_lazy_count;
> > +	unsigned short		padding;
> 
> also we still need to put preempt_lazy_count as common field:
> 
> 	__common_field(unsigned char,  preempt_lazy_count);

so I need to update the struct as I did (and drop the padding field like
Steven suggested) and then do the "same" change to
"trace_define_common_fields" ?

> 
> jirka

Sebastian
