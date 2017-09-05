From: Ran Shalit <ranshalit@gmail.com>
Subject: high resolution timers
Date: Tue, 5 Sep 2017 16:11:38 +0300
Message-ID: <CAJ2oMhJp8gnJ92OPL25-GSXgYxTBWYXv4AKRLoZGPZsO1CHbNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37245 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751276AbdIENLk (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 5 Sep 2017 09:11:40 -0400
Received: by mail-wm0-f50.google.com with SMTP id u26so19187650wma.0
        for <linux-rt-users@vger.kernel.org>; Tue, 05 Sep 2017 06:11:39 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

In case we need high resolution timers in userspace, is it by using
timer_xxx APIs:
timer_create
timer_settime/timergettime
?

Best Regards,
Ran
