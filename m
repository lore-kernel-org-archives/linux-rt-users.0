From: "Leon Woestenberg" <leon.woestenberg@gmail.com>
Subject: cyclictest -t NUM argument not honoured
Date: Sat, 14 Jun 2008 01:40:33 +0200
Message-ID: <c384c5ea0806131640m391e650bn6f042f2f08b038eb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.247]:17899 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756458AbYFMXke (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Jun 2008 19:40:34 -0400
Received: by an-out-0708.google.com with SMTP id d40so1032126and.103
        for <linux-rt-users@vger.kernel.org>; Fri, 13 Jun 2008 16:40:33 -0700 (PDT)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

I noticed many of my tests were bogus, as somehow my "-t NUM" argument
is not parsed properly on my target:

Linux efika 2.6.25.4-rt6 #10 PREEMPT RT Thu Jun 12 00:34:11 CEST 2008
ppc unknown

cyclictest 0.21 (with some extra argument printing added)

root@efika:~# /cyclictest -t 2 -n -p 50
threads = 1
started with interval 1000

T: 0 ( 1178) P:50 I:1000 C:    333 Min:     45 Act:   46 Avg:   49 Max:     100

root@efika:~# /cyclictest -t2 -n -p 50
threads = 2
started with interval 1000
started with interval 1500

on my x86/32 system the same happens (with -t 4 it defaults to 2
because it's a dual-core, with -t4 it works).

leon@witty:/tmp$ sudo ./cyclictest -t 4 -p 50
threads = 2
started with interval 1000
started with interval 1500
0.02 0.07 0.14 1/231 11760

T: 0 (11759) P:50 I:1000 C:      0 Min:1000000 Act:    0 Avg:    0 Max:-1000000
T: 1 (11760) P:49 I:1500 C:      0 Min:1000000 Act:    0 Avg:    0 Max:-1000000

leon@witty:/tmp$ sudo ./cyclictest -t4 -p 50
threads = 4
started with interval 1000
started with interval 1500
started with interval 2000
started with interval 2500
0.01 0.06 0.14 1/233 11765

T: 0 (11762) P:50 I:1000 C:      0 Min:1000000 Act:    0 Avg:    0 Max:-1000000
T: 1 (11763) P:49 I:1500 C:      0 Min:1000000 Act:    0 Avg:    0 Max:-1000000
T: 2 (11764) P:48 I:2000 C:      0 Min:1000000 Act:    0 Avg:    0 Max:-1000000
T: 3 (11765) P:47 I:2500 C:      0 Min:1000000 Act:    0 Avg:    0 Max:-1000000

At this moment I am puzzled, but I suspect the optional_argument handling.

NAME
       getopt - Parse command line options
...
BUGS
       This manpage is confusing.


Regards,
-- 
Leon
