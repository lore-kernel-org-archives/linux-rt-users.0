From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [RFC][PATCH 13/21] tracing: Add simple expression support to
 hist triggers
Date: Tue, 14 Feb 2017 09:29:26 -0600
Message-ID: <1487086166.1208.12.camel@tzanussi-mobl.amr.corp.intel.com>
References: <cover.1486569306.git.tom.zanussi@linux.intel.com>
         <0ec36d09fff75cfa8fe241b2e3026400cf22880f.1486569306.git.tom.zanussi@linux.intel.com>
         <20170214023726.GM14705@sejong>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Namhyung Kim <namhyung@kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:49155 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932122AbdBNP3r (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 14 Feb 2017 10:29:47 -0500
In-Reply-To: <20170214023726.GM14705@sejong>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Namhyung,

On Tue, 2017-02-14 at 11:37 +0900, Namhyung Kim wrote:
> On Wed, Feb 08, 2017 at 11:25:09AM -0600, Tom Zanussi wrote:
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
> > +static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
> > +				     struct trace_event_file *file,
> > +				     char *str, unsigned long flags,
> > +				     char *var_name);
> > +
> > +static struct hist_field *parse_unary(struct hist_trigger_data *hist_data,
> > +				      struct trace_event_file *file,
> > +				      char *str, unsigned long flags,
> > +				      char *var_name)
> > +{
> > +	struct hist_field *operand1, *expr = NULL;
> > +	struct ftrace_event_field *field = NULL;
> > +	unsigned long operand_flags;
> > +	char *operand1_str;
> > +	int ret = 0;
> > +	char *s;
> > +
> > +	// we support only -(xxx) i.e. explicit parens required
> > +
> > +	str++; // skip leading '-'
> > +
> > +	s = strchr(str, '(');
> > +	if (s)
> > +		str++;
> > +	else {
> > +		ret = -EINVAL;
> > +		goto free;
> > +	}
> > +
> > +	s = strchr(str, ')');
> > +	if (s)
> > +		*s = '\0';
> > +	else {
> > +		ret = -EINVAL; // no closing ')'
> > +		goto free;
> > +	}
> > +
> > +	operand1_str = strsep(&str, "(");
> > +	if (!operand1_str)
> > +		goto free;
> > +
> > +	flags |= HIST_FIELD_FL_EXPR;
> > +	expr = create_hist_field(NULL, flags, var_name);
> > +	if (!expr) {
> > +		ret = -ENOMEM;
> > +		goto free;
> > +	}
> > +
> > +	operand_flags = 0;
> > +	operand1 = parse_expr(hist_data, file, str, operand_flags, NULL);
> 
> Doesn't it create an unbounded recursion?
> 

Yeah, Steve asked the same thing about some similar code - I'll either
get rid of the recursion or make sure it's unbounded.

Thanks,

Tom


