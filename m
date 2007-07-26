From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [BUG] 2.6.23-rc1-rt2
Date: Thu, 26 Jul 2007 10:39:40 +0200
Message-ID: <20070726083940.GA30120@elte.hu>
References: <20070725175925.GA2992@ittc.ku.edu> <1185389357.2573.229.camel@imap.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Noah Watkins <nwatkins@ittc.ku.edu>, linux-rt-users@vger.kernel.org
To: Daniel Walker <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:52170 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754327AbXGZIjp (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 26 Jul 2007 04:39:45 -0400
Content-Disposition: inline
In-Reply-To: <1185389357.2573.229.camel@imap.mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> I don't know about the slowness, but I think the BUG warnings are from 
> CONFIG_DEBUG_SHIRQ .
> 
> Try this patch,
> 
> Signed-off-by: Daniel Walker <dwalker@mvista.com>

> -			local_irq_save(flags);
> +			local_irq_save_nort(flags);
>  			handler(irq, dev_id);
> -			local_irq_restore(flags);
> +			local_irq_restore_nort(flags);

yep - makes sense - applied.

	Ingo
