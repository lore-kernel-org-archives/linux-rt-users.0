From: Hinko Kocevar <hinko.kocevar@i-tech.si>
Subject: Poor cycletest results for rt6
Date: Fri, 29 Jul 2011 13:10:13 +0200
Message-ID: <4E329515.7080803@i-tech.si>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.i-tech.si ([89.212.78.105]:28267 "EHLO mail.i-tech.si"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756388Ab1G2LKQ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 29 Jul 2011 07:10:16 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I've build linux-3.0-rt6 for my ARM platform (XCEP). Running cycletest 
on vanilla, preempt and rt6 kernel build reviles the following results. 
I would expect better rt6 performance.

Note that last test actually looks quite promising, but it happened once 
in 5 test runs :(


Linux xcep 3.0.0 #1 Thu Jul 28 21:53:19 CEST 2011 armv5tel GNU/Linux

hinko@hinkopc ~ $ ssh root@192.168.11.132 /shared/utils/cyclictest -t 10 
-p 80 -n -D 30
WARNING: Most functions require kernel 2.6
policy: fifo: loadavg: 5.61 2.17 0.82 7/44 323

T: 0 (  295) P:80 I:1000 C:  28983 Min:     17 Act:  201 Avg:  191 Max: 
    3043
T: 1 (  296) P:79 I:1500 C:  19323 Min:     20 Act:  237 Avg:  241 Max: 
    3340
T: 2 (  297) P:78 I:2000 C:  14494 Min:     23 Act:  198 Avg:  276 Max: 
    3569
T: 3 (  298) P:77 I:2500 C:  11597 Min:     22 Act:  287 Avg:  248 Max: 
    3364
T: 4 (  299) P:76 I:3000 C:   9664 Min:     24 Act:  181 Avg:  193 Max: 
    3096
T: 5 (  300) P:75 I:3500 C:   8283 Min:     26 Act:  508 Avg:  305 Max: 
    3398
T: 6 (  301) P:74 I:4000 C:   7247 Min:     26 Act:  404 Avg:  265 Max: 
    3454
T: 7 (  302) P:73 I:4500 C:   6442 Min:     24 Act:  126 Avg:  365 Max: 
    3421
T: 8 (  303) P:72 I:5000 C:   5797 Min:     27 Act:  593 Avg:  291 Max: 
    3291
T: 9 (  304) P:71 I:5500 C:   5270 Min:     24 Act:  860 Avg:  285 Max: 
    3230


Linux xcep 3.0.0-preempt #1 PREEMPT Thu Jul 28 21:55:54 CEST 2011 
armv5tel GNU/Linux

WARNING: Most functions require kernel 2.6
policy: fifo: loadavg: 5.57 4.68 4.29 8/40 2104

T: 0 ( 2092) P:80 I:1000 C:  28997 Min:     18 Act:   44 Avg:  207 Max: 
     969
T: 1 ( 2093) P:79 I:1500 C:  19332 Min:     24 Act:   38 Avg:  214 Max: 
     968
T: 2 ( 2094) P:78 I:2000 C:  14499 Min:     24 Act:   28 Avg:  164 Max: 
     879
T: 3 ( 2095) P:77 I:2500 C:  11599 Min:     26 Act:  190 Avg:  297 Max: 
    1032
T: 4 ( 2096) P:76 I:3000 C:   9664 Min:     27 Act:  156 Avg:  227 Max: 
     878
T: 5 ( 2097) P:75 I:3500 C:   8286 Min:     26 Act:  213 Avg:  256 Max: 
    1011
T: 6 ( 2098) P:74 I:4000 C:   7248 Min:     24 Act:  261 Avg:  177 Max: 
     692
T: 7 ( 2099) P:73 I:4500 C:   6442 Min:     26 Act:  139 Avg:  263 Max: 
     967
T: 8 ( 2100) P:72 I:5000 C:   5797 Min:     31 Act:   38 Avg:  279 Max: 
     795
T: 9 ( 2101) P:71 I:5500 C:   5270 Min:     28 Act:  391 Avg:  242 Max: 
     971



Linux xcep 3.0.0-rt6 #1 PREEMPT RT Fri Jul 29 11:41:14 CEST 2011 
armv5tel GNU/Linux

4/5 iterations

WARNING: Most functions require kernel 2.6
policy: fifo: loadavg: 5.38 2.57 1.14 9/46 425

T: 0 (  404) P:80 I:1000 C:  28989 Min:     15 Act:  141 Avg:  278 Max: 
   49660
T: 1 (  405) P:79 I:1500 C:  19326 Min:     15 Act:  340 Avg:  342 Max: 
   50406
T: 2 (  406) P:78 I:2000 C:  14492 Min:     16 Act:  395 Avg:  378 Max: 
   49655
T: 3 (  407) P:77 I:2500 C:  11594 Min:     15 Act:  466 Avg:  334 Max: 
   50703
T: 4 (  408) P:76 I:3000 C:   9661 Min:     16 Act:  214 Avg:  295 Max: 
   50687
T: 5 (  409) P:75 I:3500 C:   8280 Min:     16 Act:  223 Avg:  337 Max: 
   52270
T: 6 (  410) P:74 I:4000 C:   7247 Min:     16 Act:  370 Avg:  353 Max: 
   52213
T: 7 (  411) P:73 I:4500 C:   6442 Min:     16 Act:  187 Avg:  313 Max: 
   52567
T: 8 (  412) P:72 I:5000 C:   5798 Min:     16 Act:  336 Avg:  373 Max: 
   49518
T: 9 (  413) P:71 I:5500 C:   5270 Min:     17 Act:  179 Avg:  401 Max: 
   51195


1/5 iterations

WARNING: Most functions require kernel 2.6
policy: fifo: loadavg: 3.30 1.93 0.89 6/39 386

T: 0 (  374) P:80 I:1000 C:  28067 Min:     16 Act:  104 Avg:  168 Max: 
     492
T: 1 (  375) P:79 I:1500 C:  18713 Min:     19 Act:  233 Avg:  162 Max: 
     535
T: 2 (  376) P:78 I:2000 C:  14035 Min:     24 Act:   54 Avg:  238 Max: 
     653
T: 3 (  377) P:77 I:2500 C:  11601 Min:     24 Act:  205 Avg:  245 Max: 
     597
T: 4 (  378) P:76 I:3000 C:   9668 Min:     26 Act:  135 Avg:  382 Max: 
     703
T: 5 (  379) P:75 I:3500 C:   8287 Min:     24 Act:   40 Avg:  248 Max: 
     609
T: 6 (  380) P:74 I:4000 C:   7251 Min:     25 Act:  138 Avg:  198 Max: 
     592
T: 7 (  381) P:73 I:4500 C:   6446 Min:     25 Act:  114 Avg:  255 Max: 
     683
T: 8 (  382) P:72 I:5000 C:   5800 Min:     34 Act:  204 Avg:  274 Max: 
     630
T: 9 (  383) P:71 I:5500 C:   5273 Min:     26 Act:  108 Avg:  284 Max: 
     682


-- 
Best regards,
Hinko Kocevar
