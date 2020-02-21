Return-Path: <SRS0=P7c/=4J=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1E3C35646
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Feb 2020 16:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C90CB2067D
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Feb 2020 16:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgBUQhi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 Feb 2020 11:37:38 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46270 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgBUQhi (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 Feb 2020 11:37:38 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1j5BJ1-0006PN-HA; Fri, 21 Feb 2020 17:37:35 +0100
Date:   Fri, 21 Feb 2020 17:37:35 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] tracing: Fix trace entry and trace common fields for
 preempt_lazy_count
Message-ID: <20200221163735.53wt2fqoajcuj2js@linutronix.de>
References: <20200221153541.681468-1-jolsa@kernel.org>
 <20200221104922.5ea8bb5f@gandalf.local.home>
 <20200221161030.GC657629@krava>
 <20200221112152.031b4230@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200221112152.031b4230@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-02-21 11:21:52 [-0500], Steven Rostedt wrote:
…
> struct trace_entry {
> 	unsigned short		type;
> 	unsigned char		flags;
> 	unsigned char		preempt_count;
> 	int			pid;
> 	unsigned short		migrate_disable;
> 	unsigned short		padding;
> 	unsigned char		preempt_lazy_count;
> };
> 
> Which adds a ton of bloat.
…
> Why is migrate disable a short? Is there going to be more that 256
> nesting?

I don't think so. We go now and then > 10 and the trace file shows only
one digit. So I think that migrate_disable can use a byte field
here.
So we make migrate_disable and preempt_lazy_count a `char' type and keep
the `short' padding later on?

> -- Steve

Sebastian
