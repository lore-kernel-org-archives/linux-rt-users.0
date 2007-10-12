From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: NMI watchdog
Date: Fri, 12 Oct 2007 12:00:43 +0200
Message-ID: <20071012100043.GA28777@atjola.homenet>
References: <470F3BE0.4050807@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: John Sigler <linux.kernel@free.fr>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:59248 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758945AbXJLKAf (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 12 Oct 2007 06:00:35 -0400
Content-Disposition: inline
In-Reply-To: <470F3BE0.4050807@free.fr>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2007.10.12 11:18:24 +0200, John Sigler wrote:
> Hello,
>
> I'm experiencing a full system lockup. I'm using an out-of-tree drive=
r=20
> which I suspect is responsible. I'm trying to enable the NMI watchdog=
=2E
>
> # cat /proc/version
> Linux version 2.6.22.1-rt9 (gcc version 3.4.6) #1 PREEMPT RT Tue Oct =
9=20
> 12:25:47 CEST 2007
>
> # cat /proc/cmdline
> ro root=3D/dev/hdc1 console=3DttyS0,57600n8 console=3Dtty0 panic=3D3 =
apic=3Ddebug=20
> nmi_watchdog=3D2
>
> However, after boot, the NMI count does not change.
>
> # cat /proc/interrupts ; sleep 10 ; cat /proc/interrupts

Try running some cpu hog in the background. The performance counters ge=
t
increased only when the CPU is actually doing something. On a mostly
idle system, it can take quite a while for the next NMI to show up.

Bj=F6rn
