From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH -rt] ARM: compile fix for event tracing
Date: Tue, 4 Dec 2007 10:04:23 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0712041003230.9066@gandalf.stny.rr.com>
References: <87fxyjruy8.fsf@vence.hilman.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org,
	linux-arm-kernel@lists.arm.linux.org.uk,
	linux-kernel <linux-kernel@vger.kernel.org>
To: Kevin Hilman <khilman@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:54579 "EHLO
	ms-smtp-03.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831AbXLDPHS (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 4 Dec 2007 10:07:18 -0500
In-Reply-To: <87fxyjruy8.fsf@vence.hilman.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Mon, 3 Dec 2007, Kevin Hilman wrote:

> The cycles/usecs conversion macros should be dependent on
> CONFIG_EVENT_TRACE instead of CONFIG_LATENCY_TIMING.
>
> Signed-off-by: Kevin Hilman <khilman@mvista.com>
>
> --- a/include/asm-arm/timex.h
> +++ b/include/asm-arm/timex.h

Hi, thanks I'll apply this.

But please, in the future, state which version of the -rt patch you
applied this to.

Thanks,

-- Steve
