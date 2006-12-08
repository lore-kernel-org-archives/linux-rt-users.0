From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Ethernet transmit timeouts, was: v2.6.19-rt6, yum/rpm
Date: Fri, 08 Dec 2006 21:15:24 +0100
Message-ID: <1165608924.24604.342.camel@localhost.localdomain>
References: <20061205171114.GA25926@elte.hu>  <4579BFC6.6000605@gmail.com>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:33571 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1946684AbWLHUME (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 8 Dec 2006 15:12:04 -0500
To: Dirk Behme <dirk.behme@googlemail.com>
In-Reply-To: <4579BFC6.6000605@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2006-12-08 at 20:40 +0100, Dirk Behme wrote:
> eth0: SMC91C94 (rev 9) at c2850300 IRQ 160 [nowait]
> eth0: Ethernet addr: 00:0e:99:02:02:42
>
> nfs: server 192.0.0.1 not responding, still trying
> NETDEV WATCHDOG: eth0: transmit timed out

That's not a latency. The transmit side of the driver seems not to work.
Can you please enable debugging in the SMC driver and provide the
output, maybe it's possible to deduce the cause of the problem from
that. Also please enable CONFIG_PROVE_LOCKING in the kernel hacking
section.

	tglx
