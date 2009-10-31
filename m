From: Leon Woestenberg <leon.woestenberg@gmail.com>
Subject: -rt kernel hitting yield()s in I2C non-default code paths (2.6.24)
Date: Sat, 31 Oct 2009 10:39:35 +0100
Message-ID: <c384c5ea0910310239l549a13c5h7289ffc53ff0a648@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:53146 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756678AbZJaJjc (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 31 Oct 2009 05:39:32 -0400
Received: by bwz27 with SMTP id 27so4437555bwz.21
        for <linux-rt-users@vger.kernel.org>; Sat, 31 Oct 2009 02:39:36 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,


yesterday while debugging embedded systems I noticed the non-happy
paths in the I2C code hitting yield() code, this resulted in
a BUG: RT-Task yielding. This was with 2.6.24 (yes I know).

A real-time task (prio 99, low real-time priority) on the generic
workqueue was executing I2C functions, such as try_address() and
hitting the yield().

http://lxr.linux.no/#linux+v2.6.31/drivers/i2c/algos/i2c-algo-bit.c#L319

Further grepping shows yield()s sprinkled throughout device driver
code, especially in the non-default execution paths.

What's the -rt devs opinion on this one?

For most of the yield()s I really could not think why they are there...

Regards,
-- 
Leon
