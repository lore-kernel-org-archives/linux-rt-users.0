From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH 18/32] tracing: Add simple expression support to hist
 triggers
Date: Fri, 21 Jul 2017 11:29:19 -0500
Message-ID: <1500654559.21148.13.camel@tzanussi-mobl.amr.corp.intel.com>
References: <cover.1498510759.git.tom.zanussi@linux.intel.com>
         <f58c1e58b42f26a53cbc6e0ed660a6717d78acf4.1498510759.git.tom.zanussi@linux.intel.com>
         <20170721020218.GB21128@danjae.aot.lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        vedang.patel@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, kernel-team@lge.com
To: Namhyung Kim <namhyung@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170721020218.GB21128@danjae.aot.lge.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Namhyung,

On Fri, 2017-07-21 at 11:02 +0900, Namhyung Kim wrote:
> Hi Tom,
> 
> On Mon, Jun 26, 2017 at 05:49:19PM -0500, Tom Zanussi wrote:
> > Add support for simple addition, subtraction, and unary expressions
> > (-(expr) and expr, where expr = b-a, a+b, a+b+c) to hist triggers, in
> > order to support a minimal set of useful inter-event calculations.
> > 
> > These operations are needed for calculating latencies between events
> > (timestamp1-timestamp0) and for combined latencies (latencies over 3
> > or more events).
> > 
> > In the process, factor out some common code from key and value
> > parsing.
> > 
> > Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> > ---
> 
> [SNIP]
> > +static char *expr_str(struct hist_field *field, unsigned int level)
> > +{
> > +	char *expr = kzalloc(MAX_FILTER_STR_VAL, GFP_KERNEL);
> > +
> > +	if (!expr || level > 1)
> > +		return NULL;
> 
> Looks like a memory leak.
> 
> 

Indeed, and so obvious I can't believe I missed it.  Thanks for pointing
it out.

> [SNIP]
> > +static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
> > +				     struct trace_event_file *file,
> > +				     char *str, unsigned long flags,
> > +				     char *var_name, unsigned int level)
> > +{
> > +	struct hist_field *operand1 = NULL, *operand2 = NULL, *expr = NULL;
> > +	unsigned long operand_flags;
> > +	int field_op, ret = -EINVAL;
> > +	char *sep, *operand1_str;
> > +
> > +	if (level > 2)
> > +		return NULL;
> > +
> > +	field_op = contains_operator(str);
> > +	if (field_op == FIELD_OP_NONE)
> > +		return NULL;
> 
> Why not calling parse_atom() here?  It'd make the code simpler IMHO.
> 

Yeah, I think that would be much nicer, will do.

Thanks,

Tom
