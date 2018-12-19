From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 0/7] tracing: Hist trigger var-ref cleanup and comments
Date: Wed, 19 Dec 2018 20:45:17 +0900
Message-ID: <20181219114517.GA19177@danjae.aot.lge.com>
References: <cover.1545161087.git.tom.zanussi@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, kernel-team@lge.com
To: Tom Zanussi <zanussi@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1545161087.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Tom,

On Tue, Dec 18, 2018 at 02:33:19PM -0600, Tom Zanussi wrote:
> From: Tom Zanussi <tom.zanussi@linux.intel.com>
> 
> Hi,
> 
> This patchset is a standalone series broken out of the v8 version of
> the 'tracing: Hist trigger snapshot and onchange additions' patchset.
> 
> It's a series of changes resulting from some suggestions from Namhyung
> for making the variable-reference handling code more understandable
> through some refactoring and comments.
> 
> It also added a new patch changing all strlen() to sizeof() for string
> constants, in trace_events_hist.c
> 
> Also, in the 'tracing: Remove open-coding of hist trigger var_ref
> management' patch, in create_var_ref(), moved the saving of ref_field
> and update of ref_field->var_ref_idx into the 'if' as pointed out by
> Dan Carpenter/smatch 0-day robot.
> 
> It doesn't introduce any functional changes and can be applied
> independently of the other patchset.

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> 
> The following changes since commit 5d6ddf6acce68d1290112cb08b12fd78b201e7d5:
> 
>   arm64: Use ftrace_graph_get_ret_stack() instead of curr_ret_stack (2018-12-08 22:21:31 -0500)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/hist-var-ref-cleanup-v1
> 
> Tom Zanussi (7):
>   tracing: Remove unnecessary hist trigger struct field
>   tracing: Change strlen to sizeof for hist trigger static strings
>   tracing: Use var_refs[] for hist trigger reference checking
>   tracing: Remove open-coding of hist trigger var_ref management
>   tracing: Use hist trigger's var_ref array to destroy var_refs
>   tracing: Remove hist trigger synth_var_refs
>   tracing: Add hist trigger comments for variable-related fields
> 
>  kernel/trace/trace_events_hist.c | 267 +++++++++++++++++++++++----------------
>  1 file changed, 156 insertions(+), 111 deletions(-)
> 
> -- 
> 2.14.1
> 
