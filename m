From: Andy Ng <andreas2025@gmail.com>
Subject: wake_up does not return
Date: Wed, 25 Jan 2017 13:54:15 +0000
Message-ID: <CAAVaN8wqmh9qYYU7TXR58-0=5Lk_s1vMcdHKdWEp4Ln9iEf=wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ua0-f171.google.com ([209.85.217.171]:34682 "EHLO
        mail-ua0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752001AbdAYNyR (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 25 Jan 2017 08:54:17 -0500
Received: by mail-ua0-f171.google.com with SMTP id 35so159241607uak.1
        for <linux-rt-users@vger.kernel.org>; Wed, 25 Jan 2017 05:54:16 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Dear List,

I have an interesting problem on 3.0.35 with the rt56 patch on ARM.

I have some external events that drive my ISR, which I have set it up
as non_threaded one.
When the interrupt rate is low, 1.8msec things are going fine, but
when the rate is higher, the wake_up call from the isr does not
return. The system is frozen. No Magic SysRq. Nothing.

All will work fine once I change my ISR to be a threaded one.

Any ideas where to search?

Kind regards,
Andy
