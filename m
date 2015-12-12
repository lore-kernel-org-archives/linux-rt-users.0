From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] rt: x86: extend signal send delay to 32 bit
Date: Sat, 12 Dec 2015 15:35:36 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1512121533210.4336@nanos>
References: <1449773931-7200-1-git-send-email-yang.shi@linaro.org> <20151211180532.GO6720@linutronix.de> <566B275A.5070300@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org, linaro-kernel@lists.linaro.org
To: "Shi, Yang" <yang.shi@linaro.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:51880 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330AbbLLOg0 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 12 Dec 2015 09:36:26 -0500
In-Reply-To: <566B275A.5070300@linaro.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 11 Dec 2015, Shi, Yang wrote:
> On 12/11/2015 10:05 AM, Sebastian Andrzej Siewior wrote:
> > * Yang Shi | 2015-12-10 10:58:51 [-0800]:
> > > Signal send delay is just available for x86-64, x86-32 needs it too.
> > 
> > This is new, this was not the case earlier. New means since v4.0-rc1 which
> 
> Yes, it is. We didn't find this problem in earlier version kernel (I'd say
> 3.x).
> 
> > is when 959274753857 ("x86, traps: Track entry into and exit from IST
> > context") got merged.
> > Since now ist_enter() disables preemption in any case, our hacks to
> > conditional_sti_ist() are pointless and could be removed.
> 
> I'm supposed you will revert it and not need a revert patch from me.

Why do you think that reverting it is a good idea? Just because we can
or what?

No, we fix it up on the RT side.

Thanks,

	tglx
