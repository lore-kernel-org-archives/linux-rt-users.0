From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Subject: Re: kernel-rt-15 give NETDEV WATCHDOG: eth1: transmit timed out
Date: Thu, 21 Dec 2006 13:15:34 +0000
Message-ID: <1166706934.4717.6.camel@localhost.localdomain>
References: <1166314848.11625.9.camel@monteirov>
	 <45890657.9050403@gmail.com>  <20061220161803.GB11804@elte.hu>
	 <1166635448.20182.12.camel@localhost.localdomain>
	 <458A38BE.2070001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ingo Molnar <mingo@elte.hu>,
	linux-rt <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:37968 "HELO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1422754AbWLUNPh (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 21 Dec 2006 08:15:37 -0500
To: Dirk Behme <dirk.behme@googlemail.com>
In-Reply-To: <458A38BE.2070001@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi ,

I am thinking write to you to say 2 things:

1 - That a have a similar with via-rhine II  on-board Ethernet,
therefore I try this 8139too PCI.
2 - I can get this problem quicker when I enable other devices that use
interrupts massively, like usbnet or nvidia dri.



On Thu, 2006-12-21 at 08:33 +0100, Dirk Behme wrote:
> Sergio Monteiro Basto wrote:
> > On Wed, 2006-12-20 at 17:18 +0100, Ingo Molnar wrote:
> >=20
> >>that should be drivers/net/8139too.c.
> >=20
> > yes, is one 8139too kernel module that is loaded=20
>=20
> On LKML there was a discussion about
>=20
> http://www.ussg.iu.edu/hypermail/linux/kernel/0612.1/0642.html
>=20
> which seems to be necessary at the moment for embedded ARM=20
> based OMAP.
>=20
> S=C3=A9rgio: Maybe it's worth a try for your issue as well?

Sure I will try that patch .

Thanks,
--
S=C3=A9rgio M. B.=20
