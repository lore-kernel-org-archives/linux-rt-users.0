Return-Path: <SRS0=s/eb=RQ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD0BC43381
	for <linux-rt-users@archiver.kernel.org>; Wed, 13 Mar 2019 13:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F4852177E
	for <linux-rt-users@archiver.kernel.org>; Wed, 13 Mar 2019 13:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbfCMNUz (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 13 Mar 2019 09:20:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:38402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbfCMNUy (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 13 Mar 2019 09:20:54 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 761792087C;
        Wed, 13 Mar 2019 13:20:53 +0000 (UTC)
Date:   Wed, 13 Mar 2019 09:20:51 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Tom Zanussi <zanussi@kernel.org>, tglx@linutronix.de,
        namhyung@kernel.org, bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [RFC PATCH 1/7] tracing/probe: Check maxactive error cases
Message-ID: <20190313092051.77d04675@gandalf.local.home>
In-Reply-To: <155248006270.10815.14600382508884855084.stgit@devnote2>
References: <155248005229.10815.334731901778152247.stgit@devnote2>
        <155248006270.10815.14600382508884855084.stgit@devnote2>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, 13 Mar 2019 21:27:42 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Check maxactive on kprobe error case, because maxactive
> is only for kretprobe, not for kprobe. Also, maxactive
> should not be 0, it should be at least 1.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  kernel/trace/trace_kprobe.c |   10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index d5fb09ebba8b..d47e12596f12 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -624,7 +624,11 @@ static int trace_kprobe_create(int argc, const char *argv[])
>  	if (event)
>  		event++;
>  
> -	if (is_return && isdigit(argv[0][1])) {
> +	if (isdigit(argv[0][1])) {
> +		if (!is_return) {
> +			pr_info("Maxactive is not for kprobe");

So now 'p1:..." will error out and not just be ignored?

-- Steve

> +			return -EINVAL;
> +		}
>  		if (event)
>  			len = event - &argv[0][1] - 1;
>  		else
> @@ -634,8 +638,8 @@ static int trace_kprobe_create(int argc, const char *argv[])
>  		memcpy(buf, &argv[0][1], len);
>  		buf[len] = '\0';
>  		ret = kstrtouint(buf, 0, &maxactive);
> -		if (ret) {
> -			pr_info("Failed to parse maxactive.\n");
> +		if (ret || !maxactive) {
> +			pr_info("Invalid maxactive number\n");
>  			return ret;
>  		}
>  		/* kretprobes instances are iterated over via a list. The

