From: Darren Hart <dvhltc@us.ibm.com>
Subject: IBM rt-tests-0.6 snapshot
Date: Fri, 9 Nov 2007 21:03:44 -0800
Message-ID: <200711092103.44547.dvhltc@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:59002 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092AbXKJFDq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 10 Nov 2007 00:03:46 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lAA53j7u007631
	for <linux-rt-users@vger.kernel.org>; Sat, 10 Nov 2007 00:03:45 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id lAA53ieF123288
	for <linux-rt-users@vger.kernel.org>; Fri, 9 Nov 2007 22:03:44 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id lAA53iu5006711
	for <linux-rt-users@vger.kernel.org>; Fri, 9 Nov 2007 22:03:44 -0700
Received: from wecm-9-67-82-85.wecm.ibm.com (wecm-9-67-82-85.wecm.ibm.com [9.67.82.85])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id lAA53iJf006675
	for <linux-rt-users@vger.kernel.org>; Fri, 9 Nov 2007 22:03:44 -0700
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

IBM rt-tests-0.6 snapshot is now available here:

http://www.kernel.org/pub/linux/kernel/people/dvhart/realtime/tests/

As more folks have started using the rt-test suite, I thought I should get 
another snaphot out, even though there is still a fairly long list of things 
we would like to improve.  Please give it a shot and let us know if you run 
into any trouble with it.  A very high level summary of changes since the 0.3 
snapshot follows.

o Fixed run.sh scripts requiring top level dir name of "rt-test"
  - you can now run things like "$ ./run.sh all" from the top level directory
o Lots of coding style and cosmetic updates for:
  - whitespace
  - header text (descriptions, licenses, etc.)
  - more consistently formatted test output (still work to do)
  - more consistent return codes (still some work to do)
  - various compiler warnings
o Several bug fixes and added arguments to various tests:
  - sched_latency
  - sched_football
  - pthread_kill_latency
  - prio-preempt
o New test cases:
  - hrtimer-prio
o Autotools updates from Robert Schwebel <r.schwebel@pengutronix.de>
o PowerPC asm support for atomics and tsc workaround from 
  Tsutomu Owa <tsutomu.owa@toshiba.co.jp>

Thanks to everyone who contributed and tested, your time is very much 
appreciated.

-- 
Darren Hart
IBM Linux Technology Center
Realtime Linux Team
