From: "Girish kathalagiri" <girish.sk@gmail.com>
Subject: Scheduling behaviour of 23-rc4-rt1 on my intel centrino Duo.
Date: Wed, 26 Sep 2007 08:05:35 +0530
Message-ID: <34ac6d890709251935x390bee54ma761ed05f73d95a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:65401 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754499AbXIZCfh (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 25 Sep 2007 22:35:37 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1855830nfb
        for <linux-rt-users@vger.kernel.org>; Tue, 25 Sep 2007 19:35:36 -0700 (PDT)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,
I am running Linux 2.6.21-rc4-rt1 on my IBM thinkpad T60 (I have
attached the cpuinfo).
When i run the hourglass ( http://www.cs.utah.edu/~regehr/hourglass/)
,6 threads each of priority RTHIGH (maxpriority-2).
Only one thread (thread 0) seems to be running on cpu#0, all the other
thread seems to be competing with each other on cpu#1.

command : ./hourglass -n 6 -a -d 60s -w CPU -i HR -p RTHIGH
here is a part of output from the hourglass test
----------------------------------------------------------
thread 0 will use high-res timers
thread 1 will use high-res timers
thread 2 will use high-res timers
thread 3 will use high-res timers
thread 4 will use high-res timers
thread 5 will use high-res timers
thread 0 will have priority RTHIGH
thread 1 will have priority RTHIGH
thread 2 will have priority RTHIGH
thread 3 will have priority RTHIGH
thread 4 will have priority RTHIGH
thread 5 will have priority RTHIGH
8.010864 MB allocated for trace records
Hourglass 1.0.1b : 6 threads; 60.000000 seconds; 1828.999688 MHz
timestamp counter
max gap is 63980 cycles
this test will last for  60.000000 seconds
numthreads: 6
work done by thrd 0 : 430394547
work done by thrd 1 : 42208618
work done by thrd 2 : 86995526
work done by thrd 3 : 86819711
work done by thrd 4 : 86887798
work done by thrd 5 : 86101724

thread 0 recorded 60.040444 seconds (99.999946 %)
thread 1 recorded 12.037532 seconds (20.049028 %)
 thread 2 recorded 12.030190 seconds (20.036800 %)
thread 3 recorded 12.005801 seconds (19.996179 %)
 thread 4 recorded 12.015195 seconds (20.011824 %)
thread 5 recorded 11.907206 seconds (19.831964 %)
 -------------------------------------------------------------------------------

Should not the threads be schedule fairly between the two cpu's, like
say ,3 threads competing for cpu#0 and other 3 for cpu#1 ?
 Or Am i missing something here ?

-- 
Thanks
   Giri
