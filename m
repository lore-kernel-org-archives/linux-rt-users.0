From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v7 19/37] tracing: Generalize per-element hist trigger
 data
Date: Fri, 08 Dec 2017 13:56:27 -0600
Message-ID: <1512762987.4353.5.camel@tzanussi-mobl.amr.corp.intel.com>
References: <cover.1512593081.git.tom.zanussi@linux.intel.com>
         <28c717b25a6440648171c99fc2fc94f63164096a.1512593081.git.tom.zanussi@linux.intel.com>
         <20171208130629.GB7312@danjae.aot.lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, julia@ni.com, fengguang.wu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        kernel-team@lge.com
To: Namhyung Kim <namhyung@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171208130629.GB7312@danjae.aot.lge.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Namhyung,

On Fri, 2017-12-08 at 22:06 +0900, Namhyung Kim wrote:
> On Wed, Dec 06, 2017 at 04:38:00PM -0600, Tom Zanussi wrote:
> > Up until now, hist triggers only needed per-element support for saving
> > 'comm' data, which was saved directly as a private data pointer.
> > 
> > In anticipation of the need to save other data besides 'comm', add a
> > new hist_elt_data struct for the purpose, and switch the current
> > 'comm'-related code over to that.
> > 
> > Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> > ---
> >  kernel/trace/trace_events_hist.c | 76 +++++++++++++++++++++++-----------------
> >  1 file changed, 43 insertions(+), 33 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> > index f75f7bc..3aeab8e 100644
> > --- a/kernel/trace/trace_events_hist.c
> > +++ b/kernel/trace/trace_events_hist.c
> > @@ -289,6 +289,10 @@ static struct hist_field *find_var(struct hist_trigger_data *hist_data,
> >  	return NULL;
> >  }
> >  
> > +struct hist_elt_data {
> > +	char *comm;
> > +};
> > +
> >  static const char *hist_field_name(struct hist_field *field,
> >  				   unsigned int level)
> >  {
> > @@ -503,45 +507,61 @@ static inline void save_comm(char *comm, struct task_struct *task)
> >  	memcpy(comm, task->comm, TASK_COMM_LEN);
> >  }
> >  
> > -static void hist_trigger_elt_comm_free(struct tracing_map_elt *elt)
> > +static void hist_elt_data_free(struct hist_elt_data *elt_data)
> > +{
> > +	kfree(elt_data->comm);
> > +	kfree(elt_data);
> > +}
> > +
> > +static void hist_trigger_elt_data_free(struct tracing_map_elt *elt)
> >  {
> > -	kfree((char *)elt->private_data);
> > +	struct hist_elt_data *elt_data = elt->private_data;
> > +
> > +	hist_elt_data_free(elt_data);
> >  }
> >  
> > -static int hist_trigger_elt_comm_alloc(struct tracing_map_elt *elt)
> > +static int hist_trigger_elt_data_alloc(struct tracing_map_elt *elt)
> >  {
> >  	struct hist_trigger_data *hist_data = elt->map->private_data;
> > +	unsigned int size = TASK_COMM_LEN + 1;
> 
> AFAIK you don't need to do '+ 1' since task->comm is always terminated
> by a NUL character using strlcpy().
> 

Good point, will change.

Thanks,

Tom
