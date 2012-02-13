From: joel silvestre <j.silvestre@wanadoo.fr>
Subject: 3.0.20-rt36 - irq 17: nobody cared
Date: Mon, 13 Feb 2012 22:49:08 +0100
Message-ID: <1329169748.4913.41.camel@zordi2>
References: <1329080746.4913.35.camel@zordi2>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:35531 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755244Ab2BMVtN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 13 Feb 2012 16:49:13 -0500
In-Reply-To: <1329080746.4913.35.camel@zordi2>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

got an other one with 3.0.20-rt36 on a different box:



[45786.586445] irq 17: nobody cared (try booting with the "irqpoll"
option)
[45786.586449] Pid: 1071, comm: irq/17-hda_inte Not tainted
3.0.20.moa-rt36 #1
[45786.586451] Call Trace:
[45786.586459]  [<c1076228>] __report_bad_irq+0x24/0x9a
[45786.586462]  [<c10763d9>] note_interrupt+0x13b/0x1ac
[45786.586467]  [<c107530a>] irq_thread+0xe9/0x1a1
[45786.586470]  [<c107545d>] ? exit_irq_thread+0x6f/0x6f
[45786.586473]  [<c1075221>] ? irq_finalize_oneshot+0x8c/0x8c
[45786.586475]  [<c1075221>] ? irq_finalize_oneshot+0x8c/0x8c
[45786.586479]  [<c104f1a1>] kthread+0x67/0x6c
[45786.586482]  [<c104f13a>] ? kthreadd+0x10a/0x10a
[45786.586487]  [<c12c20c2>] kernel_thread_helper+0x6/0x10
[45786.586488] handlers:
[45786.586490] [<c1075029>] irq_default_primary_handler threaded
[<f8084a2a>] ata_bmdma_interrupt
[45786.586521] [<c1075029>] irq_default_primary_handler threaded
[<f8400751>] azx_interrupt
[45786.586526] [<c1075029>] irq_default_primary_handler threaded
[<f8400751>] azx_interrupt
[45786.586529] Disabling IRQ #17


Jo=C3=ABl

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
