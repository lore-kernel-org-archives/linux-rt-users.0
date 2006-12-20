From: Ingo Molnar <mingo@elte.hu>
Subject: Re: kernel-rt-15 give NETDEV WATCHDOG: eth1: transmit timed out
Date: Wed, 20 Dec 2006 17:18:03 +0100
Message-ID: <20061220161803.GB11804@elte.hu>
References: <1166314848.11625.9.camel@monteirov> <45890657.9050403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sergio@sergiomb.no-ip.org,
	linux-rt <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:40149 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030189AbWLTQUU (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 20 Dec 2006 11:20:20 -0500
To: Dirk Behme <dirk.behme@googlemail.com>
Content-Disposition: inline
In-Reply-To: <45890657.9050403@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Dirk Behme <dirk.behme@googlemail.com> wrote:

> Sergio Monteiro Basto wrote:
> >Hi, 
> >kernel-rt-14 rocks but wiht kernel-rt-15 I got kernel: NETDEV WATCHDOG:
> >eth1: transmit timed out, I downgrade to kernel-rt-14 and that got this
> >problem anymore.
> >
> >I not use my on-board via-rhine II Ethernet. 
> >This tests has been made with one external Ethernet card, one Realtek
> >Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
> 
> Which driver (file) is used for this? As already mentioned here, I 
> have same issue with smc91x.c on embedded ARM based board. 
> Unfortunately, I get this with various -rtx and not only the recent 
> ones. Maybe this isn't a driver/board/processor specific issue?

that should be drivers/net/8139too.c. It does seem to be spurious and 
indeed longstanding. Either -rt exposes some driver level race or 
perhaps it triggers some net-tx/net-rx softirq processing 
problem/incompatibility?

	Ingo
