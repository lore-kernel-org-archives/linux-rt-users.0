From: "Jaswinder Singh" <jaswinderlinuxrt@gmail.com>
Subject: Cyclictest expected results
Date: Sun, 30 Sep 2007 21:07:19 +0530
Message-ID: <1985e0f60709300837l1b16deedgb15575bc73a729ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.224]:59705 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757423AbXI3PhW (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 30 Sep 2007 11:37:22 -0400
Received: by wr-out-0506.google.com with SMTP id 36so1633559wra
        for <linux-rt-users@vger.kernel.org>; Sun, 30 Sep 2007 08:37:21 -0700 (PDT)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello all,

I am testing Cyclictest. And looking for results as in :

http://rt.wiki.kernel.org/index.php/Cyclictest

Here are my results on Intel Pentium 4 :

Command line :  ./cyclictest -t 1 -p 80 -i 10000 -l 10000 -q

2.6.23-rc4 :
WARNING: High resolution timers not available
T: 0 ( 1999) P:80 I:10000 C:  10000 Min:    110 Act: 5556 Avg: 5952 Max:    8021

2.6.23-rc4-rt1 :
WARNING: High resolution timers not available
T: 0 (13711) P:80 I:10000 C:  10000 Min:    999 Act: 5991 Avg: 3823 Max:    6493

2.6.23-rc8 :
WARNING: High resolution timers not available
T: 0 ( 1966) P:80 I:10000 C:  10000 Min:     83 Act: 4823 Avg: 6011 Max:    8029

2.6.23-rc8-rt1 :
WARNING: High resolution timers not available
T: 0 ( 2003) P:80 I:10000 C:  10000 Min:   1500 Act: 6129 Avg: 4502 Max:    7832


Command line :  ./cyclictest -t 1 -p 80 -n -i 10000 -l 10000 -q

2.6.23-rc4 :
WARNING: High resolution timers not available
T: 0 ( 2005) P:80 I:10000 C:  10000 Min:     56 Act: 4827 Avg: 5998 Max:    8016

2.6.23-rc4-rt1 :
WARNING: High resolution timers not available
T: 0 (13668) P:80 I:10000 C:  10000 Min:    389 Act: 3793 Avg: 3819 Max:    7640

2.6.23-rc8 :
WARNING: High resolution timers not available
T: 0 ( 1982) P:80 I:10000 C:  10000 Min:    519 Act: 6121 Avg: 6035 Max:    8017

2.6.23-rc8-rt1 :
WARNING: High resolution timers not available
T: 0 ( 2007) P:80 I:10000 C:  10000 Min:    901 Act: 6334 Avg: 3956 Max:    6957


>From where I can get Linux-2.6.16-hrt5 and Linux-2.6.16-rt12 patches.

CONFIG_HIGH_RES_TIMERS=y are defined in .config then why I am getting
"WARNING: High resolution timers not available".

Why my results are not so impressive in realtime even though I defined:
CONFIG_PREEMPT_RT=y
CONFIG_PREEMPT=y
CONFIG_PREEMPT_SOFTIRQS=y
CONFIG_PREEMPT_HARDIRQS=y
CONFIG_PREEMPT_BKL=y


Min, Avg and Max are showing cyclic latencies. Ideally It should be
ZERO. Am I right ?

Thank you,

Jaswinder Singh.
