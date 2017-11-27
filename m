From: Ran Shalit <ranshalit@gmail.com>
Subject: Can jitter also be smaller than amount of time or only bigger ?
Date: Mon, 27 Nov 2017 18:25:23 +0200
Message-ID: <CAJ2oMhLh0V0k1Awf5OM-FKmMB7Ex9=D+CtVxZv+cr0MgNR5n9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:39666 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753111AbdK0QZZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 27 Nov 2017 11:25:25 -0500
Received: by mail-wm0-f41.google.com with SMTP id x63so36037788wmf.4
        for <linux-rt-users@vger.kernel.org>; Mon, 27 Nov 2017 08:25:25 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

When using rt linux, does it mean that the jitter is in both direction
or only bigger than amount of time for wait ?
For example, if we set periodic timer for 1msec, can it also be that
we get the interrupt before the 1msec period ended ?

Thank you.
Ran
