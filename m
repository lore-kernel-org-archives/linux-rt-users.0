From: Ran Shalit <ranshalit@gmail.com>
Subject: Ethernet chunks behavior
Date: Sun, 10 Dec 2017 17:40:27 +0200
Message-ID: <CAJ2oMhLR0U3kPB1fYxdTvVoy4FuNDBW2xj7CswiWkATZhROFww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:42570 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751792AbdLJPk3 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 10 Dec 2017 10:40:29 -0500
Received: by mail-wm0-f50.google.com with SMTP id b199so6533755wme.1
        for <linux-rt-users@vger.kernel.org>; Sun, 10 Dec 2017 07:40:28 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

We use rt patch with UBUNTU,and have a "high priority" thread with 1
millisecond periodic rate.
That rt thread, also send UDP Ethernet packets.
This project was ported from VXWORKS project, but we notice the
following difference:
Although the rt thread gets its 1 millisecond periodic in high
accuracy, the udp is being send in chunks, as if several messages are
aggregated before being delivered.

Is there any reason for such behavior ?

Regards,
Ran
