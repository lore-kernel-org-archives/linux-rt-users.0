From: "Matthias Klein" <matthias.klein@optimeas.de>
Subject: Kernel modules: atomic GPIO access on PREEMPT_RT
Date: Sat, 29 Jun 2013 07:11:03 +0000
Message-ID: <emcf19860c-9857-436b-874a-5daee54f378f@nb-mak>
Reply-To: "Matthias Klein" <matthias.klein@optimeas.de>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=utf-8
Content-Transfer-Encoding: 8BIT
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from optimeas.de ([78.46.18.2]:45406 "EHLO optimeas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751950Ab3F2HLF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 29 Jun 2013 03:11:05 -0400
Received: from [127.0.0.1] (p5DCF440C.dip0.t-ipconnect.de [93.207.68.12])
	by optimeas.de (Postfix) with ESMTPSA id D626C4207A57
	for <linux-rt-users@vger.kernel.org>; Sat, 29 Jun 2013 09:11:02 +0200 (CEST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

I am working on kernel modules on an i.MX537 ARM platform where we use 
GPIO pins to control various
external chips, LEDs etc.

For accessing these ports I use ioremap_nocache(). But I only want to 
use single bits of these big 32 ports,
and some other kernel modules should reuse the other free pins of that 
port.

Therefore I am afraid about the shared simultaneously registers access 
between:
- 2 kernel modules (user contex)
- interrupt context (IRQF_NODELAY) and simultaneously from the user 
context (ioctl() etc.) in the kernel module


What is the right way to access these registers for e.g setting a single 
bit of such a register to avoid read/modify/write problems ?
Do I have to use some locking / atomic operations ?


Can someone recommend a kernel driver for studying where such shared 
registers access is used / handled?


Best regards,

Matthias

