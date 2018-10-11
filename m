From: Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH v6 00/15] tracing: Hist trigger snapshot and onchange additions
Date: Thu, 11 Oct 2018 16:01:57 -0500
Message-ID: <cover.1539288364.git.tom.zanussi@linux.intel.com>
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

This is v6 of the hist trigger snapshot and onchange additions
patchset.  It breaks up the onchange patch into separate code,
Documentation, and test case patches, and adds a README-based check
for onchange functionality as suggested by Masami.

In addition to adding the above, I updated the README code with the
other new recent actions and handlers, as well as corresponding
updates to Documentation.

I also added a new snapshot() test case, and moved the new trace()
test case into its own file, to allow it to fail separately if
unsupported.

Also rebased to lastest ftrace/core.

v5->v6 changes:

  - Added new Documentation patch explaining handler.action
  - Added new README patch explaining handler.action
  - Added separate snapshot() Documentation
  - Added new snapshot() test case
  - Updated README with snapshote()
  - Added separate onchange() Documentation
  - Added separate onchange() test case
  - Updated README with onchange()
  - Added separate trace() test case
  - Updated README with trace() and <synthetic_event>() syntax

v4->v5 changes:

  - added 'trace' keyword test case
  - added 'onchange' handler test case

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

The following changes since commit a6ca88b241d5e929e6e60b12ad8cd288f0ffa256:

  trace_uprobe: support reference counter in fd-based uprobe (2018-10-10 22:14:17 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/hist-snapshot-onchange-v6

Tom Zanussi (15):
  tracing: Refactor hist trigger action code
  tracing: Make hist trigger Documentation better reflect
    actions/handlers
  tracing: Add hist trigger handler.action documentation to README
  tracing: Split up onmatch action data
  tracing: Generalize hist trigger onmax and save action
  tracing: Add conditional snapshot
  tracing: Move hist trigger key printing into a separate function
  tracing: Add hist trigger snapshot() action
  tracing: Add hist trigger snapshot() action Documentation
  tracing: Add hist trigger snapshot() action test case
  tracing: Add hist trigger onchange() handler
  tracing: Add hist trigger onchange() handler Documentation
  tracing: Add hist trigger onchange() handler test case
  tracing: Add alternative synthetic event trace action syntax
  tracing: Add alternative synthetic event trace action test case

 Documentation/trace/histogram.rst                  |  285 +++++-
 kernel/trace/trace.c                               |  177 +++-
 kernel/trace/trace.h                               |   56 +-
 kernel/trace/trace_events_hist.c                   | 1062 +++++++++++++++-----
 kernel/trace/trace_events_trigger.c                |    2 +-
 kernel/trace/trace_sched_wakeup.c                  |    2 +-
 .../inter-event/trigger-onchange-action-hist.tc    |   39 +
 .../inter-event/trigger-snapshot-action-hist.tc    |   55 +
 .../inter-event/trigger-trace-action-hist.tc       |   52 +
 9 files changed, 1430 insertions(+), 300 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-trace-action-hist.tc

-- 
2.14.1
