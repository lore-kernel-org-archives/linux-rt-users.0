From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [RFC v0 0/9] [RFC v0 0/9] pi_stress: Add SCHED_DEADLINE support
Date: Wed,  5 Nov 2014 10:09:36 +0100
Message-ID: <1415178585-3192-1-git-send-email-daniel.wagner@bmw-carit.de>
Cc: linux-rt-users@vger.kernel.org,
	Daniel Wagner <daniel.wagner@bmw-carit.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dario Faggioli <raistlin@linux.it>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.bmw-carit.de ([62.245.222.98]:52805 "EHLO
	linuxmail.bmw-carit.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751732AbaKEJJt (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 Nov 2014 04:09:49 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I wrote a small test program to play around with SCHED_DEADLINE which
triggered various PI related crashes. Steven convinced me to get
the test somehow upstream. I figured pi_stress is very simular with my
test program. So here my attempt to merge the essence of my test
into pi_stress.c


  patch 1: hackbench: Don't re-assign context for each fd
  patch 2: rt-tests.h: Remove unused header file
  patch 3: pi_stress: Remove unused TIMER_SIGNAL definition

	Not really related to this series. Just found it while
	browsing the code a bit. Are you interested in such
	patches?

  patch 4: error: Add debug() function
  patch 5: pi_stress: Use error.h for logging and debugging

	I didn't want to add the sched_setattr() code directly
	to pi_stress.c. As soon rt-utils.h is used you get also
	error.h which brings info() and friends it collides
	in pi_stress.c.
	Several other tests also implement info() and friends.
	Would it make sense to convert them using error.h too?
	Then I would also suggest to get --verbose and
	--debug options handled in a central way. Maybe something
	like the GLib does with parsing the argc first and hanlding
	those flags. What do you think?

  patch 6: rt-sched: Add sched_setattr/sched_getattr API
  patch 7: rt-utils: Add helper to parse/print scheduling policies
  patch 8: rt-utils: Add gettid()

	Add to the library some of the code which could be reused
	by other tests as well. Nothing really fancy.

  patch 9: pi_stress: Store schedule attributes per thread

	Finally this adds the a command line arguments which
	allows the user to define which scheduler setting is
	used for each thread catagory:

# ./pi_stress --sched id=high,policy=deadline,runtime=100000,deadline=200000,period=200000
Starting PI Stress Test
Number of thread groups: 1
Duration of test run: infinite
Number of inversions per group: unlimited
     Admin thread SCHED_FIFO priority 4
1 groups of 3 threads will be created
      High thread SCHED_DEADLINE runtime 100000 deadline 200000 period 200000
       Med thread SCHED_FIFO priority 2
       Low thread SCHED_FIFO priority 1
Current Inversions: 2446249
Stopping test
Terminated


WARNING: Do no run this on older kernels (<3.18-rc3) it will crash your
system. You have been warned!


Obviously, you can also do some stupid stuff like:

# ./pi_stress --rr --sched id=high,policy=deadline,h=dl,runtime=100000,deadline=200000,period=200000 --sched id=low,policy=fifo,priority=3
Starting PI Stress Test
Number of thread groups: 1
Duration of test run: infinite
Number of inversions per group: unlimited
     Admin thread SCHED_RR priority 4
1 groups of 3 threads will be created
      High thread SCHED_DEADLINE runtime 100000 deadline 200000 period 200000
       Med thread SCHED_RR priority 2
       Low thread SCHED_FIFO priority 3
Current Inversions: 352306
Stopping test
Terminated

cheers,
daniel

Cc: Clark Williams <williams@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Dario Faggioli <raistlin@linux.it>
Cc: <linux-rt-users@vger.kernel.org>

Daniel Wagner (9):
  hackbench: Don't re-assign context for each fd
  rt-tests.h: Remove unused header file
  pi_stress: Remove unused TIMER_SIGNAL definition
  error: Add debug() function
  pi_stress: Use error.h for logging and debugging
  rt-sched: Add sched_setattr/sched_getattr API
  rt-utils: Add helper to parse/print scheduling policies
  rt-utils: Add gettid()
  pi_stress: Store schedule attributes per thread

 Makefile                  |   4 +-
 src/hackbench/hackbench.c |   8 +-
 src/include/error.h       |   1 +
 src/include/rt-sched.h    |  76 +++++++
 src/include/rt-tests.h    | 124 ------------
 src/include/rt-utils.h    |   7 +
 src/lib/error.c           |  10 +
 src/lib/rt-sched.c        |  43 ++++
 src/lib/rt-utils.c        |  44 ++++
 src/pi_tests/pi_stress.c  | 500 ++++++++++++++++++++++++++++++----------------
 10 files changed, 512 insertions(+), 305 deletions(-)
 create mode 100644 src/include/rt-sched.h
 delete mode 100644 src/include/rt-tests.h
 create mode 100644 src/lib/rt-sched.c

-- 
1.9.3

