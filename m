From: Daniel Walker <dwalker@mvista.com>
Subject: Re: nmi_watchdog in latest 22 and 23-rc -rt series
Date: Tue, 11 Sep 2007 12:36:33 -0700
Message-ID: <1189539393.20371.11.camel@imap.mvista.com>
References: <46E684F8020000F900010523@sinclair.provo.novell.com>
	 <46E6952C0200006C00018312@sinclair.provo.novell.com>
	 <46E6952C0200006C00018312@sinclair.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: David Bahi <dbahi@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:62869 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755669AbXIKTgh (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 11 Sep 2007 15:36:37 -0400
In-Reply-To: <46E6952C0200006C00018312@sinclair.provo.novell.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2007-09-11 at 13:16 -0600, David Bahi wrote:
> sorry to pull your work in to this thread wrongly Daniel.  my point was
> really that the 23-rc4 kernel does not experience either failure for me
> and that the current work being done for nmi_watchdog is unrelated so
> this still needs attention.

No big deal.. you could try 2.6.23-rc6 if your inclined too.

> no hang with nmi_watchdog=2 in 23-rc4 (non -rt)
> no hang with nmi_watchdog=2 in 23-rc4-rt1

I guess I'm confused what's happening .. It sounds like with
nmi_watchdog=1 , the system hangs and the watchdog catches it. With
nmi_watchdog=2 the system doesn't hang, and the watchdog doesn't catch
anything (assuming it's working)?

> finally, i didn't try nmi_watchdog=2 earlier because the
> Documentation/nmi_watchdog.txt file says it's not a useful setting for
> x86_64.  quote:
> 
>   For x86-64, the needed APIC is always compiled in, and the NMI
>   watchdog is always enabled with I/O-APIC mode (nmi_watchdog=1).   
>   Currently, local APIC mode (nmi_watchdog=2) does not work on x86-64.
> 
> Is this no longer true?  My experience with nmi_watchdog=2 and this LTP
> openposix sched_yeild 1-1.test is that this test hardlocks the host and
> that no watchdog is triggered with this setting.

It looks like it should work .. I'd be surprised if it didn't work.. You
can check if it's ticking in /proc/interrupts under NMI (it stops when
the system is idle tho)

Daniel
