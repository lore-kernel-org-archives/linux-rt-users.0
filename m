From: "Nikita V. Youshchenko" <yoush@cs.msu.su>
Subject: Re: RFC: NUMA modifications to cyclictest
Date: Wed, 20 Jan 2010 12:23:35 +0300
Message-ID: <201001201223.36670@zigzag.lvk.cs.msu.su>
References: <20100119171439.24726f2e@torg> <alpine.LFD.2.00.1001200741000.2906@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gate.lvk.cs.msu.su ([158.250.17.1]:53214 "EHLO
	mail.lvk.cs.msu.su" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807Ab0ATJXj (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 20 Jan 2010 04:23:39 -0500
Received: from mail.lvk.cs.msu.su (localhost [127.0.0.1])
	by mail.lvk.cs.msu.su (Postfix) with ESMTP id 207A1974
	for <linux-rt-users@vger.kernel.org>; Wed, 20 Jan 2010 12:23:37 +0300 (MSK)
Received: from desktopvm.lvknet (desktopvm.lvknet [192.168.132.1])
	by mail.lvk.cs.msu.su (Postfix) with ESMTP id 0CF21950
	for <linux-rt-users@vger.kernel.org>; Wed, 20 Jan 2010 12:23:37 +0300 (MSK)
In-Reply-To: <alpine.LFD.2.00.1001200741000.2906@localhost.localdomain>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> > The big difference here is that when using --numa, each measurement
> > thread (one per cpu) has it's stack allocated from the memory node
> > associated with it's cpu. Also, the major data structures for each
> > thread (parameter block, statistics block and histogram) are allocated
> > from the appropriate node. This is done with calls into libnuma,
> > which means this will add a dependency on libnuma.
>
> That might cause some trouble for embedded folks. :(

Maybe make that a compile-time option?
