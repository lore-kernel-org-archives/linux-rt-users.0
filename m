From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: NMI watchdog
Date: Fri, 12 Oct 2007 06:26:19 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0710120625380.8208@gandalf.stny.rr.com>
References: <470F3BE0.4050807@free.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: John Sigler <linux.kernel@free.fr>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-05.nyroc.rr.com ([24.24.2.59]:64619 "EHLO
	ms-smtp-05.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750861AbXJLK0X (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 12 Oct 2007 06:26:23 -0400
In-Reply-To: <470F3BE0.4050807@free.fr>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


--

On Fri, 12 Oct 2007, John Sigler wrote:

> Hello,
>
> I'm experiencing a full system lockup. I'm using an out-of-tree driver
> which I suspect is responsible. I'm trying to enable the NMI watchdog.
>
> # cat /proc/version
> Linux version 2.6.22.1-rt9 (gcc version 3.4.6) #1 PREEMPT RT Tue Oct 9
> 12:25:47 CEST 2007
>
> # cat /proc/cmdline
> ro root=/dev/hdc1 console=ttyS0,57600n8 console=tty0 panic=3 apic=debug
> nmi_watchdog=2
>

I've noticed on some boxes that nmi_watchdog=2 does what you state. Try
out nmi_watchdog=1.

-- Steve
