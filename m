From: Brian Wrenn <dcbrianw@gmail.com>
Subject: Fail to load module wcn36xx
Date: Fri, 27 Jan 2017 15:54:59 -0500
Message-ID: <CAEYdEeT960G82ONFrRSrzzxMajFfGp3tSDqU5NBCGcx00ci4gA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:33747 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751354AbdA0UzP (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 27 Jan 2017 15:55:15 -0500
Received: by mail-io0-f195.google.com with SMTP id 101so9148691iom.0
        for <linux-rt-users@vger.kernel.org>; Fri, 27 Jan 2017 12:55:10 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I'm trying to get the WLAN wcn36xx driver to load on PRREMPT RT.

By some fluke I had this module load successfully in the PREEMPT RT
kernel at one point in time, but I have not been able to reproduce
getting to to load since my first trial build.

I'm patching Linaro 4.4.9 with PREEMPT RT patch 4.4.9-rt17.  I've also
manually applied a patch for
kernel/drivers/pinctrl/qcom/pinctrl-msm.c, which replaces uses of
spinlock calls with raw_spinlock calls.

Here's the dmesg output, which indicates unknown symbols as the
problem.  However, I'm not sure why this module can't load those
symbols.

I can successfully load them if I just build plain Linaro 4.4.9,
without PREEMPT RT.

[   14.023055] wcn36xx: Unknown symbol mutex_lock (err 0)
[   14.023105] wcn36xx: Unknown symbol __mutex_init (err 0)
[   14.027153] wcn36xx: Unknown symbol mutex_unlock (err 0)
[   14.027208] wcn36xx: Unknown symbol _raw_spin_unlock (err 0)
[   16.961824] wcn36xx: Unknown symbol mutex_lock (err 0)
[   16.961889] wcn36xx: Unknown symbol __mutex_init (err 0)
[   16.965955] wcn36xx: Unknown symbol mutex_unlock (err 0)
[   16.971391] wcn36xx: Unknown symbol _raw_spin_unlock (err 0)

Thanks for any help,
Brian
