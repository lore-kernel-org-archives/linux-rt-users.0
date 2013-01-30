From: Belser Florian <Florian.Belser@sensor-technik.de>
Subject: Kernel Oops caused by high uart write loads
Date: Wed, 30 Jan 2013 07:53:32 +0000
Message-ID: <5EC8D4ACC923FE4D871AFFACC976127959E1C3@stwexdb.stww2k.local>
References: <5EC8D4ACC923FE4D871AFFACC976127959E18A@stwexdb.stww2k.local>
 <5EC8D4ACC923FE4D871AFFACC976127959E1A0@stwexdb.stww2k.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "'linux-rt-users@vger.kernel.org'" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.sensor-technik.de ([80.150.181.156]:2715 "EHLO
	mail.sensor-technik.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737Ab3A3Hxk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 30 Jan 2013 02:53:40 -0500
Received: from stwkeys.sensor-technik.de (localhost [127.0.0.1])
	by stwkeys.sensor-technik.de (Postfix) with ESMTP id 6765D18C070
	for <linux-rt-users@vger.kernel.org>; Wed, 30 Jan 2013 08:53:39 +0100 (CET)
Received: from mail.sensor-technik.de (unknown [172.25.2.15])
	by stwkeys.sensor-technik.de (Postfix) with ESMTP id 2B35718C054
	for <linux-rt-users@vger.kernel.org>; Wed, 30 Jan 2013 08:53:39 +0100 (CET)
In-Reply-To: <5EC8D4ACC923FE4D871AFFACC976127959E1A0@stwexdb.stww2k.local>
Content-Language: de-DE
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi all,

I'm running 3.4.17-rt28 on my mpc5200 based system. =A0The complete sys=
tem works pretty good until I select the "Fully Preemptible Kernel" opt=
ion in the kernel settings.=20
In that case, if I generate a high uart write load (sending a lot of st=
uff via Bluetooth) I get the following kernel Oops:

# ------------[ cut here ]------------
Kernel BUG at c03d1728 [verbose debug info unavailable]
Oops: Exception in kernel mode, sig: 5 [#1]
PREEMPT mpc5200-simple-platform
Modules linked in:
NIP: c03d1728 LR: c03d170c CTR: c01efc78
REGS: c716fd30 TRAP: 0700=A0=A0 Not tainted=A0 (3.4.17-rt28/STW-V3.00r0=
+)
MSR: 00029032 <EE,ME,IR,DR,RI>=A0 CR: 88002022=A0 XER: 00000000
TASK =3D c7125880[633] 'irq/129-mpc52xx' THREAD: c716e000
GPR00: 00000001 c716fde0 c7125880 00000000 c7125880 00000000 00000001 0=
0000000
GPR08: c7125880 c7125880 c7125880 c7125881 88002022 fbfdffff 07fff000 0=
0000004
GPR16: 00000024 00000000 000000c0 00000000 c0537e70 00000004 00000000 0=
0000004
GPR24: c716ad5c c0537e8c c7a73000 00000000 c7bb2a00 c7125880 c78b9800 c=
0537e8c
NIP [c03d1728] rt_spin_lock_slowlock+0x78/0x1e0
LR [c03d170c] rt_spin_lock_slowlock+0x5c/0x1e0
Call Trace:
[c716fde0] [c03d170c] rt_spin_lock_slowlock+0x5c/0x1e0 (unreliable)
[c716fe40] [c01efcd4] uart_write+0x5c/0x114
[c716fe70] [c028f3f4] hci_uart_tx_wakeup+0xe0/0x1fc
[c716fea0] [c01d3398] tty_wakeup+0x78/0xac
[c716feb0] [c01ee9e0] uart_write_wakeup+0x24/0x34
[c716fec0] [c01f1c38] mpc52xx_psc_handle_irq+0x3f8/0x4b0
[c716ff20] [c01f13e4] mpc52xx_uart_int+0x38/0x60
[c716ff30] [c005f660] irq_forced_thread_fn+0x38/0x9c
[c716ff50] [c005f42c] irq_thread+0x13c/0x1c0
[c716ff90] [c00391d4] kthread+0x8c/0x90
[c716fff0] [c000dd4c] kernel_thread+0x4c/0x68
Instruction dump:
7fe3fb78 7fa4eb78 38a00000 38c00001 4bc86591 2f830000 409e0134 801f0018
5400003c 7fa00278 7c000034 5400d97e <0f000000> 3bdd0418 3b810008 7fc3f3=
78

If I switch the preemption modelt o "Preemptible Kernel (Basic RT)" eve=
rything works fine.

Hope someone already had the same or similar problem and can help me so=
lving it.
Maybe a update to=A0 3.4.27-rt39 helps?

Thanks a lot

=46lorian Belser

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
