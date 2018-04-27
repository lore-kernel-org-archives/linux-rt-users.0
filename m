From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH 0/3] A few hist trigger fixes
Date: Thu, 26 Apr 2018 20:04:46 -0500
Message-ID: <cover.1524790601.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, julia@ni.com, fengguang.wu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Steve,

Here are a few patches that fix some problems found when testing the
hist trigger inter-event (e.g. latency) support patches.

The first fixes a problem I noticed when printing flags.

The remaining two add some hist_err() calls for fields, the first
reported by Masami, the second something I noticed when fixing the
first.

Thanks,

Tom

The following changes since commit 0566e40ce7c493d39006cdd7edf17bfdc52eb2ac:

  tracing: initcall: Ordered comparison of function pointers (2018-04-26 15:02:46 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/hist-fixes-1

Tom Zanussi (3):
  tracing: Restore proper field flag printing when displaying triggers
  tracing: Add field parsing hist error for hist triggers
  tracing: Add field modifier parsing hist error for hist triggers

 kernel/trace/trace_events_hist.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

-- 
1.9.3
