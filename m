From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH 0/4] tracing: A few inter-event bugfixes
Date: Wed, 28 Mar 2018 15:10:52 -0500
Message-ID: <cover.1522256721.git.tom.zanussi@linux.intel.com>
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

Hi Steven,

Here are a few bugfixes that should be applied on top of the
'Inter-event (e.g. latency) support v9' patchset.

The first two are things introduced by the refactoring of the last
version, the third I noticed when adding further actions for a future
add-on, and the last was prompted by a patch for a similar problem
posted this morning by Arnd Bergmann.

Thanks,

Tom

The following changes since commit 80765597bc587feae8dbc8ce97a0f32e12a6e625:

  tracing: Rewrite filter logic to be simpler and faster (2018-03-14 12:35:39 -0400)

are available in the git repository at:

  https://github.com/tzanussi/linux-trace-inter-event.git tzanussi/inter-event-update1
  https://github.com/tzanussi/linux-trace-inter-event/tree/tzanussi/inter-event-update1

Tom Zanussi (4):
  tracing: Fix display of hist trigger expressions containing timestamps
  tracing: Don't add flag strings when displaying variable references
  tracing: Add action comparisons when testing matching hist triggers
  tracing: Make sure variable string fields are NULL-terminated

 kernel/trace/trace_events_hist.c | 75 +++++++++++++++++++++++++++++++---------
 1 file changed, 58 insertions(+), 17 deletions(-)

-- 
1.9.3
