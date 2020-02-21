Return-Path: <SRS0=P7c/=4J=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B10C35669
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Feb 2020 20:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8647C206ED
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Feb 2020 20:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgBUUU5 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 Feb 2020 15:20:57 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46693 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgBUUU5 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 Feb 2020 15:20:57 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1j5En7-0000qv-Tg; Fri, 21 Feb 2020 21:20:53 +0100
Date:   Fri, 21 Feb 2020 21:20:53 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH RT] tracing: make preempt_lazy and migrate_disable
 counter smaller
Message-ID: <20200221202053.egb5mv62fisdvk2f@linutronix.de>
References: <20200221153541.681468-1-jolsa@kernel.org>
 <20200221104922.5ea8bb5f@gandalf.local.home>
 <20200221161030.GC657629@krava>
 <20200221112152.031b4230@gandalf.local.home>
 <20200221163735.53wt2fqoajcuj2js@linutronix.de>
 <20200221174419.7r5zxfkvz4yrndi2@linutronix.de>
 <20200221145148.26d9550b@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200221145148.26d9550b@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-02-21 14:51:48 [-0500], Steven Rostedt wrote:
> On Fri, 21 Feb 2020 18:44:19 +0100
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
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
> >  };
> 
> Do we really need the padding here?

Not really. The two bytes are consumed since there is __packed so that
padding makes it just more obvious. However that padding wasn't used in
the past. I can remove it if you want.
The struct can't be __packed to save additional two bytes, correct?

> -- Steve

Sebastian
