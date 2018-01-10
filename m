From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v8 00/37] tracing: Inter-event (e.g. latency) support
Date: Wed, 10 Jan 2018 09:18:30 -0600
Message-ID: <1515597510.3496.20.camel@tzanussi-mobl.amr.corp.intel.com>
References: <cover.1513802700.git.tom.zanussi@linux.intel.com>
         <20180110054507.GB2575@danjae.aot.lge.com>
         <20180110022054.1086b477@vmware.local.home>
         <20180110081607.GC2575@danjae.aot.lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>, tglx@linutronix.de,
        mhiramat@kernel.org, vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, julia@ni.com, fengguang.wu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        kernel-team@lge.com
To: Namhyung Kim <namhyung@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180110081607.GC2575@danjae.aot.lge.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2018-01-10 at 17:16 +0900, Namhyung Kim wrote:
> Hi Steve,
> 
> On Wed, Jan 10, 2018 at 02:20:54AM -0500, Steven Rostedt wrote:
> > On Wed, 10 Jan 2018 14:45:07 +0900
> > Namhyung Kim <namhyung@kernel.org> wrote:
> > 
> > > On Thu, Dec 21, 2017 at 10:02:22AM -0600, Tom Zanussi wrote:
> > > > Hi,
> > > > 
> > > > This is V8 of the inter-event tracing patchset, addressing input from
> > > > V7.
> > > > 
> > > > These changes address Namhyung's most recent comments (thanks,
> > > > Namhyung!) and move everything to the latest tracing/for-next:
> > > > 
> > > >   - moved a couple hunks switching hist_field_fn_t params from 15/37
> > > >     (add variable support) to 20/37 (Pass tracing_map_elt to
> > > >     hist_field_accessor)
> > > >   - in hist_trigger_elt_data_alloc(), remove the unnecessary '+1' from
> > > >     TASK_COMM_LEN size.
> > > >   - simplified find_var_file() code according to Namhyung's
> > > >     suggestions.
> > > >   - fixed bug in print_synth_event() where entry->fields was being
> > > >     used instead of the address as it should have been  
> > > 
> > > I only have a nitpick in the patch 24 but otherwise cannot find an
> > > issue anymore, so
> > > 
> > > Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> > 
> > Thanks for reviewing this Namhyung.
> 
> You're very welcome.
> 

Yes, thanks for the very thorough review, Namhyung.

> > 
> > I'm currently traveling (what else is new?), and I want to start
> > pulling this in. It wont be ready for the next merge window as it's too
> > close, but I want to get it in by the one after that. I need to
> > allocate some time to pull these patches in and review them as well.
> 
> Yeah, I also would like to see it merged in v4.17.  Have a nice travel
> and take care.
> 

I'll add these changes to a v9 along with another small nit found by the
kbuild bot (parse_atom() can be static) and repost soon.

Thanks,

Tom
