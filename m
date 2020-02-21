Return-Path: <SRS0=P7c/=4J=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD09C35656
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Feb 2020 16:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0975F24653
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Feb 2020 16:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgBUQvB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 Feb 2020 11:51:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:49892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726681AbgBUQvB (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 Feb 2020 11:51:01 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67F0E208C4;
        Fri, 21 Feb 2020 16:51:00 +0000 (UTC)
Date:   Fri, 21 Feb 2020 11:50:58 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Sebastian Sewior <bigeasy@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] tracing: Fix trace entry and trace common fields for
 preempt_lazy_count
Message-ID: <20200221115058.451e6f24@gandalf.local.home>
In-Reply-To: <20200221162944.GD657629@krava>
References: <20200221153541.681468-1-jolsa@kernel.org>
        <20200221104922.5ea8bb5f@gandalf.local.home>
        <20200221161030.GC657629@krava>
        <20200221112152.031b4230@gandalf.local.home>
        <20200221162944.GD657629@krava>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, 21 Feb 2020 17:29:44 +0100
Jiri Olsa <jolsa@redhat.com> wrote:

> sure, I'll probably fix it anyway, but there might be other broken tools ;-)
> 
> libtraceevent/perf is actualy ok with this, probably following the

Which is the whole point of libtraceevent. Everything should be using
it.

> offsets and sizes directly.. actualy bpftrace might be special case
> because it creates C struct out of the fields, so there's gap between
> common fields and the rest of the fields

Hmm, hopefully this can be fixed, as I really don't want wasted space
in the ring buffers.

-- Steve

