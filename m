From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: kernel-rt-15 give NETDEV WATCHDOG: eth1: transmit timed out
Date: Thu, 21 Dec 2006 08:33:18 +0100
Message-ID: <458A38BE.2070001@gmail.com>
References: <1166314848.11625.9.camel@monteirov>	 <45890657.9050403@gmail.com>  <20061220161803.GB11804@elte.hu> <1166635448.20182.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ingo Molnar <mingo@elte.hu>,
	linux-rt <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:58506 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422802AbWLUHd1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 21 Dec 2006 02:33:27 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2530175uga
        for <linux-rt-users@vger.kernel.org>; Wed, 20 Dec 2006 23:33:26 -0800 (PST)
To: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
In-Reply-To: <1166635448.20182.12.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Sergio Monteiro Basto wrote:
> On Wed, 2006-12-20 at 17:18 +0100, Ingo Molnar wrote:
>=20
>>that should be drivers/net/8139too.c.
>=20
> yes, is one 8139too kernel module that is loaded=20

On LKML there was a discussion about

http://www.ussg.iu.edu/hypermail/linux/kernel/0612.1/0642.html

which seems to be necessary at the moment for embedded ARM=20
based OMAP.

S=C3=A9rgio: Maybe it's worth a try for your issue as well?

Dirk
