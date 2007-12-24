From: Lee Howard <faxguy@howardsilvan.com>
Subject: Re: yum repository for kernel-rt ?
Date: Mon, 24 Dec 2007 11:04:52 -0800
Message-ID: <477002D4.5030903@howardsilvan.com>
References: <476E67BD.9080601@howardsilvan.com> <a3d4028e0712241024y29de181am4c637278acbcbcdc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Javier Sanz <jsanza@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from frodo.howardsilvan.com ([66.119.206.113]:52711 "EHLO
	mail.howardsilvan.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966AbXLXTEz (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 24 Dec 2007 14:04:55 -0500
In-Reply-To: <a3d4028e0712241024y29de181am4c637278acbcbcdc@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Javier Sanz wrote:
> try IRQTUNE, a Linux IRQ Priority Optimizer
> http://cae.best.vwh.net/irqtune/

Thanks.  I had seen that, however I'm on x86_64 (AMD64) and 
unfortunately the prebuilt modules that come in irqtune.tgz are 
non-functional on my system.

It doesn't look like the author has touched IRQTUNE for over 10 years 
now.  Are modules built against kernel 2.0 actually valid in kernel 2.6?

IRQTUNE doesn't build from source, either, on my system:

cc -c -O -I/usr/src/irqtune/include -I/usr/src/irqtune/include/P 
-I/usr/src/irqtune -Wall -Werror -Wno-format  -D__KERNEL__ 
-DIRQTUNE_VERSION=\"0.6\" -o load_mod.o /usr/src/irqtune/src/load.c
/usr/src/irqtune/src/load.c:11:24: error: asm/system.h: No such file or 
directory
In file included from /usr/src/irqtune/src/irqhigh.c:7,
                 from /usr/src/irqtune/src/load.c:13:
/usr/src/irqtune/include/irqhigh.h:10:2: error: #error irqhigh: this 
only works/is needed for x86/PC architecture -- sorry
In file included from /usr/src/irqtune/src/load.c:13:
/usr/src/irqtune/src/irqhigh.c:8:20: error: asm/io.h: No such file or 
directory
cc1: warnings being treated as errors

So. while I adore the idea of simply being able to insert a module to 
remedy the IRQ prioritization (or lack thereof) issue instead of 
patching the kernel or installing a kernel alternate from what the 
distribution provides, it doesn't seem that IRQTUNE will work for me.

Are the rt patches available as a module?  Wouldn't that be cool if the 
whole rt stuff could be modularized and simply insmod'ed when the 
administrator so-desired real-time functionality?

Thanks,

Lee.
