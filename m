From: Gregory Haskins <ghaskins@novell.com>
Subject: Re: Request for comments on dejittering app
Date: Fri, 10 Aug 2007 12:22:29 -0400
Message-ID: <1186762949.4866.48.camel@ghaskins-t60p.haskins.net>
References: <46BC86A5.4010506@free.fr>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: John Sigler <linux.kernel@free.fr>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:53019 "EHLO
	victor.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932429AbXHJQYZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 10 Aug 2007 12:24:25 -0400
In-Reply-To: <46BC86A5.4010506@free.fr>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2007-08-10 at 17:39 +0200, John Sigler wrote:

> 
> As far as I understand, each packet received will generate one IRQ

This depends on the driver implementation.  If it uses the optional NAPI
interface the first interrupt received will simply schedule a netif
related thread to poll the device, disable future rx-interrupts for that
NIC, and return.

The packet scheduler thread will then poll your device according to its
configured policy with a specific "budget" of packets.  The device can
netif_rx as many packets from the device in that one invocation until
one of two criteria is met: The budget is exhausted, or the rx-ring is
exhausted.

If the rx-ring is exhausted, rx-interrupts are re-enabled and the return
code tells the netif_rx scheduler to deschedule this device.  If the
budget is exhausted before the ring, the return code indicates that we
still have work to do and interrupts remain off.  The scheduler will
re-poll your device at some point in the future.

There are other nitty gritty details here, but long story short you
generally will not have a 1:1 of interrupts to rx-packets on a busy
link.  This is important from both a latency and DOS perspective because
interrupt storms are mitigated.  So if your driver supports NAPI, I
suggest you use it.  If it doesn't, it might be worth changing it.

I know you had other aspects to your system, but this may help in at
least one dimension.
-Greg
