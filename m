Return-Path: <SRS0=oqvG=4I=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE3DC11D24
	for <linux-rt-users@archiver.kernel.org>; Thu, 20 Feb 2020 22:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71B56208CD
	for <linux-rt-users@archiver.kernel.org>; Thu, 20 Feb 2020 22:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbgBTWsE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 20 Feb 2020 17:48:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:43968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727845AbgBTWsD (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 20 Feb 2020 17:48:03 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0F45207FD;
        Thu, 20 Feb 2020 22:48:02 +0000 (UTC)
Date:   Thu, 20 Feb 2020 17:48:01 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Tom Zanussi <zanussi@kernel.org>, artem.bityutskiy@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 1/2] tracing: Fix synth event test to avoid using
 smp_processor_id()
Message-ID: <20200220174801.2b793ae1@gandalf.local.home>
In-Reply-To: <158193314931.8868.11386672578933699881.stgit@devnote2>
References: <158193313870.8868.10793333111731425487.stgit@devnote2>
        <158193314931.8868.11386672578933699881.stgit@devnote2>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, 17 Feb 2020 18:52:29 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Since smp_processor_id() requires irq-disabled or preempt-disabled,
> synth event generation test module made some warnings. To prevent
> that, use get_cpu()/put_cpu() instead of smp_processor_id().
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  kernel/trace/synth_event_gen_test.c |   23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
>

I just noticed this patch, after applying my version that just uses the
raw_smp_processor_id(). We don't really care what CPU it is do we?

I didn't want a test to muck with preemption disabling and all that fun.

-- Steve
