From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [GIT PULL 00/11] perf/core improvements and fixes
Date: Tue, 23 Feb 2016 17:00:41 -0300
Message-ID: <1456257652-20059-1-git-send-email-acme@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
	Juri Lelli <juri.lelli@gmail.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Stephane Eranian <eranian@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wang Nan <wangnan0@huawei.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
To: Ingo Molnar <mingo@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Ingo,

	Please consider pulling, this is on top of the perf-core-for-mingo
submitted recently,

- Arnaldo

The following changes since commit 03e0a7df3efd959e40cd7ff40b1fabddc234ec5a:

  perf tools: Introduce bpf-output event (2016-02-22 14:37:21 -0300)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-2

for you to fetch changes up to bea2400621836b028d82c3d6a74053921d70dbd7:

  perf tools: Remove strbuf_{remove,splice}() (2016-02-23 16:21:04 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

User visible:

- Don't stop PMU parsing on alias parse error, allowing the
  addition of new sysfs PMU files without breaking old tools (Andi Kleen)

- Implement '%' operation in libtraceevent (Daniel Bristot de Oliveira)

- Allow specifying events via -e in 'perf mem record', also listing what events
  can be specified via 'perf mem record -e list' (Jiri Olsa)

- Improve support to 'data_src', 'weight' and 'addr' fields in
  'perf script' (Jiri Olsa)

Infrastructure:

- Export cacheline routines (Jiri Olsa)

- Remove strbuf_{remove,splice}(), dead code (Arnaldo Carvalho de Melo)

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Andi Kleen (1):
      perf tools: Dont stop PMU parsing on alias parse error

Arnaldo Carvalho de Melo (2):
      perf help: No need to use strbuf_remove()
      perf tools: Remove strbuf_{remove,splice}()

Daniel Bristot de Oliveira (1):
      tools lib traceevent: Implement '%' operation

Jiri Olsa (7):
      perf tools: Make cl_address global
      perf tools: Introduce cl_offset function
      perf tools: Add monitored events array
      perf mem: Add -e record option
      perf tools: Use ARRAY_SIZE in mem sort display functions
      perf script: Add data_src and weight column definitions
      perf script: Display addr/data_src/weight columns for raw events

 tools/lib/traceevent/event-parse.c |  4 +++
 tools/perf/builtin-help.c          |  3 +-
 tools/perf/builtin-mem.c           | 74 +++++++++++++++++++++++++++++++++-----
 tools/perf/builtin-script.c        | 23 +++++++++++-
 tools/perf/util/Build              |  1 +
 tools/perf/util/mem-events.c       | 51 ++++++++++++++++++++++++++
 tools/perf/util/mem-events.h       | 22 ++++++++++++
 tools/perf/util/pmu.c              | 15 ++++----
 tools/perf/util/sort.c             | 15 ++------
 tools/perf/util/sort.h             | 11 ++++++
 tools/perf/util/strbuf.c           | 24 -------------
 tools/perf/util/strbuf.h           |  2 --
 12 files changed, 188 insertions(+), 57 deletions(-)
 create mode 100644 tools/perf/util/mem-events.c
 create mode 100644 tools/perf/util/mem-events.h
