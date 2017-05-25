From: Nicolae Rosia <nicolae.rosia.oss@gmail.com>
Subject: timer_create affinity
Date: Thu, 25 May 2017 17:57:03 +0300
Message-ID: <CAKP5S=3NMzfEDdLsd6_FCNTH6o7_Qz2D6qFwx1WOdc-x2Xi0rA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-it0-f43.google.com ([209.85.214.43]:37921 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163018AbdEYO5F (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 25 May 2017 10:57:05 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

I'm working on a real-time application using POSIX timers running on a
QorIQ PowerPC platform with a 4.1 PREEMPT RT kernel and I'm trying to
understand whether the following can happen:
1. A thread with a core affinity #0 creates a timer which will invoke
a callback.
2. The kernel will setup the timer using a local timer running on a
different core, core #1
3. The ISR will fire, and could be dispatched by core #2
4. The scheduler will run the callback on core #3.

Is there a way to make sure this whole chain will be executed on a
single core, the core of the caller?

Best regards,
Nicolae Rosia
