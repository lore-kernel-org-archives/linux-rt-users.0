From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 0/5] perf-probe: Improve probing on versioned symbols
Date: Wed,  6 Dec 2017 12:06:20 +0900
Message-ID: <151252958056.12861.954203514347167563.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        bhargavb <bhargavaramudu@gmail.com>,
        linux-kernel@vger.kernel.org, Paul Clarke <pc@us.ibm.com>,
        linux-rt-users@vger.kernel.org, linux-perf-users@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

Here is the series for probing on versioned symbols
in libraries. This includes 5 patches to fix the
issues discussed on perf-users ML 
(https://www.spinics.net/lists/linux-perf-users/msg04637.html)

[1/5] Warn if the event name is invalid. This notices
   user that there is internal error which caused by
   unexpected input.
[2/5] Cut off the version suffix when making event name
   from symbol name. This fixes a issue when a wildcard
   hits versioned symbol.
[3/5] Add "__return" suffix to the event name 
   automatically for the return probe, so that user
   can easily identify which event is on function
   return.
[4/5] Find versioned symbol from map without wildcard.
   This allows user to specify a symbol without version
   suffix nor wildcard. Anyway, at this point we have
   no way to specify version suffix, because parser
   recognizes "@" is a separator of "function@file"
   syntax. This is fixed in next patch.
[5/5] Allow user to use backslash-escaped characters
   on command line. This has 2 effects, user can specify
   version suffix directly, and we can use special
   characters in source file.

Thanks,
---

Masami Hiramatsu (5):
      perf-probe: Add warning message if there is unexpected event name
      perf-probe: Cut off the version suffix from event name
      perf-probe: Add __return suffix for return events
      perf-probe: Find versioned symbols from map
      perf-probe: Support escaped character in parser


 tools/perf/arch/powerpc/util/sym-handling.c |    8 +++
 tools/perf/util/probe-event.c               |   81 +++++++++++++++++++--------
 tools/perf/util/string.c                    |   46 +++++++++++++++
 tools/perf/util/string2.h                   |    2 +
 tools/perf/util/symbol.c                    |    5 ++
 tools/perf/util/symbol.h                    |    1 
 6 files changed, 120 insertions(+), 23 deletions(-)

--
Masami Hiramatsu (Linaro Ltd.) <mhiramat@kernel.org>
