From: Scott Wood <scottwood@freescale.com>
Subject: Re: [MPC52xx]Latency issue with DMA on FEC
Date: Wed, 1 Dec 2010 15:16:12 -0600
Message-ID: <20101201151612.3ce3f06e@udp111988uds.am.freescale.net>
References: <1291215130.4881.55.camel@gandalf.stny.rr.com>
	<AE90C24D6B3A694183C094C60CF0A2F6D8ABDB@saturn3.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Jean-Michel Hautbois <jhautbois@gmail.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>,
	<linux-rt-users@vger.kernel.org>,
	Eric Dumazet <eric.dumazet@gmail.com>
To: David Laight <David.Laight@ACULAB.COM>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from va3ehsobe006.messaging.microsoft.com ([216.32.180.16]:25490
	"EHLO VA3EHSOBE008.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752752Ab0LAVQU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 1 Dec 2010 16:16:20 -0500
Received: from mail53-va3 (localhost.localdomain [127.0.0.1])	by
 mail53-va3-R.bigfish.com (Postfix) with ESMTP id DA8B81A6852D	for
 <linux-rt-users@vger.kernel.org>; Wed,  1 Dec 2010 21:16:18 +0000 (UTC)
Received: from VA3EHSMHS016.bigfish.com (unknown [10.7.14.251])	by
 mail53-va3.bigfish.com (Postfix) with ESMTP id 903DA62004E	for
 <linux-rt-users@vger.kernel.org>; Wed,  1 Dec 2010 21:16:18 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
 [10.64.34.199])	by az33egw01.freescale.net (8.14.3/8.14.3) with ESMTP id
 oB1LGFcs011042	for <linux-rt-users@vger.kernel.org>; Wed, 1 Dec 2010 14:16:15
 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
 [10.64.32.16])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
 oB1LGFcq012897	for <linux-rt-users@vger.kernel.org>; Wed, 1 Dec 2010 15:16:15
 -0600 (CST)
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8ABDB@saturn3.aculab.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 1 Dec 2010 15:09:54 +0000
David Laight <David.Laight@ACULAB.COM> wrote:

> The in_le32() not only contains the unwanted 'sync', but also
> a 'twi' (trap immediate - NFI exactly what this does) and 'isync'.

It turns a data dependency into a flow dependency.  It's basically equivalent to:

lwz	rX, ...
cmpw	rX, rX
bne	1f
1: isync

> The 'isync' is particularly horrid and unnecessary (aborts
> the instruction queue and refeches the opcode bytes)

The isync makes sure that the twi has completed before proceeding.

Note that the guarded, cache-inhibited load itself can be pretty
painful -- the core can't restart it, so it must complete before you
can take an interrupt.

> The very slow in_le32() might be there to give semi-synchronous
> traps on address fault - but unless the hardware is being probed
> that really isn't necessary.

There are times when you really want to be sure that the I/O is
finished before proceeding with something that isn't a load/store and
thus can't be serialized with normal barriers.

E.g. you're about to execute instructions in a physical address window
that you just set up (or even just create a non-guarded mapping to it
-- could get speculative accesses any time), or you just masked an
interrupt at the PIC (with a readback to flush) and are about to enable
MSR[EE].

Most of the time, though, it's overkill.  It should probably be an
alternate accessor form, or maybe a wait_for_io() wrapper -- if it can
be shown to make a real performance difference.

-Scott

