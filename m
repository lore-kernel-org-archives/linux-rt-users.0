From: Alexander Gerasiov <gq@cs.msu.su>
Subject: Re: Boot IRQ issue on Intel C602J (Advantech ASMB-822)
Date: Tue, 9 Feb 2016 16:42:35 +0300
Message-ID: <20160209164235.146a89d8@brick.gerasiov.net>
References: <20160208124004.5a20494f@brick.gerasiov.net>
	<alpine.DEB.2.11.1602091133080.25254@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.gerasiov.net ([158.250.17.72]:55785 "EHLO
	mail.gerasiov.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841AbcBINmm (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Feb 2016 08:42:42 -0500
Received: from mail.gerasiov.net (mail.gerasiov.net [127.0.0.1])
	by mail.gerasiov.net (Postfix) with ESMTP id 3F865A00E2
	for <linux-rt-users@vger.kernel.org>; Tue,  9 Feb 2016 16:42:37 +0300 (MSK)
Received: from brick.gerasiov.net (nat9.cs.msu.ru [188.44.42.216])
	by mail.gerasiov.net (Postfix) with ESMTPSA id 67CD1A00AB
	for <linux-rt-users@vger.kernel.org>; Tue,  9 Feb 2016 16:42:36 +0300 (MSK)
In-Reply-To: <alpine.DEB.2.11.1602091133080.25254@nanos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Thomas,

On Tue, 9 Feb 2016 11:34:01 +0100 (CET)
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Mon, 8 Feb 2016, Alexander Gerasiov wrote:
> > On 3.10.74 one of adapter generate only several (~10) interrupts and
> > then halts. As I discovered, it works ok, but no interrupts was
> > delivered. The same time (but after device stops receiving irqs)
> > boot irqs occur and irq 16 got disabled by the kernel.
> > 
> > I tried 3.18.25 with the same result.
> > 
> > Right now I'm running 4.4.1-rt4 and finally it works, but there are
> > still boot irqs and kernel disables IRQ 16 because of them.
> 
> Can you please provide the output of:
> 
> # lspci -s 00:1f.0 -xxx


root@mu:~# lspci -s 00:1f.0 -xxx
00:1f.0 ISA bridge: Intel Corporation C600/X79 series chipset LPC Controller (rev 06)
00: 86 80 41 1d 07 00 10 02 06 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 41 1d
30: 00 00 00 00 e0 00 00 00 00 00 00 00 00 00 00 00
40: 01 04 00 00 80 00 00 00 01 05 00 00 10 00 00 00
50: f8 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 8b 8a 8b 8b d0 00 00 00 87 80 80 8a f8 f0 00 00
70: 78 f0 78 f0 78 f0 78 f0 78 f0 78 f0 78 f0 78 f0
80: 10 00 0f 3f 01 0a fc 00 a1 0c 0c 00 00 00 00 00
90: 00 00 00 00 00 0f 00 00 00 00 00 00 00 00 00 00
a0: 18 0a 20 00 48 19 06 00 00 47 00 00 00 03 00 80
b0: 00 00 00 00 00 00 00 00 02 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 33 22 11 00 67 45 00 00 c0 ff 00 00 2a 00 00 00
e0: 09 00 0c 10 00 00 00 00 91 02 64 0c 00 00 00 00
f0: 01 c0 d1 fe 00 00 00 00 87 0f 08 08 00 00 00 00


-- 
Best regards,
 Alexander Gerasiov

 Contacts:
 e-mail: gq@cs.msu.su  Homepage: http://gerasiov.net  Skype: gerasiov
 PGP fingerprint: 04B5 9D90 DF7C C2AB CD49  BAEA CA87 E9E8 2AAC 33F1
