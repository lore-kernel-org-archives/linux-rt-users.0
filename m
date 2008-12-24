From: "Javier Sanz" <jsanza@gmail.com>
Subject: 4gb himem bug? 2.6.28-rt12
Date: Wed, 24 Dec 2008 23:35:26 +0100
Message-ID: <a3d4028e0812241435l28b90e6aoef27ee225ef5b300@mail.gmail.com>
References: <a3d4028e0812241432k2868404axe0056f8839c8eba0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:46843 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243AbYLXWf2 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 24 Dec 2008 17:35:28 -0500
Received: by bwz14 with SMTP id 14so12188939bwz.13
        for <linux-rt-users@vger.kernel.org>; Wed, 24 Dec 2008 14:35:26 -0800 (PST)
In-Reply-To: <a3d4028e0812241432k2868404axe0056f8839c8eba0@mail.gmail.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

FYI,

I get the following message if i set  4gb option in .config file

BUG: sleeping function called from invalid context IRQ-14(469) at
arch/x86/mm/highmem_32.c:8
in_atomic():0 [00000000], irqs_disabled():1
Pid: 469, comm: IRQ-14 Not tainted 2.6.26.8-rt12 #1
 [<c0421f24>] __might_sleep+0xfc/0x101
 [<c041cf03>] kmap+0x42/0x55
 [<c05bf43f>] ata_sff_hsm_move+0x3d2/0x6a1
 [<c05bf96d>] ata_sff_interrupt+0x153/0x1eb
 [<c0462dad>] handle_IRQ_event+0x4e/0xdc
 [<c0463203>] do_irqd+0x12b/0x229
 [<c04630d8>] ? do_irqd+0x0/0x229
 [<c043cb9b>] kthread+0x3b/0x61
 [<c043cb60>] ? kthread+0x0/0x61
 [<c04048df>] kernel_thread_helper+0x7/0x10
 =======================

Regards
