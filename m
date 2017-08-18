From: Cliff Brake <cliff.brake@gmail.com>
Subject: how fast can you run a hrtimer?
Date: Fri, 18 Aug 2017 08:35:56 -0400
Message-ID: <CAOd_LFwErYmZS-5b=a1O8DkqpAZqhgGXwnLhHHWZ8NnheK72Xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Cliff Brake <cbrake@bec-systems.com>
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lf0-f50.google.com ([209.85.215.50]:37046 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751167AbdHRMf7 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 18 Aug 2017 08:35:59 -0400
Received: by mail-lf0-f50.google.com with SMTP id f7so22144342lfg.4
        for <linux-rt-users@vger.kernel.org>; Fri, 18 Aug 2017 05:35:58 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I have an application where we need to tweak a PWM setting every 10uS.
My impression is this is beyond the capabilities of linux+rt, but want
to verify I'm not missing anything before we add an external
microcontroller to handle this.

I've run some experiments on a i.MX6UL with v4.1+rt, and observe
delays of ~50us when toggling a GPIO in a Linux driver using a
hrtimer.

Thanks,
Cliff

-- 
=================
http://bec-systems.com
