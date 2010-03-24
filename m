From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 1/2] Revert "rt: trivial fix to REMINDER block in
 init/main.c"
Date: Wed, 24 Mar 2010 14:13:07 -0400
Message-ID: <1269454387.2957.2889.camel@gandalf.stny.rr.com>
References: <1269452107-28655-1-git-send-email-jkacur@redhat.com>
	 <1269452107-28655-2-git-send-email-jkacur@redhat.com>
Reply-To: rostedt@goodmis.org
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	lkml <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Clark Williams <williams@redhat.com>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:64797 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932496Ab0CXSNK (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 24 Mar 2010 14:13:10 -0400
In-Reply-To: <1269452107-28655-2-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2010-03-24 at 18:35 +0100, John Kacur wrote:
> This reverts commit 3e39399ef4a742d994570488994be93ef17d4ef5.
> 
> CONFIG_STACK_TRACER really should not be in the reminder block.
> By default it is not enabled, and has negligible impact.

Correct, the stack trace is based off of the function tracer, which with
dynamic ftrace it does not have any extra impact when not enabled.

Hmm, maybe we should add a warning if it was set on the command line?

Anyway,

Acked-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve

> 
> Signed-off-by: John Kacur <jkacur@redhat.com>
> ---
>  init/main.c |    3 ---
>  1 files changed, 0 insertions(+), 3 deletions(-)
> 
> diff --git a/init/main.c b/init/main.c
> index 48393c0..aa48b7b 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -928,9 +928,6 @@ static int __init kernel_init(void * unused)
>  #ifdef CONFIG_PREEMPT_TRACER
>  	printk(KERN_ERR "*        CONFIG_PREEMPT_TRACER                                              *\n");
>  #endif
> -#ifdef CONFIG_STACK_TRACER
> -	printk(KERN_ERR "*        CONFIG_STACK_TRACER                                                *\n");
> -#endif
>  #if defined(CONFIG_FTRACE) && !defined(CONFIG_FTRACE_MCOUNT_RECORD)
>  	printk(KERN_ERR "*        CONFIG_FTRACE                                                      *\n");
>  #endif


