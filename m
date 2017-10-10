From: Victor Moreno Calvo <victor.morenocal@gmail.com>
Subject: Trace code
Date: Tue, 10 Oct 2017 21:40:30 +0200
Message-ID: <CANBvECE8jmVTZSEOV7SBu4X0Toq0oe_7wchXJNiOFJxtzMCn6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:46806 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751858AbdJJTkb (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 10 Oct 2017 15:40:31 -0400
Received: by mail-wm0-f50.google.com with SMTP id m72so92648wmc.1
        for <linux-rt-users@vger.kernel.org>; Tue, 10 Oct 2017 12:40:31 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

My company has decided to move to Linux using the PREEMPT patch for
some simulators.

We are at the initial phase of the project, so we do not have enough
experience and data to get the maximum performance or the right tools.

The purpose of this email is to get an idea or more info to know how
it is possible to measure latency in our code (C++). Are there any
libraries to measure times for cyclic task or should we use a discrete
analyzer?


Regards.
