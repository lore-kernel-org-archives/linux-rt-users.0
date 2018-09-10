From: Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH v4 0/8] tracing: Hist trigger snapshot and onchange additions
Date: Mon, 10 Sep 2018 14:10:38 -0500
Message-ID: <cover.1536605847.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
To: rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Hi,

This is v4 of the hist trigger snapshot and onchange additions
patchset.  It adds fixes to a couple problems noticed by Namhyung Kim,
as well as one minor syntax addition ('trace' keyword for generating
synthetic events) also suggested by him.

v3->v4 changes:

  - added 'trace' keyword for generating synthetic events
  - fix elt_data leak
  - changed cond_update to cond_update_fn_t

v2->v3 changes:

  - fixed problem where trace actions were only being allowed for
    onmatch handlers - now trace actions can be used with any handler.
  - fixed problem where no action was being assigned to onmatch
    handlers if save or snapshot actions were specified.

v1->v2 changes:

  - added missing tracing_cond_snapshot_data() definition for when
    CONFIG_TRACER_SNAPSHOT not defined
  - removed an unnecessary WARN_ON() in track_data_snapshot_print()


Original text:

This patchset adds some useful new functions to the hist
trigger code: a snapshot action and an onchange handler.

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


The following changes since commit 9161a864ff88e800de50494da095af19832e9583:

  tracing/kprobes: Fix to check notrace function with correct range (2018-08-21 09:41:12 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/hist-snapshot-onchange-v4

Tom Zanussi (8):
  tracing: Refactor hist trigger action code
  tracing: Split up onmatch action data
  tracing: Generalize hist trigger onmax and save action
  tracing: Add conditional snapshot
  tracing: Move hist trigger key printing into a separate function
  tracing: Add snapshot action
  tracing: Add hist trigger onchange() handler
  trace: Add alternative synthetic event trace action syntax

 Documentation/trace/histogram.txt   |  226 ++++++++
 kernel/trace/trace.c                |  162 +++++-
 kernel/trace/trace.h                |   56 +-
 kernel/trace/trace_events_hist.c    | 1062 ++++++++++++++++++++++++++---------
 kernel/trace/trace_events_trigger.c |    2 +-
 kernel/trace/trace_sched_wakeup.c   |    2 +-
 6 files changed, 1224 insertions(+), 286 deletions(-)

-- 
2.14.1
