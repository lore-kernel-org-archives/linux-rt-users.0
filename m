From: Stanislav Meduna <stano@meduna.org>
Subject: Re: Kernel modules: atomic GPIO access on PREEMPT_RT
Date: Sat, 29 Jun 2013 10:43:09 +0200
Message-ID: <51CE9E1D.3060806@meduna.org>
References: <emcf19860c-9857-436b-874a-5daee54f378f@nb-mak>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Matthias Klein <matthias.klein@optimeas.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:40732 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751815Ab3F2InT (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 29 Jun 2013 04:43:19 -0400
In-Reply-To: <emcf19860c-9857-436b-874a-5daee54f378f@nb-mak>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 29.06.2013 09:11, Matthias Klein wrote:

> What is the right way to access these registers for e.g
> setting a single bit of such a register to avoid
> read/modify/write problems ?
> Do I have to use some locking / atomic operations ?

If the hardware does not support you here with bit-banding
(some Cortex processors export single GPIO bits as separate
bytes but I don't think the i.MX537 does), yes, you have
to lock.

I'd say implement a general GPIO driver and use its
function for access.

https://www.kernel.org/doc/Documentation/gpio.txt
http://lxr.free-electrons.com/source/include/asm-generic/gpio.h#L52
http://lxr.free-electrons.com/source/drivers/gpio/gpio-cs5535.c#L93

Generally (several different modules accessing something that
does not have a single driver to implement it) I think the only
sane way is to implement the shared part in arch/arm/.../mach-*
and have all users depend on it.

-- 
                                            Stano

