From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v8 00/37] tracing: Inter-event (e.g. latency) support
Date: Wed, 10 Jan 2018 02:20:54 -0500
Message-ID: <20180110022054.1086b477@vmware.local.home>
References: <cover.1513802700.git.tom.zanussi@linux.intel.com>
        <20180110054507.GB2575@danjae.aot.lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>, tglx@linutronix.de,
        mhiramat@kernel.org, vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, julia@ni.com, fengguang.wu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        kernel-team@lge.com
To: Namhyung Kim <namhyung@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180110054507.GB2575@danjae.aot.lge.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 10 Jan 2018 14:45:07 +0900
Namhyung Kim <namhyung@kernel.org> wrote:

> On Thu, Dec 21, 2017 at 10:02:22AM -0600, Tom Zanussi wrote:
> > Hi,
> > 
> > This is V8 of the inter-event tracing patchset, addressing input from
> > V7.
> > 
> > These changes address Namhyung's most recent comments (thanks,
> > Namhyung!) and move everything to the latest tracing/for-next:
> > 
> >   - moved a couple hunks switching hist_field_fn_t params from 15/37
> >     (add variable support) to 20/37 (Pass tracing_map_elt to
> >     hist_field_accessor)
> >   - in hist_trigger_elt_data_alloc(), remove the unnecessary '+1' from
> >     TASK_COMM_LEN size.
> >   - simplified find_var_file() code according to Namhyung's
> >     suggestions.
> >   - fixed bug in print_synth_event() where entry->fields was being
> >     used instead of the address as it should have been  
> 
> I only have a nitpick in the patch 24 but otherwise cannot find an
> issue anymore, so
> 
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks for reviewing this Namhyung.

I'm currently traveling (what else is new?), and I want to start
pulling this in. It wont be ready for the next merge window as it's too
close, but I want to get it in by the one after that. I need to
allocate some time to pull these patches in and review them as well.

-- Steve
