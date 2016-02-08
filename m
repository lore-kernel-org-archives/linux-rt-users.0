From: Alexander Gerasiov <gq@cs.msu.su>
Subject: Boot IRQ issue on Intel C602J (Advantech ASMB-822)
Date: Mon, 8 Feb 2016 12:40:04 +0300
Message-ID: <20160208124004.5a20494f@brick.gerasiov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.gerasiov.net ([158.250.17.72]:48861 "EHLO
	mail.gerasiov.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751098AbcBHJtZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Feb 2016 04:49:25 -0500
Received: from mail.gerasiov.net (mail.gerasiov.net [127.0.0.1])
	by mail.gerasiov.net (Postfix) with ESMTP id 4021AA00E2
	for <linux-rt-users@vger.kernel.org>; Mon,  8 Feb 2016 12:40:05 +0300 (MSK)
Received: from brick.gerasiov.net (unknown [192.168.131.72])
	by mail.gerasiov.net (Postfix) with ESMTPSA id 1E821A00AB
	for <linux-rt-users@vger.kernel.org>; Mon,  8 Feb 2016 12:40:05 +0300 (MSK)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello there.

We are using 3.10.74-rt79 in our system and found some problem with
Advantech ASMB-822 motherboard.

It's Intel C602J based m/b with 2 IO-APIC.

We have 2 special PCIe adapters installed. They use legacy interrupts
through APIC.

On 3.10.74 one of adapter generate only several (~10) interrupts and
then halts. As I discovered, it works ok, but no interrupts was
delivered. The same time (but after device stops receiving irqs) boot
irqs occur and irq 16 got disabled by the kernel.

I tried 3.18.25 with the same result.

Right now I'm running 4.4.1-rt4 and finally it works, but there are
still boot irqs and kernel disables IRQ 16 because of them.

So I need some ideas, how to deal with boot interrupts on this chipset.
May be to add workaround like masking boot irq together with IO-APIC
irq.

PS If someone could give a clue, what was changed in 4.4.1 from 3.18
that would be great. (As I'm not sure we could switch production system
to 4.4.1 soon, and I'd like to backport this change set to old kernel if
possible.)

-- 
Best regards,
 Alexander Gerasiov

 Contacts:
 e-mail: gq@cs.msu.su  Homepage: http://gerasiov.net  Skype: gerasiov
 PGP fingerprint: 04B5 9D90 DF7C C2AB CD49  BAEA CA87 E9E8 2AAC 33F1
