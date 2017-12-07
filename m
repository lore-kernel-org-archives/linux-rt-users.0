From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v2 0/5] perf-probe: Improve probing on versioned symbols
Date: Thu,  7 Dec 2017 16:19:16 +0900
Message-ID: <151263115609.13843.6362262297053841418.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        bhargavb <bhargavaramudu@gmail.com>,
        linux-kernel@vger.kernel.org, Paul Clarke <pc@us.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        linux-rt-users@vger.kernel.org, linux-perf-users@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

Here is the 2nd version of the series for probing on
versioned symbols in libraries. This includes 5 patches
to fix the issues discussed on perf-users ML 
(https://www.spinics.net/lists/linux-perf-users/msg04637.html)

The first version is here; https://lkml.org/lkml/2017/12/5/1124

Here is the updates;

[3/5] Add a description in Documentation/perf-probe.txt
[5/5] Add a description and examples in Documentation/perf-probe.txt

Thank you,
---

Masami Hiramatsu (5):
      perf-probe: Add warning message if there is unexpected event name
      perf-probe: Cut off the version suffix from event name
      perf-probe: Add __return suffix for return events
      perf-probe: Find versioned symbols from map
      perf-probe: Support escaped character in parser


 tools/perf/Documentation/perf-probe.txt     |   18 ++++++
 tools/perf/arch/powerpc/util/sym-handling.c |    8 +++
 tools/perf/util/probe-event.c               |   81 +++++++++++++++++++--------
 tools/perf/util/string.c                    |   46 +++++++++++++++
 tools/perf/util/string2.h                   |    2 +
 tools/perf/util/symbol.c                    |    5 ++
 tools/perf/util/symbol.h                    |    1 
 7 files changed, 137 insertions(+), 24 deletions(-)

--
Masami Hiramatsu (Linaro Ltd.) <mhiramat@kernel.org>
