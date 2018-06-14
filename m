From: Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH 0/7] tracing: Hist trigger snapshot and onchange additions
Date: Thu, 14 Jun 2018 12:45:09 -0500
Message-ID: <cover.1528986925.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, julia@ni.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Hi,

This patchset adds some useful new functions to the hist trigger code:
a snapshot action and an onchange handler.

In order to make it easier to add these and in the process make the
code more generic, I separated the code into explicit 'handlers' and
'actions', handlers being things like 'onmax' and 'onchange', and
'actions' being things like 'take a snapshot' or 'save some fields'.

The first few patches do that basic refactoring, which make it easier
to add the subsequent changes that arbitrarily combine actions and
handlers.

The fourth patch adds a 'conditional snapshot' capability that via a
new tracing_snaphot_cond() function extends the existing snapshot
code.  It allows the caller to associate some user data with the
snapshot that can be checked and saved in an update() callback whose
return value determines whether the snapshot should be taken or not.

The remaining patches finally add the new snapshot action and onchange
handler functionality - please see those patches for details and some
examples.

Thanks,

Tom

The following changes since commit 591a033dc17ff6f684b6b6d1d7426e22d178194f:

  tracing: Use match_string() instead of open coding it in trace_set_options() (2018-06-05 16:19:39 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/hist-snapshot-onchange-v1

Tom Zanussi (7):
  tracing: Refactor hist trigger action code
  tracing: Split up onmatch action data
  tracing: Generalize hist trigger onmax and save action
  tracing: Add conditional snapshot
  tracing: Move hist trigger key printing into a separate function
  tracing: Add snapshot action
  tracing: Add hist trigger onchange() handler

 Documentation/trace/histogram.txt   | 206 ++++++++
 kernel/trace/trace.c                | 155 +++++-
 kernel/trace/trace.h                |  58 ++-
 kernel/trace/trace_events_hist.c    | 982 ++++++++++++++++++++++++++----------
 kernel/trace/trace_events_trigger.c |   2 +-
 kernel/trace/trace_sched_wakeup.c   |   2 +-
 6 files changed, 1133 insertions(+), 272 deletions(-)

-- 
2.14.1
