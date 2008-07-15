From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] ftrace: Actually call function pointer in ftrace_stop
Date: Tue, 15 Jul 2008 13:33:54 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0807151330540.12619@gandalf.stny.rr.com>
References: <1216134569.1014.1.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: Josh Triplett <josht@linux.vnet.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:54326 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753296AbYGORd4 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 15 Jul 2008 13:33:56 -0400
In-Reply-To: <1216134569.1014.1.camel@josh-work.beaverton.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


(CC'd Ingo and Thomas)

On Tue, 15 Jul 2008, Josh Triplett wrote:

>
> ftrace_stop used a function pointed as a no-op expression, rather than
> actually calling it.
>
> Signed-off-by: Josh Triplett <josh@kernel.org>
> ---
>  kernel/trace/trace.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 0a38f84..5f7f421 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -3283,7 +3283,7 @@ void ftrace_stop(void)
>  	if (tr->ctrl) {
>  		tr->ctrl = 0;
>  		if (saved_tracer && saved_tracer->ctrl_update)
> -			saved_tracer->ctrl_update;
> +			saved_tracer->ctrl_update(tr);
>  	}
>
>

Good catch. This patch is for -rt only. It covers a change I did for
Thomas. Thomas is currently handling the 24 and 25 queues.

-- Steve

P.S. You should CC lkml too, but make sure you use [PATCH RT] to
differentiate it from mainline patches.

