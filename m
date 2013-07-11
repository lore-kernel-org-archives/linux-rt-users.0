From: "Matthias Klein" <matthias.klein@optimeas.de>
Subject: Problem with the clock framework
Date: Thu, 11 Jul 2013 05:51:03 +0000
Message-ID: <emaa43c631-f80b-47c3-bd4e-5438822f0ad8@nb-mak>
Reply-To: "Matthias Klein" <matthias.klein@optimeas.de>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=utf-8
Content-Transfer-Encoding: 8BIT
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from optimeas.de ([78.46.18.2]:43459 "EHLO optimeas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750904Ab3GKFvF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Jul 2013 01:51:05 -0400
Received: from [127.0.0.1] (ip-5-146-126-105.unitymediagroup.de [5.146.126.105])
	by optimeas.de (Postfix) with ESMTPSA id 68D8D4207A56
	for <linux-rt-users@vger.kernel.org>; Thu, 11 Jul 2013 07:51:03 +0200 (CEST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  Hello,

I have a problem with the linux clock framework on an i.MX537 with an 
3.4.47-rt62 kernel (with freescale patches).

I writing a special driver for the ECSPI interface with support for 
automatic transmissions with the RDY signal.

When the board comes up, the clocks of the ECSPI interface are disabled. 
I tried to use the linux clock framework
with clk_get() and clk_enable() to enable these clocks. Basically it 
works, but a lot of transmissions get discontinuous:
after the first 32 bit the SPI clock stops, with a low chip select line, 
and after some milliseconds the remaining bits are transmitted.

It I use the following code to enable these clocks instead of 
clock_enable() everything works:

  volatile unsigned int *v_adr = 0;
  v_adr = ioremap_nocache(0x53FD4078, 4); // CCM Clock Gating Register 4 
(CCM_CCGR4)
  *v_adr |= 0xF << 18; // Enable CG9 + CG10
  iounmap(v_adr);

For me it looks like that some type of power managment disables the 
ECSPI clock periodically.

Is there a default behavior for power managment and these clocks, or 
does it depend on the board specific implementation ?
Can you give me some tips for analyze the problem ?


Best regards,

Matthias

