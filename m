From: Joachim Achtzehnter <joachima@netacquire.com>
Subject: Undesirable priority inversion for real-time threads that use timerfd
Date: Fri, 2 Sep 2016 17:25:55 -0700
Message-ID: <e1363850-537a-f6d1-52c7-3e7398374b49@netacquire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from penguin.kraut.ca ([96.53.60.142]:51347 "EHLO penguin.kraut.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751765AbcICA41 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 2 Sep 2016 20:56:27 -0400
Received: from [184.71.173.194] (helo=[205.159.216.152])
        by penguin.kraut.ca with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <joachima@netacquire.com>)
        id 1bfyea-00027w-Uq
        for linux-rt-users@vger.kernel.org; Fri, 02 Sep 2016 17:17:49 -0700
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

We find that real-time threads running at priorities greater than 1, 
which use the timerfd abstraction in order to simultaneously wait for 
either a timeout or another event that is reported via a file descriptor 
experience undesirable delays for the timeouts when lower-priority 
real-time threads threads are running.

This happens because the notification about timeouts depends on kernel 
threads with names like ktimersoftd/N, where N is an index for a CPU 
core on the system. These threads are scheduled with real-time priority 1.

As an obvious fix for the priority inversion we can raise the priority 
of the ktimersoftd/N kernel threads to a priority that is at least as 
high as our highest-priority thread that uses timers.

The only downside of this fix is that all timeouts used by low-priority 
threads, presumably even non-real-time threads, will briefly preempt our 
high-priority threads, although hopefully not for long, hence there may 
be some impact on throughput.

A possibly more optimal approach would be to have a separate ktimersoftd 
thread for every priority at which threads wait for timer notifications. 
We could potentially build such a facility in user code, as long as 
there is some timer available that is not dependent on ktimersoftd. What 
about Posix timers? Would they have the same issue? Anything else we 
should be looking at?

Thanks,

Joachim
