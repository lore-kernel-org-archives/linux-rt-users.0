From: Jonathan Weinert <jonathan.weinert@googlemail.com>
Subject: Latency and jitter inconsistent
Date: Mon, 28 Aug 2017 16:01:42 +0200
Message-ID: <CAN7nEeCjHwb=OpQYkJ=r7SMy=KJUmwvWGSPPDd+ohRxkbTcqAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-it0-f54.google.com ([209.85.214.54]:35715 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751170AbdH1OBo (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 28 Aug 2017 10:01:44 -0400
Received: by mail-it0-f54.google.com with SMTP id f1so2405506ith.0
        for <linux-rt-users@vger.kernel.org>; Mon, 28 Aug 2017 07:01:44 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

I made various measurements with a ls1021a-twr and a
rt-preemption-patch kernel. I was able to capture the latency with
cyclictest which can be seen in picture 1.

In addtion I captured the periodic jitter of a realtime-application
which outputs a square wave which can be seen in picture 2. This
Applikation was initialised with a priority of 99 as well as the
arguments of cyclictest.

In short I could measure these times with a system without load:

Latency with the command: cyclictest -l 3600000 -m -n -p 99 -i 1000 -> 47 us
Periodic jitter with  prio 99, mlockall, clock_nanosleep and
monotic_clock -> 17.04 us

How is this possible? I know there is the possibility that a
oscilloscope can have blind times but not with that amount of cycles.
(21600000 with a cycle time of 1ms)

Picture 1: http://imgur.com/a/Kaaje
Picture 2: http://imgur.com/a/PNxbo

I would be grateful for an answer!

Best regards

J. Weinert
