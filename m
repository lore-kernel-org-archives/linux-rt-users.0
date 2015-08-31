From: Josh Cartwright <joshc@ni.com>
Subject: [PATCH rt-tests 0/9] more rt-tests cleanups and a cyclictest feature
Date: Mon, 31 Aug 2015 11:35:27 -0500
Message-ID: <cover.1441038216.git.joshc@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: linux-rt-users@vger.kernel.org
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:44387 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753322AbbHaQfj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 31 Aug 2015 12:35:39 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hey Clark, John-

Here's another set, this one contains eight patches are very minor cleanups
(found mostly via code inspection and by building with warnings cranked up).

The last patch introduces an option to cyclictest to control the dumping of
histogram data into a separate file, it's useful for when you want to see the
'normal' cyclictest live-updating, but also want to store away the generated
histogram for later analysis.

(My goal was to present a net-negative diffstat...I came so close!)

Thanks!
  Josh

Gratian Crisan (1):
  cyclictest: Add option for dumping the histogram in a file

Josh Cartwright (8):
  cyclictest: consistently make all functions 'static'
  cyclictest: fixup documentation for --priority option
  cyclictest: drop unnecessary numa_on_and_available() check
  signaltest: drop unused tsnorm()
  cyclictest: use correct type when allocating cpu bitmask size
  cyclictest: drop impossible use_fifo conditional
  cyclictest: fail if use_fifo && thread creation failed
  error: mark fatal, err_exit, err_quit as being noreturn

 src/cyclictest/cyclictest.c | 120 ++++++++++++++++++++++++++------------------
 src/cyclictest/rt_numa.h    |  11 +---
 src/include/error.h         |   6 +--
 src/signaltest/signaltest.c |   8 ---
 4 files changed, 74 insertions(+), 71 deletions(-)

-- 
2.5.0

