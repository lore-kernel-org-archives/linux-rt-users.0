From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC][PATCH 0/3] update to cpupri algorithm
Date: Fri, 29 Jul 2011 11:13:40 -0400
Message-ID: <20110729151340.419467771@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	RT <linux-rt-users@vger.kernel.org>
To: Mike Galbraith <mgalbraith@suse.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.125]:53181 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785Ab1G2PT4 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 29 Jul 2011 11:19:56 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Mike,

Could you try this patch set out. Add the first patch and then
run your tests. The first patch only adds benchmarking, and does not
modify the scheduler algorithm.

Do this:

1. apply first patch, build and boot
2. # mount -t debugfs nodev /sys/kernel/debug
3. # echo 0 > /sys/kernel/debug/cpupri; ./runtest; cat /sys/kernel/debug/cpupri > output

The output will give you the contention of the vector locks in the
cpupri algorithm.

Then apply the second patch and do the same thing.

Then apply the third patch and do the same thing.

After that, could you send me the results of the output file for all
three runs?  The final patch should probably be the best overall
results.

Thanks!

-- Steve

