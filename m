From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v5 15/37] tracing: Add variable support to hist triggers
Date: Fri, 10 Nov 2017 08:24:13 -0500
Message-ID: <20171110082413.25405a81@gandalf.local.home>
References: <cover.1510252666.git.tom.zanussi@linux.intel.com>
        <d9fc474596939557a4db9adb92eec65bd2283131.1510252666.git.tom.zanussi@linux.intel.com>
        <20171110072841.GB1544@danjae.aot.lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>, tglx@linutronix.de,
        mhiramat@kernel.org, vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, kernel-team@lge.com
To: Namhyung Kim <namhyung@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171110072841.GB1544@danjae.aot.lge.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 10 Nov 2017 16:28:41 +0900
Namhyung Kim <namhyung@kernel.org> wrote:

> > +			hist_data->attrs->var_defs.expr[n_vars++] = s;
> > +
> > +			hist_data->attrs->var_defs.n_vars = n_vars;
> > +
> > +			if (n_vars == TRACING_MAP_VARS_MAX)
> > +				goto free;  
> 
> This will silently discard all variables.  Why not returning an error?
> Also I think it should be moved to the beginning of this block..

Right, because the check here is already too late. Usually you check
the count before doing the assignment.


	if (n_vars == TRACING_MAP_VARS_MAX)
		goto free;

	hist_data->attrs->var_defs.expr[n_vars++] = s;

Because it is OK for n_vars to equal TRACING_MAP_VARS_MAX, but not OK
to be more.

-- Steve
