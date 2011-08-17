From: Rosh shah <trinityrosh@gmail.com>
Subject: BUG: sleeping function called from invalid context at kernel/rtmutex.c:644
Date: Wed, 17 Aug 2011 18:09:36 -0400
Message-ID: <CANFJ_uhSJofc9uc0vMGbc_WpupNAtqP2xx=j1qmnzJmqDp-nEg@mail.gmail.com>
References: <CANFJ_uhVEU+iGMnqA-Kbk=VEx84Y750fyQPnKvB8Qh2t8Qz_pA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:40953 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751956Ab1HQWJg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 17 Aug 2011 18:09:36 -0400
Received: by pzk37 with SMTP id 37so1811034pzk.1
        for <linux-rt-users@vger.kernel.org>; Wed, 17 Aug 2011 15:09:36 -0700 (PDT)
In-Reply-To: <CANFJ_uhVEU+iGMnqA-Kbk=VEx84Y750fyQPnKvB8Qh2t8Qz_pA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I have ported Davinci DM6467T support to the 2.6.33.9-rt for a
project. I am running into the following issue every time I run the
encode application gets a DMA interrupt. I have referred to the
various other instances of the same issue on older RT kernels, but
haven't gathered a solution for the same. Kindly help me understand
the issue / throw some light on how I can approach the solution.
Any thoughts are greatly appreciated.

Aug 16 14:44:01 dm6467t-evm user.debug kernel: dma complete=A0 <INSERTE=
D
BY B.J this is when the DMA ISR is called>
Aug 16 14:44:01 dm6467t-evm user.err kernel: BUG: sleeping function
called from invalid context at kernel/rtmutex.c:644
Aug 16 14:44:01 dm6467t-evm user.err kernel: pcnt: 0 0 in_atomic(): 0,
irqs_disabled(): 128, pid: 46, name: irq/16-edma
Aug 16 14:44:01 dm6467t-evm user.debug kernel: Backtrace:
Aug 16 14:44:01 dm6467t-evm user.debug kernel: [<c002f60c>]
(dump_backtrace+0x0/0x114) from [<c02feb38>] (dump_stack+0x18/0x1c)
Aug 16 14:44:01 dm6467t-evm user.debug kernel:=A0 r7:00002068
r6:00002050 r5:00000000 r4:00000284
Aug 16 14:44:01 dm6467t-evm user.debug kernel: [<c02feb20>]
(dump_stack+0x0/0x1c) from [<c0039ae4>] (__might_sleep+0xfc/0x11c)
Aug 16 14:44:01 dm6467t-evm user.debug kernel: [<c00399e8>]
(__might_sleep+0x0/0x11c) from [<c03012e4>] (rt_spin_lock+0x38/0x64)
Aug 16 14:44:01 dm6467t-evm user.debug kernel:=A0 r5:c20e6888 r4:c20e68=
88
Aug 16 14:44:01 dm6467t-evm user.debug kernel: [<c03012ac>]
(rt_spin_lock+0x0/0x64) from [<c0039378>] (complete+0x20/0x58)
Aug 16 14:44:01 dm6467t-evm user.debug kernel:=A0 r5:c20e6888 r4:c20e68=
84
Aug 16 14:44:01 dm6467t-evm user.debug kernel: [<c0039358>]
(complete+0x0/0x58) from [<bf02f42c>] (dmaIsr+0x4c/0x70 [logos_tsif])
Aug 16 14:44:01 dm6467t-evm user.debug kernel:=A0 r5:bf030930 r4:a00000=
13
Aug 16 14:44:01 dm6467t-evm user.debug kernel: [<bf02f3e0>]
(dmaIsr+0x0/0x70 [logos_tsif]) from [<c0035958>]
(dma_irq_handler+0x114/0x158)
Aug 16 14:44:01 dm6467t-evm user.debug kernel:=A0 r5:00000005 r4:000000=
05
Aug 16 14:44:01 dm6467t-evm user.debug kernel: [<c0035844>]
(dma_irq_handler+0x0/0x158) from [<c006fd34>] (irq_thread+0xd4/0x238)
Aug 16 14:44:01 dm6467t-evm user.debug kernel: [<c006fc60>]
(irq_thread+0x0/0x238) from [<c005725c>] (kthread+0x88/0x90)
Aug 16 14:44:01 dm6467t-evm user.debug kernel: [<c00571d4>]
(kthread+0x0/0x90) from [<c0044990>] (do_exit+0x0/0x604)
Aug 16 14:44:01 dm6467t-evm user.debug kernel:=A0 r7:00000000
r6:00000000 r5:00000000 r4:00000000

Please let me know if you need any other information regarding the
issue. Thanks a lot.

Best Regards,
Roshni
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
