From: Xavier Miller <xavier.miller@cauwe.org>
Subject: Re: [ANNOUNCE] 2.6.33-rt3
Date: Sat, 27 Feb 2010 10:25:07 +0100
Message-ID: <4B88E4F3.4010308@cauwe.org>
References: <alpine.LFD.2.00.1002241740410.4245@localhost.localdomain> <alpine.LFD.2.00.1002262041020.4245@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Clark Williams <williams@redhat.com>, nando@ccrma.Stanford.EDU,
	Carsten Emde <ce@ceag.ch>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailrelay004.isp.belgacom.be ([195.238.6.170]:18905 "EHLO
	mailrelay004.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S968038Ab0B0JZJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 27 Feb 2010 04:25:09 -0500
In-Reply-To: <alpine.LFD.2.00.1002262041020.4245@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

The name is -rt4, not -rt3

Xavier Miller.

Le 26/02/10 20:54, Thomas Gleixner a =E9crit :
> We are pleased to announce the next update to our new preempt-rt
> series.
>=20
>     - Update to 2.6.33
>=20
>     - rt fixes:
>=20
>       	 Peter Zijlstra (1):
>     	       highmem, -rt: Implement pfn and prot kmaps
>=20
> 	Thomas Gleixner (2):
>       	       x86: pci: Prevent mmconfig memory corruption
>       	       mmc: omap_hsmmc: Fix the locking mess
>=20
> A note on the development process:
>=20
>   The rt/2.6.33 branch is now stabilization only. The rt/head branch
>   will follow linus tree from now on, so it will inherit all
>   (mis)features which come in the merge window.
>=20
> Download locations:
>   =20
>    http://www.kernel.org/pub/linux/kernel/projects/rt/
>=20
> Git development branch:
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-tip.gi=
t rt/head
>=20
> Git release branch:
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-tip.gi=
t rt/2.6.33
>=20
> Gitweb:
>    http://git.kernel.org/?p=3Dlinux/kernel/git/tip/linux-2.6-tip.git;=
a=3Dshortlog;h=3Drt/2.6.33
>=20
> Information on the RT patch can be found at:
>=20
>    http://rt.wiki.kernel.org/index.php/Main_Page
> =20
> To build the 2.6.33-rt3 tree, the following patches should be
> applied:
>=20
>    http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.33.tar.bz2
>    http://www.kernel.org/pub/linux/kernel/projects/rt/patch-2.6.33-rt=
3.bz2
>=20
> Enjoy !
>=20
>       tglx
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
