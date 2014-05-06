From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch 1/6] preempt_lazy: remove redundant test_thread_flag()
 call
Date: Mon, 5 May 2014 22:37:28 -0400
Message-ID: <20140505223728.5a07e6e1@gandalf.local.home>
References: <1399020080.5233.96.camel@marge.simpson.net>
	<1399029166.5233.125.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.227]:33586 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S933630AbaEFCha (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 5 May 2014 22:37:30 -0400
In-Reply-To: <1399029166.5233.125.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 02 May 2014 13:12:46 +0200
Mike Galbraith <umgwanakikbuti@gmail.com> wrote:

> __preempt_count_dec_and_test() already does it.

Already does what? :-)

Hmm, do all archs check? Perhaps we need to also update
include/asm-generic/preempt.h?

-- Steve

> 
> Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
> ---
>  include/linux/preempt.h |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> --- a/include/linux/preempt.h
> +++ b/include/linux/preempt.h
> @@ -126,8 +126,7 @@ do { \
>  #define preempt_enable_notrace() \
>  do { \
>  	barrier(); \
> -	if (unlikely(__preempt_count_dec_and_test() || \
> -				test_thread_flag(TIF_NEED_RESCHED_LAZY))) \
> +	if (unlikely(__preempt_count_dec_and_test())) \
>  		__preempt_schedule_context(); \
>  } while (0)
>  #else
> 
> 

