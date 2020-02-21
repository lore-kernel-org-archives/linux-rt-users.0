Return-Path: <SRS0=P7c/=4J=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC5CC35663
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Feb 2020 19:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B17E24650
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Feb 2020 19:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgBUTvv (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 Feb 2020 14:51:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:43654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbgBUTvv (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 Feb 2020 14:51:51 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C2C220722;
        Fri, 21 Feb 2020 19:51:50 +0000 (UTC)
Date:   Fri, 21 Feb 2020 14:51:48 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH RT] tracing: make preempt_lazy and migrate_disable
 counter smaller
Message-ID: <20200221145148.26d9550b@gandalf.local.home>
In-Reply-To: <20200221174419.7r5zxfkvz4yrndi2@linutronix.de>
References: <20200221153541.681468-1-jolsa@kernel.org>
        <20200221104922.5ea8bb5f@gandalf.local.home>
        <20200221161030.GC657629@krava>
        <20200221112152.031b4230@gandalf.local.home>
        <20200221163735.53wt2fqoajcuj2js@linutronix.de>
        <20200221174419.7r5zxfkvz4yrndi2@linutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, 21 Feb 2020 18:44:19 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index f3b1ef07e4a5f..c8b3f06cb5ed7 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -62,9 +62,9 @@ struct trace_entry {
>  	unsigned char		flags;
>  	unsigned char		preempt_count;
>  	int			pid;
> -	unsigned short		migrate_disable;
> -	unsigned short		padding;
> +	unsigned char		migrate_disable;
>  	unsigned char		preempt_lazy_count;
> +	unsigned short		padding;
>  };

Do we really need the padding here?

-- Steve
