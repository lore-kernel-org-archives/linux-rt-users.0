From: Ran Shalit <ranshalit@gmail.com>
Subject: better performance during stress
Date: Mon, 4 Dec 2017 19:06:44 +0200
Message-ID: <CAJ2oMhJX7hVzB0DEjvtuCmP+AAenYhR_yQZWCbGD2pOjOpFzNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:42131 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752020AbdLDRGq (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 4 Dec 2017 12:06:46 -0500
Received: by mail-wm0-f48.google.com with SMTP id l141so7130218wmg.1
        for <linux-rt-users@vger.kernel.org>; Mon, 04 Dec 2017 09:06:46 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,


I would like to ask if anyone familiar with results showing better
performance during stress.
We expected (and seen) usually degraded performance during stress, so
such result is a surprise.
I use cyclictest and see that both average and maximum have lower
value during stress.
The chip is i7.

Thank you.
Ran
