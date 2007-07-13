From: Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH] RT: add clock.cycle_accumulated to vsyscall gtod update
Date: Thu, 12 Jul 2007 21:14:58 -0700
Message-ID: <1184300099.7974.79.camel@dhcp193.mvista.com>
References: <4696C0720200005A0002776A@mcclure.wal.novell.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: mingo@elte.hu, tglx@linutronix.de, David Bahi <DBahi@novell.com>,
	Sven Dietrich <SDietrich@novell.com>,
	linux-rt-users@vger.kernel.org, johnstul@us.ibm.com
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:18702 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927AbXGME0M (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Jul 2007 00:26:12 -0400
In-Reply-To: <4696C0720200005A0002776A@mcclure.wal.novell.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2007-07-12 at 23:59 -0400, Gregory Haskins wrote:
> 2.6.22 changed the vsyscall mechanism to store a more cache-thrash
> friendly version of the gtod data.  The original gtod cache code used an
> entire struct clock + structure-copy, whereas the new code uses a
> pseudo/shadow version + explicit-copy. 
> 
> clock.cycle_accumulated was added to RT prior to 2.6.22 so the vsyscall
> code must also be updated for the port to 22.
> 
> Signed-off-by: Gregory Haskins <ghaskins@novell.com>
> --- 
> 
>  vsyscall.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- linux-2.6.22.orig/arch/x86_64/kernel/vsyscall.c
> +++ linux-2.6.22/arch/x86_64/kernel/vsyscall.c
> @@ -90,6 +90,7 @@ void update_vsyscall(struct timespec *wa
>         /* copy vsyscall data */
>         vsyscall_gtod_data.clock.vread = clock->vread;
>         vsyscall_gtod_data.clock.cycle_last = clock->cycle_last;
> +       vsyscall_gtod_data.clock.cycle_accumulated =
> clock->cycle_accumulated;
>         vsyscall_gtod_data.clock.mask = clock->mask;
>         vsyscall_gtod_data.clock.mult = clock->mult;
>         vsyscall_gtod_data.clock.shift = clock->shift;

It looks like your patch might be line wrapped ?

Also you need to CC John Stultz, who I've added ..

Daniel
