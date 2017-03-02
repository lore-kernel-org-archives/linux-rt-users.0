From: Ran Shalit <ranshalit@gmail.com>
Subject: How to write RT applications ?
Date: Thu, 2 Mar 2017 15:52:32 +0200
Message-ID: <CAJ2oMhJp-uBxxj7tyPHM2M9cFnjhus4ORYYfFgNywaMFXS4Q9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37626 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751839AbdCBN7u (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 2 Mar 2017 08:59:50 -0500
Received: by mail-wm0-f41.google.com with SMTP id n11so25630382wma.0
        for <linux-rt-users@vger.kernel.org>; Thu, 02 Mar 2017 05:58:58 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

I have followed
https://rt.wiki.kernel.org/index.php/HOWTO:_Build_an_RT-application

Yet, I found in Xenomai documentation a lot of ideas as to how to take
care that rt threads will not move from rt mode, to non-rt mode.

I know it is different concepts, yet, I wander if in RT Linux there
are also similar ideas, that should be taken care of when writing
application, in order to be assure that real time threads behave as
expected.

Thank you!
Ran
