From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] 3.10.10-rt7
Date: Fri, 04 Oct 2013 15:05:45 +0200
Message-ID: <524EBD29.5010100@linutronix.de>
References: <20130829184228.GD15360@linutronix.de> <537051377882968@web17h.yandex.ru> <20131004122703.GC19953@linutronix.de> <448111380891453@web20m.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Kirill Tkhai <tkhai@yandex.ru>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:53759 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753531Ab3JDNFq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 4 Oct 2013 09:05:46 -0400
In-Reply-To: <448111380891453@web20m.yandex.ru>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 10/04/2013 02:57 PM, Kirill Tkhai wrote:
> Yes, I now. I added IRQ_FORCED_THREADING to Kconfig. My hardware
> requires additional changes at arch/sparc and it's in a process of porting
> on 3.10 so I can't say if everything works on sparc or not yet.

So if you marked NMIs and so as non-threaded you can send this patch to
Dave, too :)

> The other required fix to make sparc64 compilable is deletion of rwsem leftovers.
> I sent it to mainline sparc:
> 
> https://git.kernel.org/cgit/linux/kernel/git/davem/sparc.git/commit/arch/sparc?id=61d9b9355b0d427bd1e732bd54628ff9103e496f
> 
> It seems it's resonable to add it to the patch too.

Since it is queued for mainline let me make your life easier and pick
it up for -RT, too.

Sebastian
