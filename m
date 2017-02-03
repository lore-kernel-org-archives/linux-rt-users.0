From: Ran Shalit <ranshalit@gmail.com>
Subject: Understanding cyclictest result
Date: Fri, 3 Feb 2017 10:13:15 +0200
Message-ID: <CAJ2oMh+e-pH53KOckXcKB-FdRxnrdtTxprGvEifvUeA1=dG6gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37396 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752663AbdBCINR (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 3 Feb 2017 03:13:17 -0500
Received: by mail-wm0-f44.google.com with SMTP id v77so15629948wmv.0
        for <linux-rt-users@vger.kernel.org>; Fri, 03 Feb 2017 00:13:17 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

I am beginner with RT patch, and cyclictest.

I have installed ubuntu 12.04 lts, and used the binary of 3.18 kernel from:
https://bitbucket.org/thismaechler/ubuntustudio-14.04-realtimeaudio/src/65ac2d9fce70f63479ef4a8f4764743cc7dc9b11/rt-kernel/HOWTO?at=master&fileviewer=file-view-default
I have verified with uname -a that it is linux-rt version.

I then tested with cyclictest , for interval of 1msec (1000usec)
 cyclictest -t1 -p 80 -n -i 1000 -l 10000
and got max value of 180usec.

On comparing my results to resuls examples given in
https://rt.wiki.kernel.org/index.php/Cyclictest
it seems like a very large number.
I know it depends on hardware (I am using Atom, one core only.), yet
becuase I'm not too experienced with it, I am not sure if my real
problem is HW or doing wrong testing/RTpatch.
I also see that it is much better then results before applying RT
patch (3000usec)


Another thing is that I also noticed that cpu load of 100% gives same
max value as if I just interrupt the console with several enter
clicks, from this I assume that load of 50% will probably won't change
this max value to a lower one.

Best Regards,
Ran
