From: John Kacur <jkacur@redhat.com>
Subject: [ANNOUNCE]rt-tests-0.94
Date: Mon, 21 Sep 2015 23:51:12 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1509212338060.12009@riemann>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>,
	Henrik Austad <haustad@cisco.com>,
	Josh Cartwright <joshc@ni.com>,
	Gratian Crisan <gratian.crisan@ni.com>,
	Darren Hart <dvhart@linux.intel.com>
To: linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


We're pleased to announce a new release of rt-tests

You can fetch it via git by cloning one of the following repos

git://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
https://kernel.googlesource.com/pub/scm/utils/rt-tests/rt-tests.git

tag: v0.94

You can also fetch the tarball here
https://www.kernel.org/pub/linux/utils/rt-tests/rt-tests-0.94.tar.xz
https://www.kernel.org/pub/linux/utils/rt-tests/rt-tests-0.94.tar.gz

Enjoy!

Clark Williams (2):
  hwlatdetect: initial cut at tracking the amount of SMIs that occurred
    during a run
  rt-migrate-test: updated to latest code from rostedt

Darren Hart (2):
  rt-tests: Allow for user-specified PYLIB
  rt-tests: Break out install_hwlatdetect

Henrik Austad (5):
  Add CROSS_COMPILE-switch to CC and AR
  Add syscall-number for sched_(gs)etattr() for tile
  Add a rebuild-switch to Makefile
  Makefile: add librttest to rt-migrate-test
  android: adjust target for android

John Kacur (3):
  Fix VERSION in rt-migrate-test
  numa_on_and_available: Remove from main in cyclictest
  Version bump to v0.94

Josh Cartwright (8):
  rt-tests: workaround poor gzip implementations
  hackbench: cleanup error handling in create_worker
  cyclictest: consistently make all functions 'static'
  cyclictest: use correct type when allocating cpu bitmask size
  cyclictest: drop impossible use_fifo conditional
  cyclictest: fail if use_fifo && thread creation failed
  error: mark fatal, err_exit, err_quit as being noreturn
  cyclictest: add option for dumping the histogram in a file

 Makefile                              |  72 +++++++++++----
 src/cyclictest/cyclictest.c           | 162 
++++++++++++++++++++++------------
 src/cyclictest/rt_numa.h              |  20 +++--
 src/hackbench/hackbench.c             |  36 ++++----
 src/hwlatdetect/hwlatdetect.py        |  25 ++++++
 src/include/error.h                   |   6 +-
 src/include/rt-sched.h                |   5 ++
 src/rt-migrate-test/rt-migrate-test.c |  47 +++++-----
 8 files changed, 247 insertions(+), 126 deletions(-)
