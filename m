From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v3 0/5] perf-probe: Improve probing on versioned symbols
Date: Sat,  9 Dec 2017 01:26:17 +0900
Message-ID: <151275037752.24652.5169845651138876257.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        bhargavb <bhargavaramudu@gmail.com>,
        linux-kernel@vger.kernel.org, Paul Clarke <pc@us.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        linux-rt-users@vger.kernel.org, linux-perf-users@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

Here is the 3rd version of the series for probing on
versioned symbols in libraries. This includes 5 patches
to fix the issues discussed on perf-users ML 
(https://www.spinics.net/lists/linux-perf-users/msg04637.html)

The first version (and detail note) is here;
 https://lkml.org/lkml/2017/12/5/1124

Here is the updates;

[1/5] Update error message. Arnaldo, I dropped the latter 
  half from error message because it doesn't try to write
  the name to the kprobe_events interface.
[4/5] Fix 2 bugs (Thanks Thomas-Mich Richter!)
[5/5] Update according to previous patch.

Thank you,
---

Masami Hiramatsu (5):
      perf-probe: Add warning message if there is unexpected event name
      perf-probe: Cut off the version suffix from event name
      perf-probe: Add __return suffix for return events
      perf-probe: Find versioned symbols from map
      perf-probe: Support escaped character in parser


 tools/perf/Documentation/perf-probe.txt     |   18 +++++-
 tools/perf/arch/powerpc/util/sym-handling.c |    8 +++
 tools/perf/util/probe-event.c               |   84 +++++++++++++++++++--------
 tools/perf/util/string.c                    |   46 +++++++++++++++
 tools/perf/util/string2.h                   |    2 +
 tools/perf/util/symbol.c                    |    5 ++
 tools/perf/util/symbol.h                    |    1 
 7 files changed, 139 insertions(+), 25 deletions(-)

--
Masami Hiramatsu (Linaro Ltd.) <mhiramat@kernel.org>
