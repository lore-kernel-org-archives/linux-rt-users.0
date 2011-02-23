From: Dennis Borgmann <dennis.borgmann@googlemail.com>
Subject: ARM AT91SAM9260 - RT patched system not running
Date: Wed, 23 Feb 2011 12:37:15 +0100
Message-ID: <4D64F16B.3000009@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51701 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753025Ab1BWLh2 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 23 Feb 2011 06:37:28 -0500
Received: by fxm17 with SMTP id 17so3822866fxm.19
        for <linux-rt-users@vger.kernel.org>; Wed, 23 Feb 2011 03:37:27 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello rt-list!

I have compiled Kernel 2.6.33.7 with rt-patches and arm-patches
(http://maxim.org.za/AT91RM9200/2.6/2.6.33-at91.patch.gz) for an ARM
AT91SAM9260. The system stops running at

Freeing init memory

I traced this down to the file linux-2.6.33.7/arch/arm/kernel/sys_arm.c
, where an assembler command does not return. Check this code snippet:

printk("HELLO 1\n");
    asm(    "add    r0, %0, %1\n\t"
        "mov    r1, %2\n\t"
        "mov    r2, %3\n\t"
        "bl    memmove\n\t"    /* copy regs to top of stack */
        "mov    r8, #0\n\t"    /* not a syscall */
        "mov    r9, %0\n\t"    /* thread structure */
        "mov    sp, r0\n\t"    /* reposition stack pointer */
        "b    ret_to_user"
        :
        : "r" (current_thread_info()),
          "Ir" (THREAD_START_SP - sizeof(regs)),
          "r" (&regs),
          "Ir" (sizeof(regs))
        : "r0", "r1", "r2", "r3", "ip", "lr", "memory");
printk("HELLO 2\n");

"HELLO 1" can still be read, "HELLO 2" never appears.

Any idea, what could be the problem?

Kind regards,
Dennis
