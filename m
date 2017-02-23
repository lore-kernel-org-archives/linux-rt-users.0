From: Ran Shalit <ranshalit@gmail.com>
Subject: running RT in ubuntu in virtualbox
Date: Thu, 23 Feb 2017 19:14:00 +0200
Message-ID: <CAJ2oMhLBex5fuqPfSEcCw3ubg2pW8hZFtA6fViqs-DYKWSHCVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:32783 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751284AbdBWROT (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 23 Feb 2017 12:14:19 -0500
Received: by mail-wm0-f53.google.com with SMTP id t18so4404557wmt.0
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Feb 2017 09:14:01 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

I tried to run ubuntu 14.4 with RT

I am using machinekit binary for that:
linux-image-4.1.15-rt17mah

Yet, on starting ubuntu I get "vboxclient the virtualbox kernel
service is not running"
and it seems that all guestadditions capabilties are missing.

Is anyone familiar with it ?

Another question, in case I want development machine for a target
which runs ubuntu 14.4 with linux-image-4.1.15-rt17mah, does it really
matters if the development station runs with same kernel
(linux-image-4.1.15-rt17mah) ?

Best Regards,
Ran
