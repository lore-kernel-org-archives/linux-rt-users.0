From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH 0/9] tracing: Bug fixes and minor cleanup
Date: Fri, 22 Sep 2017 14:58:14 -0500
Message-ID: <cover.1506105045.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

This is a set of small fixes and cleanup patches that were originally
part of V2 of the inter-event tracing patchset, along with 2 of Steve
Rostedt's patches related to that patchset.

The 'tracing: Steve's unofficial trace_recursive_lock() patch' patch
is from Steve but not signed off on - he has a replacement under test
that should replace this.

The 'tracing: Reverse the order of trace_types_lock and event_mutex'
is an official patch from Steve, included here for convenience.

The rest are bugfixes and cleanups from the old V2 inter-event
patchset, separated out since they're standalone improvements that can
stand on their own outside of the inter-event patches.

Thanks,

Tom

The following changes since commit 170b3b1050e28d1ba0700e262f0899ffa4fccc52:

  tracing: Apply trace_clock changes to instance max buffer (2017-09-06 20:52:20 -0400)

are available in the git repository at:

  https://github.com/tzanussi/linux-trace-inter-event.git tzanussi/pre-inter-event-v3
  https://github.com/tzanussi/linux-trace-inter-event/tree/tzanussi/pre-inter-event-v3

Steven Rostedt (1):
  tracing: Steve's unofficial trace_recursive_lock() patch

Steven Rostedt (VMware) (1):
  tracing: Reverse the order of trace_types_lock and event_mutex

Tom Zanussi (7):
  tracing: Exclude 'generic fields' from histograms
  tracing: Remove lookups from tracing_map hitcount
  tracing: Increase tracing map KEYS_MAX size
  tracing: Make traceprobe parsing code reusable
  tracing: Clean up hist_field_flags enum
  tracing: Add hist_field_name() accessor
  tracing: Reimplement log2

 kernel/trace/ring_buffer.c       |  64 ++++++--------------
 kernel/trace/trace.c             |  91 +++++++++++++++++++++++++++++
 kernel/trace/trace.h             |   7 +++
 kernel/trace/trace_events.c      |  31 +++++-----
 kernel/trace/trace_events_hist.c | 122 +++++++++++++++++++++++++++------------
 kernel/trace/trace_kprobe.c      |  18 +++---
 kernel/trace/trace_probe.c       |  86 ---------------------------
 kernel/trace/trace_probe.h       |   7 ---
 kernel/trace/trace_uprobe.c      |   2 +-
 kernel/trace/tracing_map.c       |   3 +-
 kernel/trace/tracing_map.h       |   2 +-
 11 files changed, 227 insertions(+), 206 deletions(-)

-- 
1.9.3
