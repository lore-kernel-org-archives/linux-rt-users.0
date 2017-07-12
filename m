From: Phil Edworthy <phil.edworthy@renesas.com>
Subject: hrtimers with ARM architected timer
Date: Wed, 12 Jul 2017 13:55:34 +0000
Message-ID: <HK2PR0601MB139370058E9696E9648BC8CCF5AF0@HK2PR0601MB1393.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:55902 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752305AbdGLNzj (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 12 Jul 2017 09:55:39 -0400
Received: from relmlii2.idc.renesas.com (relmlii2.idc.renesas.com [10.200.68.66])
        by relmlir2.idc.renesas.com (Postfix) with ESMTP id 735447ECA3
        for <linux-rt-users@vger.kernel.org>; Wed, 12 Jul 2017 22:55:37 +0900 (JST)
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I'm new to rt-linux, so please forgive me if I ask some dumb questions.
I have searched for a while, but not found what I am looking for.

I'm trying out the rt-linux patches (v4.9.35) on an out-of-tree BSP for
a new ARM Cortex A7 device. When I tried cyclictest, it complained that
I don't have High Resolution timers, so I checked and sure enough
/proc/timer_list showed the timer resolution is 10ms. I've checked my
kernel config and I have enabled hrtimers.

This device uses the ARM architected timer (CONFIG_ARM_ARCH_TIMER)
running at a lowly 6.25MHz.

So, how can I tell if a driver is supposed to support hrtimers?
If the ARM architected timer driver does support hrtimers, what could
stop them being used?

Thanks
Phil
