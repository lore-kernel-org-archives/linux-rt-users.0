From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v2 0/7] tracing: Hist trigger snapshot and onchange
 additions
Date: Sun, 8 Jul 2018 00:00:06 +0900
Message-ID: <20180708000006.5b93884b8123392ab2446809@kernel.org>
References: <cover.1530561352.git.tom.zanussi@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        namhyung@kernel.org, vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: Tom Zanussi <zanussi@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1530561352.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Tom,

On Mon,  2 Jul 2018 15:22:19 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> From: Tom Zanussi <tom.zanussi@linux.intel.com>
> 
> Hi,
> 
> This is v2 of the hist trigger snapshot and onchange additions
> patchset.  It adds a couple fixes to problems flagged by the kbuild
> test robot, but is otherwise the same as v1.
> 
> Changes since v1:
> 
>   - added missing tracing_cond_snapshot_data() definition for when
>     CONFIG_TRACER_SNAPSHOT not defined
>   - removed an unnecessary WARN_ON() in track_data_snapshot_print()
> 
> 
> Original text:
> 
> This patchset adds some useful new functions to the hist
> trigger code: a snapshot action and an onchange handler.
> 
> In order to make it easier to add these and in the process make the
> code more generic, I separated the code into explicit 'handlers' and
> 'actions', handlers being things like 'onmax' and 'onchange', and
> 'actions' being things like 'take a snapshot' or 'save some fields'.

Sounds great!

By the way, it seems that nowadays the syntax of trigger is
very complicated. For example, we can set some 'actions' without
handlers, but this introduce new 'handlers' on it.

Could you consider not just extending it, but refactor it from
the viewpoint of consistent and extensible syntax?

e.g. if we support

<actions> if <condition>

syntax, why we can not do 

<actions> onchange(<var>)

? :)

Thank you,

> 
> The first few patches do that basic refactoring, which make it easier
> to add the subsequent changes that arbitrarily combine actions and
> handlers.
> 
> The fourth patch adds a 'conditional snapshot' capability that via a
> new tracing_snaphot_cond() function extends the existing snapshot
> code.  It allows the caller to associate some user data with the
> snapshot that can be checked and saved in an update() callback whose
> return value determines whether the snapshot should be taken or not.
> 
> The remaining patches finally add the new snapshot action and onchange
> handler functionality - please see those patches for details and some
> examples.
> 
> Thanks,
> 
> Tom
> 
> The following changes since commit 591a033dc17ff6f684b6b6d1d7426e22d178194f:
> 
>   tracing: Use match_string() instead of open coding it in trace_set_options() (2018-06-05 16:19:39 -0400)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/hist-snapshot-onchange-v2
> 
> Tom Zanussi (7):
>   tracing: Refactor hist trigger action code
>   tracing: Split up onmatch action data
>   tracing: Generalize hist trigger onmax and save action
>   tracing: Add conditional snapshot
>   tracing: Move hist trigger key printing into a separate function
>   tracing: Add snapshot action
>   tracing: Add hist trigger onchange() handler
> 
>  Documentation/trace/histogram.txt   | 206 ++++++++
>  kernel/trace/trace.c                | 162 +++++-
>  kernel/trace/trace.h                |  58 ++-
>  kernel/trace/trace_events_hist.c    | 982 ++++++++++++++++++++++++++----------
>  kernel/trace/trace_events_trigger.c |   2 +-
>  kernel/trace/trace_sched_wakeup.c   |   2 +-
>  6 files changed, 1140 insertions(+), 272 deletions(-)
> 
> -- 
> 2.14.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
