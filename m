From: Federico Reghenzani <federico.reghenzani@polimi.it>
Subject: Disable lapic timer
Date: Thu, 22 Dec 2016 14:36:03 +0100
Message-ID: <CACKey4zCv-B1EkcmzzAGpUMC5CyjyAfOEgfSmNS0Z=8cNe8R6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-db5eur01on0080.outbound.protection.outlook.com ([104.47.2.80]:4145
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S941153AbcLVNgx (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 22 Dec 2016 08:36:53 -0500
Received: by mail-oi0-f43.google.com with SMTP id b126so241897281oia.2
        for <linux-rt-users@vger.kernel.org>; Thu, 22 Dec 2016 05:36:28 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi all,

I found this very old topic

https://www.spinics.net/lists/linux-rt-users/msg05422.html

is there any update on this? I want to disable the APIC timer in order
to increase the determinism of my system, but I'm not sure if this is
possible without editing the kernel source code.

On my machine smp_apic_timer_interrupt takes 2-3 us, I know this is
already low, but it's actually the only "frequent" latency that I have
on the isolated cpu.


Thank you,
Federico Reghenzani
