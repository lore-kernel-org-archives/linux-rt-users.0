From: Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH RT] disable preemption on running show all regs.
Date: Tue, 19 Jun 2007 13:57:13 -0700
Message-ID: <1182286634.18168.48.camel@imap.mvista.com>
References: <1182284276.15228.25.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:21834 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752860AbXFSVAs (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 19 Jun 2007 17:00:48 -0400
In-Reply-To: <1182284276.15228.25.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2007-06-19 at 16:17 -0400, Steven Rostedt wrote:
> The show all regs sysrq uses the nmi function to do it. But this
> function expects preemption to be off, or funny things happen.
> 
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> 
> Index: linux-2.6.21-rt9/drivers/char/sysrq.c
> ===================================================================
> --- linux-2.6.21-rt9.orig/drivers/char/sysrq.c
> +++ linux-2.6.21-rt9/drivers/char/sysrq.c
> @@ -213,7 +213,9 @@ static struct sysrq_key_op sysrq_showreg
>  
>  static void sysrq_handle_showallregs(int key, struct tty_struct *tty)
>  {
> +        preempt_disable();
>  	nmi_show_all_regs();
> +        preempt_enable();
>  }

Looks like you have a whitespace issue here.. Should be tabs, not
spaces.

Daniel
