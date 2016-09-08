From: "Hardik A Gohil (WMSC-HW)" <hardik@willowglen.asia>
Subject: Network Issue
Date: Thu, 8 Sep 2016 09:49:14 +0800
Message-ID: <CAGiFfw4o2c1f=pR+gKkVYAoHQ7V8ywLXu-_g9ahWSZoAoSD7tA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-it0-f46.google.com ([209.85.214.46]:38026 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756429AbcIHBtQ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 7 Sep 2016 21:49:16 -0400
Received: by mail-it0-f46.google.com with SMTP id c198so55286867ith.1
        for <linux-rt-users@vger.kernel.org>; Wed, 07 Sep 2016 18:49:16 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

I am working on Linux 3.2.0.

We had a requirement to make Linux Real Time so using RT-PREEMPT
(patch-3.2-rt10.patch.bz2)

We are facing a network hang issue while running the periodic task of 5 ms.

cannot ping any more when task is running is ran for some time.

I am using Timer fd protocol to achieve this.

I would like to know if there is such know issue in this patch.

Any help will be appreciated.
