From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 00/35] perf/core improvements and fixes
Date: Thu, 28 Dec 2017 16:17:41 +0100
Message-ID: <20171228151741.dn4tlwi43ogrlr4t@gmail.com>
References: <20171228143027.30547-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        bhargavb <bhargavaramudu@gmail.com>,
        Cheng Jian <cj.chengjian@huawei.com>,
        David Ahern <dsahern@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Jonathan Hermann <jonathan.hermann@de.ibm.com>,
        Kan Liang <kan.liang@intel.com>,
        Kim Phillips <kim.phillips@arm.com>,
        Li Bin <huawei.libin@huawei.com>,
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171228143027.30547-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling,
> 
> - Arnaldo
> 
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit faaf95677f33dac910b6cbe917cabea43c8c1616:
> 
>   Merge branch 'perf/urgent' into perf/core, to pick up fixes (2017-12-18 18:13:00 +0100)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.16-20171227
> 
> for you to fetch changes up to 5d4fd9c8b83b36d34521b3af361a5726899045bf:
> 
>   perf tools: Auto-complete for events with ':' (2017-12-27 12:16:00 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> - Allow system wide 'perf stat --per-thread', sorting the result (Jin Yao)
> 
>   E.g.:
> 
>   [root@jouet ~]# perf stat --per-thread --metrics IPC
>   ^C
>    Performance counter stats for 'system wide':
> 
>               make-22229  23,012,094,032  inst_retired.any   #  0.8 IPC
>                cc1-22419     692,027,497  inst_retired.any   #  0.8 IPC
>                gcc-22418     328,231,855  inst_retired.any   #  0.9 IPC
>                cc1-22509     220,853,647  inst_retired.any   #  0.8 IPC
>                gcc-22486     199,874,810  inst_retired.any   #  1.0 IPC
>                 as-22466     177,896,365  inst_retired.any   #  0.9 IPC
>                cc1-22465     150,732,374  inst_retired.any   #  0.8 IPC
>                gcc-22508     112,555,593  inst_retired.any   #  0.9 IPC
>                cc1-22487     108,964,079  inst_retired.any   #  0.7 IPC
>    qemu-system-x86-2697       21,330,550  inst_retired.any   #  0.3 IPC
>    systemd-journal-551        20,642,951  inst_retired.any   #  0.4 IPC
>    docker-containe-17651       9,552,892  inst_retired.any   #  0.5 IPC
>    dockerd-current-9809        7,528,586  inst_retired.any   #  0.5 IPC
>               make-22153  12,504,194,380  inst_retired.any   #  0.8 IPC
>            python2-22429  12,081,290,954  inst_retired.any   #  0.8 IPC
>   <SNIP>
>            python2-22429  15,026,328,103  cpu_clk_unhalted.thread
>                cc1-22419     826,660,193  cpu_clk_unhalted.thread
>                gcc-22418     365,321,295  cpu_clk_unhalted.thread
>                cc1-22509     279,169,362  cpu_clk_unhalted.thread
>                gcc-22486     210,156,950  cpu_clk_unhalted.thread
>   <SNIP>
> 
>        5.638075538 seconds time elapsed
> 
>   [root@jouet ~]#
> 
> - Improve shell auto-completion of perf events (Jin Yao)
> 
> -  Fix symbol fixup issues in arm64 due to ELF type (Kim Phillips)
> 
> - Ignore threads when they vanish after procfs based enumeration and
>   before we try to use them with sys_perf_event_open(), i.e. just remove
>   them from the thread_map and continue with the rest. This makes, among
>   other cases, the previous new feature (perf stat --per-thread for system
>   wide, albeit that not seeming to be the motivation for this patch) more
>   robust. (Mengting Zhang)
> 
> - Generate s390 syscall table from asm/unistd.h, doing like x86,
>   removing the dependency on audit-libs to do this id->string translation,
>   speeding up the support for newly introducted syscalls (Hendrik Brueckner)
> 
> - Fix 'perf test' on filesystems where readdir() returns d_type == DT_UNKNOWN,
>   such as XFS (Jiri Olsa)
> 
> - Fix PERF_SAMPLE_RAW_DATA endianity handling for cross-arch tracepoint
>   processing (Jiri Olsa)
> 
> - Add __return suffix for return events in 'perf probe', streamlining
>   entry/exit tracing (Masami Hiramatsu)
> 
> - Improve support for versioned symbols in 'perf probe" (Masami Hiramatsu)
> 
> - Clarify error message about invalid 'perf probe' event names (Masami Hiramatsu)
> 
> - Fix check open filename arg using 'perf trace' in a 'perf test' entry for
>   systems using glibc >= 2.26, such as some ARM and s390 distros (Michael Petlan)
> 
> - Make method for obtaining the (normalized) architecture id for a
>   perf.data file or for the running system used by the annotation routines
>   generally available, next user will be for generating per arch errno
>   string tables to allow for pretty printing errno codes recorded in a
>   perf.data file in architecture A to be properly decoded on hardware
>   archictecture B.  (Arnaldo Carvalho de Melo)
> 
> - Remove duplicate includes, found using scripts/checkincludes.pl (Pravin Shedge)
> 
> - s390 needs -fPIC, enable it, also revert a patch that supposedly did
>   that but instead enabled -fPIC for x86 (Hendrik Brueckner, Arnaldo Carvalho de Melo)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (4):
>       perf annotate: Get the cpuid from evsel->evlist->env in symbol__annotate()
>       perf annotate: Use perf_env when obtaining the arch name
>       perf env: Adopt perf_env__arch() from the annotate code
>       Revert "perf s390: Always build with -fPIC"
> 
> Hendrik Brueckner (4):
>       tools include s390: Grab a copy of arch/s390/include/uapi/asm/unistd.h
>       perf s390: Generate system call table from asm/unistd.h
>       perf trace: Use generated syscall table on s390 too
>       perf s390: Always build with -fPIC
> 
> Jin Yao (14):
>       perf stat: Define a structure for per-thread shadow stats
>       perf stat: Extend rbtree to support per-thread shadow stats
>       perf stat: Create the runtime_stat init/exit function
>       perf stat: Update per-thread shadow stats
>       perf stat: Print per-thread shadow stats
>       perf stat: Remove a set of shadow stats static variables
>       perf stat: Allocate shadow stats buffer for threads
>       perf stat: Update or print per-thread stats
>       perf thread_map: Enumerate all threads from /proc
>       perf stat: Remove --per-thread pid/tid limitation
>       perf stat: Resort '--per-thread' result
>       perf tool: Improve bash command line auto-complete for multiple events with comma
>       perf tools: Return all events as auto-completions after comma
>       perf tools: Auto-complete for events with ':'
> 
> Jiri Olsa (3):
>       perf utils: Move is_directory() to path.h
>       perf test: Handle properly readdir DT_UNKNOWN
>       perf evsel: Fix swap for samples with raw data
> 
> Kim Phillips (1):
>       perf probe arm64: Fix symbol fixup issues due to ELF type
> 
> Masami Hiramatsu (6):
>       perf probe: Add warning message if there is unexpected event name
>       perf probe: Cut off the version suffix from event name
>       perf probe: Add __return suffix for return events
>       perf probe: Find versioned symbols from map
>       perf string: Add {strdup,strpbrk}_esc()
>       perf probe: Support escaped character in parser
> 
> Mengting Zhang (1):
>       perf evsel: Enable ignore_missing_thread for pid option
> 
> Michael Petlan (1):
>       perf test shell: Fix check open filename arg using 'perf trace'
> 
> Pravin Shedge (1):
>       perf perf: Remove duplicate includes
> 
>  tools/arch/s390/include/uapi/asm/unistd.h          | 412 ++++++++++++++++++++
>  tools/perf/Documentation/perf-probe.txt            |  18 +-
>  tools/perf/Makefile.config                         |  11 +-
>  tools/perf/arch/arm64/util/Build                   |   1 +
>  tools/perf/arch/arm64/util/sym-handling.c          |  22 ++
>  tools/perf/arch/common.c                           |  44 +--
>  tools/perf/arch/common.h                           |   1 -
>  tools/perf/arch/powerpc/util/sym-handling.c        |   8 +
>  tools/perf/arch/s390/Makefile                      |  21 ++
>  tools/perf/arch/s390/entry/syscalls/mksyscalltbl   |  36 ++
>  tools/perf/bench/futex-hash.c                      |   1 -
>  tools/perf/builtin-c2c.c                           |   3 -
>  tools/perf/builtin-record.c                        |   5 +-
>  tools/perf/builtin-script.c                        |  20 +-
>  tools/perf/builtin-stat.c                          | 168 +++++++--
>  tools/perf/builtin-top.c                           |   2 +-
>  tools/perf/check-headers.sh                        |   1 +
>  tools/perf/perf-completion.sh                      |  47 ++-
>  tools/perf/tests/builtin-test.c                    |  10 +-
>  tools/perf/tests/parse-events.c                    |   1 -
>  tools/perf/tests/shell/trace+probe_vfs_getname.sh  |   7 +-
>  tools/perf/tests/thread-map.c                      |   2 +-
>  tools/perf/ui/browsers/annotate.c                  |   4 +-
>  tools/perf/ui/gtk/annotate.c                       |   2 +-
>  tools/perf/util/annotate.c                         |  26 +-
>  tools/perf/util/annotate.h                         |   2 +-
>  tools/perf/util/auxtrace.c                         |   3 -
>  tools/perf/util/env.c                              |  47 +++
>  tools/perf/util/env.h                              |   2 +
>  tools/perf/util/evlist.c                           |   3 +-
>  tools/perf/util/evsel.c                            |  80 +++-
>  tools/perf/util/evsel.h                            |   3 +-
>  tools/perf/util/header.c                           |   2 -
>  tools/perf/util/metricgroup.c                      |   2 -
>  tools/perf/util/path.c                             |  14 +
>  tools/perf/util/path.h                             |   3 +
>  tools/perf/util/probe-event.c                      |  85 +++--
>  tools/perf/util/python-ext-sources                 |   1 +
>  .../util/scripting-engines/trace-event-python.c    |   1 -
>  tools/perf/util/stat-shadow.c                      | 416 ++++++++++++---------
>  tools/perf/util/stat.c                             |  15 +-
>  tools/perf/util/stat.h                             |  63 +++-
>  tools/perf/util/string.c                           |  46 +++
>  tools/perf/util/string2.h                          |   2 +
>  tools/perf/util/symbol.c                           |   5 +
>  tools/perf/util/symbol.h                           |   1 +
>  tools/perf/util/syscalltbl.c                       |   4 +
>  tools/perf/util/target.h                           |   7 +
>  tools/perf/util/thread_map.c                       |   5 +-
>  tools/perf/util/thread_map.h                       |   2 +-
>  tools/perf/util/unwind-libunwind.c                 |   4 +-
>  51 files changed, 1328 insertions(+), 363 deletions(-)
>  create mode 100644 tools/arch/s390/include/uapi/asm/unistd.h
>  create mode 100644 tools/perf/arch/arm64/util/sym-handling.c
>  create mode 100755 tools/perf/arch/s390/entry/syscalls/mksyscalltbl

Pulled, thanks a lot Arnaldo!

	Ingo
