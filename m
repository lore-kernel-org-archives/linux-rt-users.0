From: "Denis Borisevich" <dennisfen@gmail.com>
Subject: Strange device behavior on SMP system with CONFIG_PREEMPT_RT patch
Date: Thu, 13 Nov 2008 13:20:17 +0300
Message-ID: <902d99b50811130220v3e6a31a7n826031863afb79ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:27694 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006AbYKMKUS (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 13 Nov 2008 05:20:18 -0500
Received: by wa-out-1112.google.com with SMTP id v27so406905wah.21
        for <linux-rt-users@vger.kernel.org>; Thu, 13 Nov 2008 02:20:17 -0800 (PST)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi everybody,
I noticed a strange behavior of my PCI->RS422 adapter (MOXA CP-132
using mxer kernel module) on SMP x86 system with kernel 2.6.26.6-rt11.
This PCI board has 2 RS422/RS485 ports. When I try to send cyclicaly
some ammount of data more than 16 bytes (it's internal buffer is 16
bytes) from the second port to the first the data is lost at random
iteration. If I try to send from first port to the second everything
works fine no matter which ammount of data I write to the port. It
seems that interrupts get lost.
Can somebody help me with this problem? What can cause such a behavior?

Thanks in advance,
Denis
