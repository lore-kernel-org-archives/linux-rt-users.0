From: Ran Shalit <ranshalit@gmail.com>
Subject: EDF - "earliest deadline first" scheduler
Date: Sun, 2 Apr 2017 17:27:31 +0300
Message-ID: <CAJ2oMhLpi4bPS24MZ9YOtSiEMDu7DPw56YsTmcc2qTrdCsgv2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wr0-f171.google.com ([209.85.128.171]:35603 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751460AbdDBO1d (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 2 Apr 2017 10:27:33 -0400
Received: by mail-wr0-f171.google.com with SMTP id k6so130823074wre.2
        for <linux-rt-users@vger.kernel.org>; Sun, 02 Apr 2017 07:27:33 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

I have found in
https://wiki.linuxfoundation.org/realtime/documentation/howto/applications/cyclic
that there is EDF scheduler option for creating a periodic RT thread.
Yet, I could not understand what's behind the EDF scheduler. Is it
using posix or non-posix timer ?

I have also found the following information:
http://lxr.free-electrons.com/source/Documentation/scheduler/sched-deadline.txt
Yet it does not provide more details about the timer used with EDF.

Thank you,
Ran
