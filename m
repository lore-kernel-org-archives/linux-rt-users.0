From: Daniel Walker <dwalker@mvista.com>
Subject: Re: BUG: at kernel/sched.c:4031 __schedule()
Date: Thu, 07 Jun 2007 09:33:57 -0700
Message-ID: <1181234037.11539.41.camel@imap.mvista.com>
References: <4668112B.4090406@gmail.com>
	 <1181230780.10408.0.camel@localhost.localdomain>
	 <1181231910.3841.55.camel@bender>
	 <1181232783.10408.8.camel@localhost.localdomain>
	 <1181233286.11539.38.camel@imap.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jan Altenberg <jan.altenberg@linutronix.de>,
	Oleg Kechin <okechin@gmail.com>,
	linux-rt-users@vger.kernel.org, tglx@linutronix.de
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.158]:30549 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1752341AbXFGQhA (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 7 Jun 2007 12:37:00 -0400
In-Reply-To: <1181233286.11539.38.camel@imap.mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2007-06-07 at 09:21 -0700, Daniel Walker wrote:
> .
> 
> + *
> + * The new debugging code in __schedule() expects that interrupts
> + * are disabled across a switch_to. Need to investigate which
> + * consequences this has.
>   */
> -#if 0 // preempt_rt hack, because warn_on in shedule.c triggers
> +#ifndef CONFIG_PREEMPT_RT
>  #define __ARCH_WANT_INTERRUPTS_ON_CTXSW
>  #endif
> 

It is starting to look like a real fix now, thanks for updating it
Thomas .

Daniel
