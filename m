From: Ingo Molnar <mingo@elte.hu>
Subject: Re: v2.6.20-rt1, yum/rpm
Date: Wed, 28 Feb 2007 09:11:32 +0100
Message-ID: <20070228081132.GA32405@elte.hu>
References: <20070205065636.GA1652@elte.hu> <45E46CB4.1080009@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: "K.R. Foley" <kr@cybsft.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:53979 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751017AbXB1IS2 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 28 Feb 2007 03:18:28 -0500
Content-Disposition: inline
In-Reply-To: <45E46CB4.1080009@cybsft.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* K.R. Foley <kr@cybsft.com> wrote:

> Ingo Molnar wrote:
> > i have released the v2.6.20-rt1 kernel, which can be downloaded from the 
> > usual place:
> > 
> 
> I have a couple of questions regarding priorities of the softirqs, IRQ 
> handlers, etc.
> 
> With some exceptions, back in 2.6.18 and prior patches the IRQ threads 
> were prioritized between 50 and 25 and the most of the softirqs were 
> prioritized at 1? In newer patches it looks like they are all 
> prioritized at 50?
> 
> I was just curious what went into making these choices? I am just 
> trying to better understand these decisions.

The basically random order-of-request_irq() prioritization was causing 
problems (it worked for some but didnt work for others), so i got rid of 
trying to auto-guess some priority order. Also, now that we've got 
tools/scripts like set_kthread_prio and rtprio it seemed more consistent 
to just not attempt to prioritize interrupts and softirqs at all, but to 
keep them all 'in the middle' of the RT priority range.

	Ingo
