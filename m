From: John Kacur <jkacur@redhat.com>
Subject: [ANNOUNCE] rt-tests-v0.97
Date: Thu, 31 Mar 2016 21:24:06 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1603312115400.25679@riemann>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Clark Williams <williams@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Dear RT Folks

We are pleased to announce the latest version of rt-tests

We have a number of interesting enhancements.

Firstly Clark has formally removed the requirement to compile hwlatdetect as a module.

Daniel Bristot de Oliveira has added a hardware SMI count detection using 
the MSR/SMI counter if available. Using the --smi option adds the count to 
the end of the output, it looks like this (per thread)

 T: 0 ( 2285) P:80 I:1000 C:   9975 Min:      2 Act:    3 Avg:    4 Max:   20831 SMI:       2

Finally Luis Capitulino has added an option to bypass cyclictest's built-in tracing so that this functionality can be handed off to another program - in particular trace-cmd. cyclictest continues to write to the /sys/kernel/debug/tracing/trace_maker file, but trace-cmd handles the tracing.

trace-cmd record [...] cyclictest [...] -bX --tracemark

We are nearing a 1.0 version of rt-tests.
I'd like to have a round of bugfix/clean-up  patches, and patches to add anything 
missing and then create a 1.0 version of rt-tests that we will continue to maintain,
 but that won't accept any new enhancements. We will also spin-off a development version (v2.x?) that will allow api changes.

In the development version we are planning on ripping out the built-in tracing support for tighter integration with trace-cmd.
The options in cyclictest have also become quite crufty and complicated and 
need to be radically reworked / simplified. The tests could also share code much better than they currently do.

To fetch the latest version

Clone one of the following if needed.

git://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
https://kernel.googlesource.com/pub/scm/utils/rt-tests/rt-tests.git

tag: v0.97

You can also fetch the tarball here
https://www.kernel.org/pub/linux/utils/rt-tests/rt-tests-0.97.tar.xz
https://www.kernel.org/pub/linux/utils/rt-tests/rt-tests-0.97.tar.gz

older versions are in
https://www.kernel.org/pub/linux/utils/rt-tests/rt-tests/older

I have created a new devel branch which will beome 1.0 (unless we need a v0.99)

devel/v0.98

I'll create the development line for 2.0 once we freeze 1.0

Thanks for all your hardwork

Cheers!

John Kacur

Clark Williams (4):
  Makefile: fixed dropped quote in help target text
  hwlatdetect: handle hwlat_detector being builtin rather than module
  hwlatdetect: modify to handle python3 prints
  hwlatdetect: make reading sample date work with python2 and python3

Daniel Bristot de Oliveira (2):
  cyclictest: SMI count/detection via MSR/SMI counter
  cyclictest: Add --smi description on cyclictest man page

John Kacur (6):
  Remove rt-tests.spec-in
  gitattributes: add doc, remove rt.spec-in
  Makefile: Remove anything to do with rpms, specs etc
  Revert changes to rt-migrate-test for exit(1)
  cyclictest: Make the tracemark option imply notrace
  rt-tests: Makefile: Bump version number to 0.97

Khem Raj (1):
  Makefile: Set CC/AR variable only if it doesn't have a value

Luiz Capitulino (5):
  don't use exit(-1) for failures
  cyclictest: move tracemark_fd handling to its own function
  cyclictest: tracing(): check for notrace
  cyclictest: move debugfs init code to its own function
  cyclictest: add --tracemark option

 .gitattributes                 |   2 +-
 Makefile                       |  62 +----
 rt-tests.spec-in               | 524 -----------------------------------------
 src/cyclictest/cyclictest.8    |   4 +
 src/cyclictest/cyclictest.c    | 287 ++++++++++++++++++++--
 src/hwlatdetect/hwlatdetect.py |  42 +++-
 src/pi_tests/pi_stress.c       |   2 +-
 src/pi_tests/pip_stress.c      |   6 +-
 src/signaltest/signaltest.c    |   2 +-
 9 files changed, 316 insertions(+), 615 deletions(-)
 delete mode 100644 rt-tests.spec-in

-- 
2.4.3
