From: Gregory Haskins <ghaskins@novell.com>
Subject: Preemption-test (v1)
Date: Mon, 15 Oct 2007 12:32:09 -0400
Message-ID: <1192465929.4067.53.camel@ghaskins-t60p.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:49843 "EHLO
	victor.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760785AbXJOQej (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 15 Oct 2007 12:34:39 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

I cranked out a little test application this weekend to look at problems
in the RT scheduler.  You can find the source here.

ftp://ftp.novell.com/dev/ghaskins/preempt.cc

Here is some example output:

# ./a.out -d 40 -a
Starting test with 5 threads on 4 cpus
Calibration: 40ms = 11306781 loops
0 -> p:2 a: 1 l: 5/4 t: 32788/32847/59
1 -> p:5 a: 0 l: 8/9 t: 34401/34532/131
2 -> p:4 a: 3 l: 5/29 t: 34659/34745/86
3 -> p:3 a: 2 l: 8/7 t: 34852/34925/73
4 -> p:1 a: 0 l: 42/9 t: 74073/74116/43

---------------------------
Stats: [min: 4us @ row 0] [max: 42us @ row 4] {ave: 12us]
---------------------------
Test PASSED

------------------------------

Here is the meaning for each row, by example of row 0:

 0 -> p:2 a: 1 l: 5/4 t: 32788/32847/59

This says the first thread to exit was priority-2, affined to cpu 1,
with a latency of 5us/4us (child-start, parent-return), for a
local-relative run-time of 32.788ms, a global-relative runtime of
32.847ms, with a delta between the two of 59us.

The list is sorted by finish time.  So you can see that the priority 2
thread finished first, priority 5 finished second, 4 third, etc.  The
test considers a "PASS" to be that the top N threads (where N is
nr_cpus) finish first, the second group finish second, etc.

For instance, on a 4-core system with 10 threads, 10,9,8,7 should finish
first (though their ordering within that group may vary).  6,5,4,3
should finish second.  And finally 2,1 should finish last.  Any
violation of this ordering will be flagged as follows:


# ./a.out -t 95 -a
Starting test with 95 threads on 4 cpus
Calibration: 20ms = 5686503 loops
0 -> p:94 a: 1 l: 6/93 t: 14809/20098/5289
1 -> p:92 a: 3 l: 6/86 t: 15217/20367/5150
2 -> p:95 a: 2 l: 7/83 t: 15064/20455/5391
3 -> p:93 a: 0 l: 6/36 t: 19452/24696/5244

..<snip>...

79 -> p:15 a: 2 l: 5/57 t: 376806/378567/1761
80 -> p:16 a: 3 l: 6/59 t: 376838/378665/1827
81 -> p:13 a: 0 l: 6/17 t: 385565/387280/1715
82 -> p:14 a: 1 l: 6/13 t: 389003/390743/1740
83 -> p:11 a: 2 l: 9/14 t: 396074/397693/1619
84 -> p:12 a: 3 l: 5/67 t: 397287/398927/1640
85 -> p:9 a: 0 l: 6/6 t: 405105/406684/1579
86 -> p:10 a: 1 l: 8/12 t: 405816/407411/1595
87 -> p:7 a: 2 l: 8/14 t: 416301/417786/1485
88 -> p:8 a: 3 l: 4/66 t: 417852/419357/1505
89 -> p:6 a: 1 l: 6/10 t: 423228/424694/1466
90 -> p:5 a: 0 l: 8/9 t: 424050/425500/1450
91 -> p:3 a: 2 l: 4/8 t: 434555/435938/1383
92 -> p:4 a: 3 l: 6/33 t: 435763/437163/1400
93 -> p:2 a: 1 l: 8/8 t: 442051/443420/1369
94 -> p:1 a: 0 l: 1349/8 t: 443747/445098/1351

---------------------------
Stats: [min: 4us @ row 88] [max: 1349us @ row 94] {ave: 27us]
---------------------------
Error: row 79: 15 != (19 >= x > 15)
Error: row 80: 16 != (15 >= x > 11)
Error: row 83: 11 != (15 >= x > 11)
Error: row 84: 12 != (11 >= x > 7)
Error: row 87: 7 != (11 >= x > 7)
Error: row 88: 8 != (7 >= x > 3)
Error: row 91: 3 != (7 >= x > 3)
Error: row 92: 4 != (3 >= x > 0)
---------------------------
Test FAILED with 8 errors

---------------------------

This output shows, for instance, that row 79 has a priority 15 thread
that finished when only 19,18,17, or 16 should have if the system was
prioritizing properly.

Comments/suggestions welcome!

Regards,
-Greg
