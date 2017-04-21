From: Jeff Epler <jepler@unpythonic.net>
Subject: setresuid, threads, and realtime
Date: Fri, 21 Apr 2017 10:02:59 -0500
Message-ID: <20170421150259.GE28692@unpythonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from afk.unpythonic.net ([138.68.55.246]:52192 "EHLO
        afk.unpythonic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1040563AbdDUUYA (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 Apr 2017 16:24:00 -0400
Received: from jepler by afk.unpythonic.net with local (Exim 4.84_2)
        (envelope-from <jepler@unpythonic.net>)
        id 1d1a5L-0003gP-OE
        for linux-rt-users@vger.kernel.org; Fri, 21 Apr 2017 10:02:59 -0500
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

It's been reported that in linuxcnc running on preempt-rt, when the controlling
thread calls setresuid() other RT threads in the same process see big latencies.

We started putting two and two together about this after we found that linuxcnc
running on RTAI LXRT would sometimes hard lock when the controlling thread
calls setresuid().

It appears to be beacause setresuid() does something for each thread; and this
works poorly or not at all when the threads are RT.

Is it likely that anything can be done about this state of affairs?

In the short term, I'll be migrating linuxcnc back to using setfsuid, which is
apparently per-thread.

Jeff
