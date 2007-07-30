From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH -rt 4/9] ifdef raise_softirq_irqoff wakeup
Date: Mon, 30 Jul 2007 11:27:51 +0200
Message-ID: <20070730092751.GD25640@elte.hu>
References: <20070730024534.369897977@mvista.com> <20070730024719.782847315@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Daniel Walker <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:51280 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933839AbXG3J2E (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 30 Jul 2007 05:28:04 -0400
Content-Disposition: inline
In-Reply-To: <20070730024719.782847315@mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> @@ -508,7 +508,9 @@ inline fastcall void raise_softirq_irqof
>  {
>  	__do_raise_softirq_irqoff(nr);
>  
> +#ifdef CONFIG_PREEMPT_SOFTIRQS
>  	wakeup_softirqd(nr);
> +#endif

thanks, applied. People rarely run the -rt kernel just to turn off 
PREEMPT_RT, that's why this bug was there ;-)

	Ingo
