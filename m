From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH -rt 1/4] x86_64: send NMI after nmi_show_regs on
Date: Mon, 28 Apr 2008 15:00:36 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0804281457330.4615@gandalf.stny.rr.com>
References: <48161325.1080508@ct.jp.nec.com> <4816140F.50005@ct.jp.nec.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:42275 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966174AbYD1TAj (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 28 Apr 2008 15:00:39 -0400
In-Reply-To: <4816140F.50005@ct.jp.nec.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Mon, 28 Apr 2008, Hiroshi Shimamoto wrote:
> diff --git a/arch/x86/kernel/nmi_64.c b/arch/x86/kernel/nmi_64.c
> index d187ab9..69cc737 100644
> --- a/arch/x86/kernel/nmi_64.c
> +++ b/arch/x86/kernel/nmi_64.c
> @@ -327,11 +327,11 @@ void nmi_show_all_regs(void)
>  	if (system_state == SYSTEM_BOOTING)
>  		return;
>
> -	smp_send_nmi_allbutself();
> -
>  	for_each_online_cpu(i)
>  		nmi_show_regs[i] = 1;

Hi Hiroshi,

I know this wasn't your code to begin with but, how does this function
exit?  I mean, we set an array where each index per online cpu is set to
one, then do an "nmi_allbutself", and then wait on those indexes to turn
zero, one at a time.  If we are CPU 0 here, we set that index to 1, then
enter the loop, and will block forever on this "while" loop below.

Am I missing something?

Thanks,

-- Steve



> +	smp_send_nmi_allbutself();
> +
>  	for_each_online_cpu(i) {
>  		while (nmi_show_regs[i] == 1)
>  			barrier();
> --
> 1.5.4.1
>
