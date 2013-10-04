From: Kirill Tkhai <tkhai@yandex.ru>
Subject: Re: [ANNOUNCE] 3.10.10-rt7
Date: Fri, 04 Oct 2013 16:57:33 +0400
Message-ID: <448111380891453@web20m.yandex.ru>
References: <20130829184228.GD15360@linutronix.de>
 <537051377882968@web17h.yandex.ru> <20131004122703.GC19953@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from forward9.mail.yandex.net ([77.88.61.48]:33808 "EHLO
	forward9.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753581Ab3JDM5g (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 4 Oct 2013 08:57:36 -0400
In-Reply-To: <20131004122703.GC19953@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

04.10.2013, 16:27, "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>:
> * Kirill Tkhai | 2013-08-30 21:16:08 [+0400]:
>
>> sparc does not have CONFIG_EARLY_PRINTK option.
>>
>> So early-printk-consolidate.patch breaks compilation:
>>
>> arch/sparc/built-in.o: In function `setup_arch':
>> (.init.text+0x15e4): undefined reference to `early_console'
>> arch/sparc/built-in.o: In function `setup_arch':
>> (.init.text+0x15ec): undefined reference to `early_console'
>
> that is true and I applied that patch, thanks.
> However with this alone you do not have a working RT on Sparc because
> you can't select "Fully Preemptible Kernel (RT)" only the "basic" system
> is available.

Yes, I now. I added IRQ_FORCED_THREADING to Kconfig. My hardware
requires additional changes at arch/sparc and it's in a process of porting
on 3.10 so I can't say if everything works on sparc or not yet.

The other required fix to make sparc64 compilable is deletion of rwsem leftovers.
I sent it to mainline sparc:

https://git.kernel.org/cgit/linux/kernel/git/davem/sparc.git/commit/arch/sparc?id=61d9b9355b0d427bd1e732bd54628ff9103e496f

It seems it's resonable to add it to the patch too.
