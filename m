From: Ran Shalit <ranshalit@gmail.com>
Subject: syscall from userspace thread
Date: Sun, 5 Feb 2017 00:06:13 +0200
Message-ID: <CAJ2oMh+=AfyLd3XEP-dBVn9f20BLNU=y9382xDLxd0UyRv5uRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38315 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750944AbdBDWGP (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 4 Feb 2017 17:06:15 -0500
Received: by mail-wm0-f43.google.com with SMTP id r141so76104037wmg.1
        for <linux-rt-users@vger.kernel.org>; Sat, 04 Feb 2017 14:06:14 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

I made reading on RT PREEMPT, but didn't find some rules/methods, to
make sure that a real time thread keeps its deadline.
For example:
 Can I use in the userspace thread any syscall , or will it results in
thread preemption ?

Regards,
Ran
