From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] 3.10.10-rt7
Date: Fri, 4 Oct 2013 14:27:03 +0200
Message-ID: <20131004122703.GC19953@linutronix.de>
References: <20130829184228.GD15360@linutronix.de>
 <537051377882968@web17h.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Kirill Tkhai <tkhai@yandex.ru>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:53548 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754063Ab3JDM1E (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 4 Oct 2013 08:27:04 -0400
Content-Disposition: inline
In-Reply-To: <537051377882968@web17h.yandex.ru>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Kirill Tkhai | 2013-08-30 21:16:08 [+0400]:

>sparc does not have CONFIG_EARLY_PRINTK option.
>
>So early-printk-consolidate.patch breaks compilation:
>
>arch/sparc/built-in.o: In function `setup_arch':
>(.init.text+0x15e4): undefined reference to `early_console'
>arch/sparc/built-in.o: In function `setup_arch':
>(.init.text+0x15ec): undefined reference to `early_console'

that is true and I applied that patch, thanks.
However with this alone you do not have a working RT on Sparc because
you can't select "Fully Preemptible Kernel (RT)" only the "basic" system
is available.

Sebastian
