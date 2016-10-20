From: Nicolae Rosia <nicolae.rosia.oss@gmail.com>
Subject: i915 monitor hotplug on 4.1/4.4 PREEMPT
Date: Thu, 20 Oct 2016 15:15:25 +0300
Message-ID: <CAKP5S=2GhofOeDr7tv32s+WPue+QhtFYUGjdQ7Mxfh91Neh+7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        dri-devel@lists.freedesktop.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-it0-f52.google.com ([209.85.214.52]:37162 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757157AbcJTMP0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 20 Oct 2016 08:15:26 -0400
Received: by mail-it0-f52.google.com with SMTP id m138so89905376itm.0
        for <linux-rt-users@vger.kernel.org>; Thu, 20 Oct 2016 05:15:26 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

Monitor hotplugging seems to be broken on latest 4.1/4.4 RT kernel with i915.
I have tested this on non-RT kernel and it works.
I get an udev event for unplugging, but there's no event generated for
plugging the monitor back in.

Any pointers are appreciated.

Best regards,
Nicolae
