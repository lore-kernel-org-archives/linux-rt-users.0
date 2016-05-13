From: John Kacur <jkacur@redhat.com>
Subject: [ANNOUNCE] rt-tests version 1.0
Date: Fri, 13 May 2016 22:55:53 +0200
Message-ID: <1463172953-12998-1-git-send-email-jkacur@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Clark Williams <williams@redhat.com>,
	lkml <linux-kernel@vger.kernel.org>,
	John Kacur <jkacur@redhat.com>
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Okay, I think it's finally time to release version 1.0 of rt-tests.

There aren't too many interesting changes this round, just a bunch of house keeping things, like adding missing man-pages, and updating old ones.

Two interesting changes though are:

 - We now compile with HAVE_PARSE_CPUSTRING_ALL=1 by default which assumes that
numa_parse_cpustring_all() is available. This gives us the ability to include isolated cpus in the affinity string.

 - When using the new option --tracemark --notrace, so that cyclictest leaves the actually tracing to external programs (primariliy trace-cmd is intended), we have to immediately turn off tracing when we hit a breaktrace threshold, or we won't have the relevant information left in the buffer.

Now that we've released rt-tests-1.0 the API should be considered closed. We will still maintain it of course to fix any problems. There are two exceptions to changing the API - there is still some discussion about how to handle affinity since there are legitimate reasons to run cyclictest on isolated cpus not in the affinity mask. There will probably some changes there in the future.

Also, If Carsten Emde requests any changes, he's probably the one person we would accept them from. He does very exstensive testing, and if he requires changes to make the latest version more compatible with some older versions, that would also be okay.

I am starting a new-development line, or unstable version, where we will be free to make more exstensive changes. For now you will want to run with the stable version for testing, and use the new development line if you want to get creative with rt-tests.

The unstable or development line is called v2.0

If you want to make some radical changes there though, it's probably a good idea to discuss that with the list before you spend too much time on them. Of course you can always maintain something on the side until you overwhelm us with the worth of your new ideas!

Happy Hacking,

Cheers!

John Kacur

To fetch the latest version

Clone one of the following if needed.

git://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
https://kernel.googlesource.com/pub/scm/utils/rt-tests/rt-tests.git

Stable Version
tag: v1.0
branch: stable/v1.0

Development Version
tag v2.0
branch: devel/v2.0

You can also fetch tarballs here

https://www.kernel.org/pub/linux/utils/rt-tests/rt-tests-1.0.tar.gz
https://www.kernel.org/pub/linux/utils/rt-tests/rt-tests-1.0.tar.xz

And older versions here

https://www.kernel.org/pub/linux/utils/rt-tests/older/

Changes

Clark Williams (1):
  cyclictest: stop any tracing after hitting a breaktrace threshold

John Kacur (8):
  rt-tests: Makefile: Assume numa_parse_cpustring_all available
  rt-tests: Add man page for rt-migrate-test
  rt-tests: Update the cyclictest man page
  rt-tests: Add missing option to hwlatdetect man page
  rt-tests: Housekeeping fix some spelling errors.
  rt-tests: hwlat.txt: smidetect renamed to hwlatdetect
  rt-tests: Remove doc/release-checklist.txt
  rt-tests: Makefile - bump version to 1.0

 Makefile                              |  15 +--
 doc/release-checklist.txt             |   9 --
 src/backfire/sendme.8                 |   2 +-
 src/cyclictest/cyclictest.8           | 173 ++++++++++++++++++----------------
 src/cyclictest/cyclictest.c           |  67 ++++++++-----
 src/hwlatdetect/hwlat.txt             |  17 ++--
 src/hwlatdetect/hwlatdetect.8         |  12 ++-
 src/pi_tests/pi_stress.8              |   2 +-
 src/pmqtest/pmqtest.8                 |   4 +-
 src/ptsematest/ptsematest.8           |   6 +-
 src/rt-migrate-test/rt-migrate-test.8 |  56 +++++++++++
 src/signaltest/signaltest.8           |   2 +-
 src/sigwaittest/sigwaittest.8         |   8 +-
 src/svsematest/svsematest.8           |   6 +-
 14 files changed, 234 insertions(+), 145 deletions(-)
 delete mode 100644 doc/release-checklist.txt
 create mode 100644 src/rt-migrate-test/rt-migrate-test.8

-- 
2.4.11
