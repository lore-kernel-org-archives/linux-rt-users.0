From: Tommi Rantala <tommi.t.rantala@nokia.com>
Subject: [PATCH 00/34] rt-tests fixes and cleanups
Date: Mon, 22 May 2017 11:25:06 +0300
Message-ID: <20170522082540.15467-1-tommi.t.rantala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-rt-users@vger.kernel.org>,
        Tommi Rantala <tommi.t.rantala@nokia.com>
To: Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-eopbgr50097.outbound.protection.outlook.com ([40.107.5.97]:7993
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752557AbdEVIZ4 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 May 2017 04:25:56 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi, various fixes and cleanups to rt-tests, developed on top of the
"unstable/devel/v1.1.1" branch.

Also available here on the devel-11 branch:
https://github.com/rantala/rt-tests

Tommi Rantala (34):
  rt-utils: add cpus_online() helper
  cyclictest: use cpus_online() helper
  cyclictest: always clear stop to avoid -Wmaybe-uninitialized warning
  cyclictest: remove extra argument in warn() and fatal() calls
  cyclictest: fix signed vs unsigned compiler warnings
  cyclictest: fix typo in warn() message
  cyclictest: update --smp help: -n was removed
  cyclictest: adjust whitespace in display_help() output
  cyclictest: use %p for printing void*, and print stack size separately
  cyclictest: use %zd for printing size_t in rt_numa_numa_alloc_onnode()
  cyclictest: max_cpus unused in this variant of
    rt_numa_parse_cpustring()
  cyclictest: fix off-by-one in clocksel check
  cyclictest: check timer_getoverrun() return value for failure
  cyclictest: fix MODE_CYCLIC measurement failure after timer overruns
  cyclictest: param is unused in fifothread()
  cyclictest: normalize next before tsgreater() check
  cyclictest: tsnorm() after adjusting next
  pip_stress: fix missing argument in err_msg() call in
    process_shared_mutex_available()
  pip_stress: getopt.h and long_options[] are unused
  pi_stress: use cpus_online() helper
  pi_stress: use %lu for unsigned long
  pi_stress: add missing argument in pi_error() call
  svsematest: test .mindiff against UINT_MAX
  signaltest: remove unused ARRAY_SIZE macro
  deadline_test: fix stack corruption in setup_ftrace_marker()
  deadline_test: remove unused tid parameter in do_runtime()
  deadline_test: tv_nsec is long
  deadline_test: use %llu for printing unsigned long longs
  cyclicdeadline: fix stack corruption in setup_ftrace_marker()
  cyclicdeadline: remove unused tid parameter from do_runtime()
  cyclicdeadline: avoid signed vs unsigned compiler warnings
  printf format attributes and format string constness in error helpers
  mark unused sighand() parameters with unused attribute
  read-only struct option array constness

 src/backfire/sendme.c                 |  2 +-
 src/cyclictest/cyclictest.c           | 56 ++++++++++++++++++---------------
 src/cyclictest/rt_numa.h              |  4 +--
 src/hackbench/hackbench.c             |  2 +-
 src/include/error.h                   | 16 +++++-----
 src/include/rt-utils.h                |  1 +
 src/lib/error.c                       | 16 +++++-----
 src/lib/rt-utils.c                    | 12 +++++++
 src/pi_tests/classic_pi.c             |  2 +-
 src/pi_tests/pi_stress.c              | 12 +++----
 src/pi_tests/pip_stress.c             |  8 +----
 src/pmqtest/pmqtest.c                 |  4 +--
 src/ptsematest/ptsematest.c           |  4 +--
 src/rt-migrate-test/rt-migrate-test.c |  2 +-
 src/sched_deadline/cyclicdeadline.c   | 14 ++++-----
 src/sched_deadline/deadline_test.c    | 59 +++++++++++++++++------------------
 src/signaltest/signaltest.c           |  6 ++--
 src/sigwaittest/sigwaittest.c         |  4 +--
 src/svsematest/svsematest.c           |  6 ++--
 19 files changed, 120 insertions(+), 110 deletions(-)

-- 
2.9.3

