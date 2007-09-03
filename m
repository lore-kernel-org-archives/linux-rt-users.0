From: "Pradyumna Sampath" <pradyumna.sampath@gmail.com>
Subject: rc4-rt1: powerpc compile errors
Date: Mon, 3 Sep 2007 16:53:43 +0530
Message-ID: <f87351060709030423t1ac14f3cqd0cd224ba7dba9c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org, linuxppc-embedded@ozlabs.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:32599 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904AbXICLXo (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 3 Sep 2007 07:23:44 -0400
Received: by py-out-1112.google.com with SMTP id u77so4839231pyb
        for <linux-rt-users@vger.kernel.org>; Mon, 03 Sep 2007 04:23:43 -0700 (PDT)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi everyone,

Here are some compile errors from the latest -rt patchset for powerpc
(mpc5200).

arch/powerpc/kernel/entry_32.S: Assembler messages:
arch/powerpc/kernel/entry_32.S:231: Error: operand out of range
(0x00023d87 is not between 0x00000000 and 0x0000ffff)
arch/powerpc/kernel/entry_32.S:644: Error: operand out of range
(0x00022006 is not between 0x00000000 and 0x0000ffff)
arch/powerpc/kernel/entry_32.S:866: Error: operand out of range
(0x00020004 is not between 0x00000000 and 0x0000ffff)
arch/powerpc/kernel/entry_32.S:880: Error: operand out of range
(0x00020004 is not between 0x00000000 and 0x0000ffff)

Im not sure whether this is the right thing to do but we got around
this by replacing the linux/include/asm-powerpc/thread_info.h with an
older version of the same file from 2.6.21-rt3.

regards
/prady

-- 
htp://prady.livejournal.com
