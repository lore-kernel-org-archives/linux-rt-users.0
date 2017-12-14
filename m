From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [GIT PULL 00/34] perf/core improvements and fixes
Date: Thu, 14 Dec 2017 14:42:13 -0300
Message-ID: <20171214174247.16841-1-acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        bhargavb <bhargavaramudu@gmail.com>,
        Cheng Jian <cj.chengjian@huawei.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        David Ahern <dsahern@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Jonathan Hermann <jonathan.hermann@de.ibm.com>,
        Kan Liang <kan.liang@intel.com>,
        Li Bin <huawei.libin@huawei.com>,
To: Ingo Molnar <mingo@kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753432AbdLNRm7 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 14 Dec 2017 12:42:59 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Ingo,

	Please consider pulling,

- Arnaldo

Test results at the end of this message, as usual.

The following changes since commit 10c91577d5e631773a6394e14cf60125389b71ae:

  x86/tools: Standardize output format of insn_decode_test (2017-12-12 13:27:47 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.16-20171214

for you to fetch changes up to 64b86173c3f90de348a5f010e2e504168fddc01e:

  perf evsel: Enable ignore_missing_thread for pid option (2017-12-13 18:07:01 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

- Allow system wide 'perf stat --per-thread', sorting the result (Jin Yao)

  E.g.:

  [root@jouet ~]# perf stat --per-thread --metrics IPC
  ^C
   Performance counter stats for 'system wide':

              make-22229  23,012,094,032  inst_retired.any   #  0.8 IPC
               cc1-22419     692,027,497  inst_retired.any   #  0.8 IPC
               gcc-22418     328,231,855  inst_retired.any   #  0.9 IPC
               cc1-22509     220,853,647  inst_retired.any   #  0.8 IPC
               gcc-22486     199,874,810  inst_retired.any   #  1.0 IPC
                as-22466     177,896,365  inst_retired.any   #  0.9 IPC
               cc1-22465     150,732,374  inst_retired.any   #  0.8 IPC
               gcc-22508     112,555,593  inst_retired.any   #  0.9 IPC
               cc1-22487     108,964,079  inst_retired.any   #  0.7 IPC
   qemu-system-x86-2697       21,330,550  inst_retired.any   #  0.3 IPC
   systemd-journal-551        20,642,951  inst_retired.any   #  0.4 IPC
   docker-containe-17651       9,552,892  inst_retired.any   #  0.5 IPC
   dockerd-current-9809        7,528,586  inst_retired.any   #  0.5 IPC
              make-22153  12,504,194,380  inst_retired.any   #  0.8 IPC
           python2-22429  12,081,290,954  inst_retired.any   #  0.8 IPC
  <SNIP>
           python2-22429  15,026,328,103  cpu_clk_unhalted.thread
               cc1-22419     826,660,193  cpu_clk_unhalted.thread
               gcc-22418     365,321,295  cpu_clk_unhalted.thread
               cc1-22509     279,169,362  cpu_clk_unhalted.thread
               gcc-22486     210,156,950  cpu_clk_unhalted.thread
  <SNIP>

       5.638075538 seconds time elapsed

  [root@jouet ~]#

- Ignore threads when they vanish after procfs based enumeration and
  before we try to use them with sys_perf_event_open(), i.e. just remove
  them from the thread_map and continue with the rest. This makes, among
  other cases, the previous new feature (perf stat --per-thread for system
  wide, albeit that not seeming to be the motivation for this patch) more
  robust. (Mengting Zhang)

- Generate s390 syscall table from asm/unistd.h, doing like x86,
  removing the dependency on audit-libs to do this id->string translation,
  speeding up the support for newly introducted syscalls (Hendrik Brueckner)

- Fix 'perf test' on filesystems where readdir() returns d_type == DT_UNKNOWN,
  such as XFS (Jiri Olsa)

- Fix PERF_SAMPLE_RAW_DATA endianity handling for cross-arch tracepoint
  processing (Jiri Olsa)

- Add __return suffix for return events in 'perf probe', streamlining
  entry/exit tracing (Masami Hiramatsu)

- Improve support for versioned symbols in 'perf probe" (Masami Hiramatsu)

- Clarify error message about invalid 'perf probe' event names (Masami Hiramatsu)

- Fix check open filename arg using 'perf trace' in a 'perf test' entry for
  systems using glibc >= 2.26, such as some ARM and s390 distros (Michael Petlan)

- Make method for obtaining the (normalized) architecture id for a
  perf.data file or for the running system used by the annotation routines
  generally available, next user will be for generating per arch errno
  string tables to allow for pretty printing errno codes recorded in a
  perf.data file in architecture A to be properly decoded on hardware
  archictecture B.  (Arnaldo Carvalho de Melo)

- Synchronize KVM and x86 ABI headers with the kernel sources (Arnaldo Carvalho de Melo)

- Remove duplicate includes, found using scripts/checkincludes.pl (Pravin Shedge)

- s390 needs -fPIC, enable it, also revert a patch that supposedly did
  that but instead enabled -fPIC for x86 (Hendrik Brueckner, Arnaldo Carvalho de Melo)

- Grab a copy of arch/s390/include/uapi/asm/perf_regs.h from the kernel
  sources, use it in the libdw support for this arch instead of using
  the kernel sources directly, which breaks the build when using
  detached perf tarballs, i.e. not building perf hosted in the kernel
  sources (Arnaldo Carvalho de Melo)

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Arnaldo Carvalho de Melo (7):
      perf annotate: Get the cpuid from evsel->evlist->env in symbol__annotate()
      perf annotate: Use perf_env when obtaining the arch name
      perf env: Adopt perf_env__arch() from the annotate code
      tools headers: Synchronize KVM arch ABI headers
      tools headers: Synchronize kernel x86 UAPI headers
      tools arch s390: Do not include header files from the kernel sources
      Revert "perf s390: Always build with -fPIC"

Hendrik Brueckner (4):
      tools include s390: Grab a copy of arch/s390/include/uapi/asm/unistd.h
      perf s390: Generate system call table from asm/unistd.h
      perf trace: Use generated syscall table on s390 too
      perf s390: Always build with -fPIC

Jin Yao (11):
      perf stat: Define a structure for per-thread shadow stats
      perf stat: Extend rbtree to support per-thread shadow stats
      perf stat: Create the runtime_stat init/exit function
      perf stat: Update per-thread shadow stats
      perf stat: Print per-thread shadow stats
      perf stat: Remove a set of shadow stats static variables
      perf stat: Allocate shadow stats buffer for threads
      perf stat: Update or print per-thread stats
      perf thread_map: Enumerate all threads from /proc
      perf stat: Remove --per-thread pid/tid limitation
      perf stat: Resort '--per-thread' result

Jiri Olsa (3):
      perf utils: Move is_directory() to path.h
      perf test: Handle properly readdir DT_UNKNOWN
      perf evsel: Fix swap for samples with raw data

Masami Hiramatsu (6):
      perf probe: Add warning message if there is unexpected event name
      perf probe: Cut off the version suffix from event name
      perf probe: Add __return suffix for return events
      perf probe: Find versioned symbols from map
      perf string: Add {strdup,strpbrk}_esc()
      perf probe: Support escaped character in parser

Mengting Zhang (1):
      perf evsel: Enable ignore_missing_thread for pid option

Michael Petlan (1):
      perf test shell: Fix check open filename arg using 'perf trace'

Pravin Shedge (1):
      perf perf: Remove duplicate includes

 tools/arch/s390/include/uapi/asm/perf_regs.h       |  44 +++
 tools/arch/s390/include/uapi/asm/unistd.h          | 412 ++++++++++++++++++++
 tools/arch/x86/include/asm/cpufeatures.h           |   1 +
 tools/include/uapi/linux/kvm.h                     |   4 +-
 tools/perf/Documentation/perf-probe.txt            |  18 +-
 tools/perf/Makefile.config                         |  11 +-
 tools/perf/arch/common.c                           |  44 +--
 tools/perf/arch/common.h                           |   1 -
 tools/perf/arch/powerpc/util/sym-handling.c        |   8 +
 tools/perf/arch/s390/Makefile                      |  21 ++
 tools/perf/arch/s390/entry/syscalls/mksyscalltbl   |  36 ++
 tools/perf/arch/s390/include/perf_regs.h           |   2 +-
 tools/perf/bench/futex-hash.c                      |   1 -
 tools/perf/builtin-c2c.c                           |   3 -
 tools/perf/builtin-record.c                        |   5 +-
 tools/perf/builtin-script.c                        |  20 +-
 tools/perf/builtin-stat.c                          | 168 +++++++--
 tools/perf/builtin-top.c                           |   2 +-
 tools/perf/check-headers.sh                        |   2 +
 tools/perf/tests/builtin-test.c                    |  10 +-
 tools/perf/tests/parse-events.c                    |   1 -
 tools/perf/tests/shell/trace+probe_vfs_getname.sh  |   7 +-
 tools/perf/tests/thread-map.c                      |   2 +-
 tools/perf/ui/browsers/annotate.c                  |   4 +-
 tools/perf/ui/gtk/annotate.c                       |   2 +-
 tools/perf/util/annotate.c                         |  26 +-
 tools/perf/util/annotate.h                         |   2 +-
 tools/perf/util/auxtrace.c                         |   3 -
 tools/perf/util/env.c                              |  47 +++
 tools/perf/util/env.h                              |   2 +
 tools/perf/util/evlist.c                           |   3 +-
 tools/perf/util/evsel.c                            |  80 +++-
 tools/perf/util/evsel.h                            |   3 +-
 tools/perf/util/header.c                           |   2 -
 tools/perf/util/metricgroup.c                      |   2 -
 tools/perf/util/path.c                             |  14 +
 tools/perf/util/path.h                             |   3 +
 tools/perf/util/probe-event.c                      |  85 +++--
 tools/perf/util/python-ext-sources                 |   1 +
 .../util/scripting-engines/trace-event-python.c    |   1 -
 tools/perf/util/stat-shadow.c                      | 416 ++++++++++++---------
 tools/perf/util/stat.c                             |  15 +-
 tools/perf/util/stat.h                             |  63 +++-
 tools/perf/util/string.c                           |  46 +++
 tools/perf/util/string2.h                          |   2 +
 tools/perf/util/symbol.c                           |   5 +
 tools/perf/util/symbol.h                           |   1 +
 tools/perf/util/syscalltbl.c                       |   4 +
 tools/perf/util/target.h                           |   7 +
 tools/perf/util/thread_map.c                       |   5 +-
 tools/perf/util/thread_map.h                       |   2 +-
 tools/perf/util/unwind-libunwind.c                 |   4 +-
 52 files changed, 1311 insertions(+), 362 deletions(-)
 create mode 100644 tools/arch/s390/include/uapi/asm/perf_regs.h
 create mode 100644 tools/arch/s390/include/uapi/asm/unistd.h
 create mode 100755 tools/perf/arch/s390/entry/syscalls/mksyscalltbl

Test results:

The first ones are container (docker) based builds of tools/perf with and
without libelf support.  Where clang is available, it is also used to build
perf with/without libelf.

The objtool and samples/bpf/ builds are disabled now that I'm switching from
using the sources in a local volume to fetching them from a http server to
build it inside the container, to make it easier to build in a container cluster.
Those will come back later.

Several are cross builds, the ones with -x-ARCH and the android one, and those
may not have all the features built, due to lack of multi-arch devel packages,
available and being used so far on just a few, like
debian:experimental-x-{arm64,mipsel}.

The 'perf test' one will perform a variety of tests exercising
tools/perf/util/, tools/lib/{bpf,traceevent,etc}, as well as run perf commands
with a variety of command line event specifications to then intercept the
sys_perf_event syscall to check that the perf_event_attr fields are set up as
expected, among a variety of other unit tests.

Then there is the 'make -C tools/perf build-test' ones, that build tools/perf/
with a variety of feature sets, exercising the build with an incomplete set of
features as well as with a complete one. It is planned to have it run on each
of the containers mentioned above, using some container orchestration
infrastructure. Get in contact if interested in helping having this in place.

  # dm
   1 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0
   2 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822
   3 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0
   4 alpine:edge                   : Ok   gcc (Alpine 6.4.0) 6.4.0
   5 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
   6 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
   7 centos:5                      : Ok   gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
   8 centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-18)
   9 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-16)
  10 debian:7                      : Ok   gcc (Debian 4.7.2-5) 4.7.2
  11 debian:8                      : Ok   gcc (Debian 4.9.2-10) 4.9.2
  12 debian:9                      : Ok   gcc (Debian 6.3.0-18) 6.3.0 20170516
  13 debian:experimental           : Ok   gcc (Debian 7.2.0-17) 7.2.1 20171205
  14 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
  15 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
  16 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 7.2.0-11) 7.2.0
  17 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
  18 fedora:20                     : Ok   gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7)
  19 fedora:21                     : Ok   gcc (GCC) 4.9.2 20150212 (Red Hat 4.9.2-6)
  20 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  21 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  22 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1)
  23 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
  24 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1)
  25 fedora:26                     : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2)
  26 fedora:27                     : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2)
  27 fedora:rawhide                : Ok   gcc (GCC) 7.2.1 20170829 (Red Hat 7.2.1-1)
  28 gentoo-stage3-amd64:latest    : Ok   gcc (Gentoo 6.4.0 p1.1) 6.4.0
  29 mageia:5                      : Ok   gcc (GCC) 4.9.2
  30 mageia:6                      : Ok   gcc (Mageia 5.4.0-5.mga6) 5.4.0
  31 opensuse:42.1                 : Ok   gcc (SUSE Linux) 4.8.5
  32 opensuse:42.2                 : Ok   gcc (SUSE Linux) 4.8.5
  33 opensuse:42.3                 : Ok   gcc (SUSE Linux) 4.8.5
  34 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 7.2.1 20171020 [gcc-7-branch revision 253932]
  35 oraclelinux:6                 : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-18)
  36 oraclelinux:7                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-16)
  37 ubuntu:12.04.5                : Ok   gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3
  38 ubuntu:14.04.4                : Ok   gcc (Ubuntu 4.8.4-2ubuntu1~14.04.3) 4.8.4
  39 ubuntu:14.04.4-x-linaro-arm64 : Ok   aarch64-linux-gnu-gcc (Linaro GCC 5.4-2017.05) 5.4.1 20170404
  40 ubuntu:15.04                  : Ok   gcc (Ubuntu 4.9.2-10ubuntu13) 4.9.2
  41 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.5) 5.4.0 20160609
  42 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  43 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  44 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  45 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.1) 5.4.0 20160609
  46 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  47 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  48 ubuntu:16.10                  : Ok   gcc (Ubuntu 6.2.0-5ubuntu12) 6.2.0 20161005
  49 ubuntu:17.04                  : Ok   gcc (Ubuntu 6.3.0-12ubuntu2) 6.3.0 20170406
  50 ubuntu:17.10                  : Ok   gcc (Ubuntu 7.2.0-8ubuntu3) 7.2.0
  51 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.2.0-16ubuntu1) 7.2.0

  # uname -a
  Linux jouet 4.15.0-rc3+ #3 SMP Wed Dec 13 10:14:18 -03 2017 x86_64 x86_64 x86_64 GNU/Linux
  # perf test
   1: vmlinux symtab matches kallsyms                       : Ok
   2: Detect openat syscall event                           : Ok
   3: Detect openat syscall event on all cpus               : Ok
   4: Read samples using the mmap interface                 : Ok
   5: Test data source output                               : Ok
   6: Parse event definition strings                        : Ok
   7: Simple expression parser                              : Ok
   8: PERF_RECORD_* events & perf_sample fields             : Ok
   9: Parse perf pmu format                                 : Ok
  10: DSO data read                                         : Ok
  11: DSO data cache                                        : Ok
  12: DSO data reopen                                       : Ok
  13: Roundtrip evsel->name                                 : Ok
  14: Parse sched tracepoints fields                        : Ok
  15: syscalls:sys_enter_openat event fields                : Ok
  16: Setup struct perf_event_attr                          : Ok
  17: Match and link multiple hists                         : Ok
  18: 'import perf' in python                               : Ok
  19: Breakpoint overflow signal handler                    : Ok
  20: Breakpoint overflow sampling                          : Ok
  21: Number of exit events of a simple workload            : Ok
  22: Software clock events period values                   : Ok
  23: Object code reading                                   : Ok
  24: Sample parsing                                        : Ok
  25: Use a dummy software event to keep tracking           : Ok
  26: Parse with no sample_id_all bit set                   : Ok
  27: Filter hist entries                                   : Ok
  28: Lookup mmap thread                                    : Ok
  29: Share thread mg                                       : Ok
  30: Sort output of hist entries                           : Ok
  31: Cumulate child hist entries                           : Ok
  32: Track with sched_switch                               : Ok
  33: Filter fds with revents mask in a fdarray             : Ok
  34: Add fd to a fdarray, making it autogrow               : Ok
  35: kmod_path__parse                                      : Ok
  36: Thread map                                            : Ok
  37: LLVM search and compile                               :
  37.1: Basic BPF llvm compile                              : Ok
  37.2: kbuild searching                                    : Ok
  37.3: Compile source for BPF prologue generation          : Ok
  37.4: Compile source for BPF relocation                   : Ok
  38: Session topology                                      : Ok
  39: BPF filter                                            :
  39.1: Basic BPF filtering                                 : Ok
  39.2: BPF pinning                                         : Ok
  39.3: BPF prologue generation                             : Ok
  39.4: BPF relocation checker                              : Ok
  40: Synthesize thread map                                 : Ok
  41: Remove thread map                                     : Ok
  42: Synthesize cpu map                                    : Ok
  43: Synthesize stat config                                : Ok
  44: Synthesize stat                                       : Ok
  45: Synthesize stat round                                 : Ok
  46: Synthesize attr update                                : Ok
  47: Event times                                           : Ok
  48: Read backward ring buffer                             : Ok
  49: Print cpu map                                         : Ok
  50: Probe SDT events                                      : Ok
  51: is_printable_array                                    : Ok
  52: Print bitmap                                          : Ok
  53: perf hooks                                            : Ok
  54: builtin clang support                                 : Skip (not compiled in)
  55: unit_number__scnprintf                                : Ok
  56: x86 rdpmc                                             : Ok
  57: Convert perf time to TSC                              : Ok
  58: DWARF unwind                                          : Ok
  59: x86 instruction decoder - new instructions            : Ok
  60: Use vfs_getname probe to get syscall args filenames   : Ok
  61: probe libc's inet_pton & backtrace it with ping       : Ok
  62: Check open filename arg using perf trace + vfs_getname: Ok
  63: Add vfs_getname probe to get syscall args filenames   : Ok
  #
  
  $ make -C tools/perf build-test
  make: Entering directory '/home/acme/git/perf/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
                    make_doc_O: make doc
                   make_help_O: make help
           make_no_libbionic_O: make NO_LIBBIONIC=1
             make_util_map_o_O: make util/map.o
                make_no_newt_O: make NO_NEWT=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
                   make_pure_O: make
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
            make_no_demangle_O: make NO_DEMANGLE=1
           make_no_libunwind_O: make NO_LIBUNWIND=1
            make_no_auxtrace_O: make NO_AUXTRACE=1
            make_install_bin_O: make install-bin
              make_no_libbpf_O: make NO_LIBBPF=1
         make_install_prefix_O: make install prefix=/tmp/krava
                make_install_O: make install
               make_no_slang_O: make NO_SLANG=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1
                 make_perf_o_O: make perf.o
           make_no_backtrace_O: make NO_BACKTRACE=1
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
                 make_static_O: make LDFLAGS=-static
           make_no_libpython_O: make NO_LIBPYTHON=1
              make_no_libelf_O: make NO_LIBELF=1
             make_no_libperl_O: make NO_LIBPERL=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
                make_no_gtk2_O: make NO_GTK2=1
                  make_debug_O: make DEBUG=1
             make_no_libnuma_O: make NO_LIBNUMA=1
         make_with_clangllvm_O: make LIBCLANGLLVM=1
                   make_tags_O: make tags
              make_clean_all_O: make clean all
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
  OK
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $
