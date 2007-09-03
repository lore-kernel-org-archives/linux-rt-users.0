From: John Sigler <linux.kernel@free.fr>
Subject: Re: v2.6.23-rc4-rt1 / new project URL
Date: Mon, 03 Sep 2007 12:43:41 +0200
Message-ID: <46DBE55D.3050905@free.fr>
References: <1188593944.9647.15.camel@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp4-g19.free.fr ([212.27.42.30]:58689 "EHLO smtp4-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754495AbXICKoS (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 3 Sep 2007 06:44:18 -0400
In-Reply-To: <1188593944.9647.15.camel@chaos>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Thomas Gleixner wrote:

> We're pleased to announce the release of the v2.6.23-rc4-rt1 kernel,
> which can be downloaded from a new place:
>  
>    http://www.kernel.org/pub/linux/kernel/projects/rt/
>  
> The move to kernel.org is experimental for now, we'll keep it if it
> works out fine.
> 
> Changes since 2.6.23-rc2-rt2:
> 
> - update to -rc4
> - update to 2.6.23-rc4-hrt1
> 
> - UP compile fixes back merged (Kevin Hilman / Steven Rostedt)
> - various latency tracer fixes (Steven Rostedt)
> - softirq migration fixes (Steven Rostedt)
> - ARM futex cmpxchg in atomic support (Khem Raj)
> - ARM raw lock fix (Kevin Hilman)
> - loadavgrt fix (Luis Claudio R. Goncalves)
> - mellanox driver fix (Michael S. Tsirkin)
> 
> A bunch of patches are postponed for -rt2 (they are neither ignored
> nor forgotten):
> 
> - simple_irq change (Kevin Hilman): needs more thought
> - RCU updates (Paul McKenney): needs proper integration
> - latency tracer changes (Daniel Walker): needs review
> - PICK_OP changes (Daniel Walker): needs review
> 
> 
> More info about the -rt patch set can be found in the RT wiki:
>      
>   http://rt.wiki.kernel.org
>   
> To build a 2.6.23-rc4-rt1 tree, the following patches should be applied:
>  
>   http://kernel.org/pub/linux/kernel/v2.6/testing/linux-2.6.22.tar.bz2
>   http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.23-rc4.bz2
>   http://kernel.org/pub/linux/kernel/projects/rt/patch-2.6.23-rc4-rt1.bz2

Hello,

Is (part of) this update planned to be back-ported to 2.6.22.6?

Regards.
