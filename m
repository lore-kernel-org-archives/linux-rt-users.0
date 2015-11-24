From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Triggering BUG on SIGSEGV signaling
Date: Tue, 24 Nov 2015 12:09:12 +0100
Message-ID: <2830783.CAkrTrFBlp@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:51819 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753766AbbKXLJQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 24 Nov 2015 06:09:16 -0500
Received: from imapserver.systec-electronic.com (unknown [212.185.67.146])
	by webbox1416.server-home.net (Postfix) with ESMTPA id DD9D227A533
	for <linux-rt-users@vger.kernel.org>; Tue, 24 Nov 2015 12:09:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by imapserver.systec-electronic.com (Postfix) with ESMTP id C234ADA0C47
	for <linux-rt-users@vger.kernel.org>; Tue, 24 Nov 2015 12:09:14 +0100 (CET)
Received: from imapserver.systec-electronic.com ([127.0.0.1])
	by localhost (imapserver.systec-electronic.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FthMdIDJSxUD for <linux-rt-users@vger.kernel.org>;
	Tue, 24 Nov 2015 12:09:13 +0100 (CET)
Received: from ws-stein.localnet (ws-stein.systec.local [192.168.10.125])
	by imapserver.systec-electronic.com (Postfix) with ESMTPA id 03E9BDA0ABA
	for <linux-rt-users@vger.kernel.org>; Tue, 24 Nov 2015 12:09:13 +0100 (CET)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On our system (i.MX35 based, so ARMv6) is running a v3.10.47-rt50 kernel, I get the following output from serial console when the application tries to dereference a NULL pointer:
> BUG: sleeping function called from invalid context at kernel/rtmutex.c:659
> in_atomic(): 0, irqs_disabled(): 128, pid: 648, name: plccore-imx35-h
> CPU: 0 PID: 648 Comm: plccore-imx35-h Tainted: G           O 3.10.47-rt50 #1
> [<c001367c>] (unwind_backtrace+0x0/0x130) from [<c0011e50>] (show_stack+0x10/0x14)
> [<c0011e50>] (show_stack+0x10/0x14) from [<c03b0738>] (rt_spin_lock+0x18/0x2c)
> [<c03b0738>] (rt_spin_lock+0x18/0x2c) from [<c002fd44>] (do_force_sig_info+0x20/0xd8)
> [<c002fd44>] (do_force_sig_info+0x20/0xd8) from [<c0017dac>] (__do_user_fault+0x98/0xd8)
> [<c0017dac>] (__do_user_fault+0x98/0xd8) from [<c0018144>] (do_bad_area+0x6c/0x88)
> [<c0018144>] (do_bad_area+0x6c/0x88) from [<c00181cc>] (do_translation_fault+0x6c/0xa8)
> [<c00181cc>] (do_translation_fault+0x6c/0xa8) from [<c0008344>] (do_DataAbort+0x34/0x9c)
> [<c0008344>] (do_DataAbort+0x34/0x9c) from [<c000e914>] (__dabt_usr+0x34/0x40)
> Exception stack(0xc5c91fb0 to 0xc5c91ff8)
> 1fa0:                                     efcdefcd 00000001 00000001 00084690
> 1fc0: 00000010 00000000 00000000 00000003 014dd2c4 00000002 00000000 000000ff
> 1fe0: 0c8a7b41 be8c9b58 000219a8 000219c8 60000010 ffffffff

Reading the backtrace it seems that might_sleep() in rt_spin_lock_fastlock() raises this dump. The interrupts are apparently disabled.
Following the code path it seems to me, that (at lease in this case) ARCH_RT_DELAYS_SIGNAL_SEND must be supported on ARM too which AFAICS is for sending signals while being in_atomic.
Any comments on this? I wonder what makes this so special it didn't came up yet.

Best regards,
Alexander
-- 
Dipl.-Inf. Alexander Stein
SYS TEC electronic GmbH
alexander.stein@systec-electronic.com

Legal and Commercial Address:
Am Windrad 2
08468 Heinsdorfergrund
Germany

Office: +49 (0) 3765 38600-0
Fax:    +49 (0) 3765 38600-4100
 
Managing Directors:
	Director Technology/CEO: Dipl.-Phys. Siegmar Schmidt;
	Director Commercial Affairs/COO: Dipl. Ing. (FH) Armin von Collrepp
Commercial Registry:
	Amtsgericht Chemnitz, HRB 28082; USt.-Id Nr. DE150534010

