From: Ran Shalit <ranshalit@gmail.com>
Subject: How to merge patch into specific kernel version
Date: Fri, 17 Feb 2017 16:04:52 +0200
Message-ID: <CAJ2oMhLrXcZcS-ZzgOAhfq26jHEpD1GB8hy8rGTkm-jJs547eQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37972 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933930AbdBQOEz (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 17 Feb 2017 09:04:55 -0500
Received: by mail-wm0-f47.google.com with SMTP id r141so10886924wmg.1
        for <linux-rt-users@vger.kernel.org>; Fri, 17 Feb 2017 06:04:54 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

I've noticed that rt-preempt patches comes usually for a specific
kernel version.

In case I have some kernel version which does not match the RT patch
exactly, yet should be applied with the patch:
Are there any tips/rules as to how to merge the patch into sources ?

Thanks you,
Ran
