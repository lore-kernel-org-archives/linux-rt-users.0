From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v5 15/37] tracing: Add variable support to hist triggers
Date: Fri, 10 Nov 2017 10:26:24 -0600
Message-ID: <1510331184.9878.5.camel@tzanussi-mobl.amr.corp.intel.com>
References: <cover.1510252666.git.tom.zanussi@linux.intel.com>
         <d9fc474596939557a4db9adb92eec65bd2283131.1510252666.git.tom.zanussi@linux.intel.com>
         <20171110072841.GB1544@danjae.aot.lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, kernel-team@lge.com
To: Namhyung Kim <namhyung@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171110072841.GB1544@danjae.aot.lge.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Namhyung,

On Fri, 2017-11-10 at 16:28 +0900, Namhyung Kim wrote:
> Hi Tom,
> 
> On Thu, Nov 09, 2017 at 02:33:46PM -0600, Tom Zanussi wrote:
> > Add support for saving the value of a current event's event field by
> > assigning it to a variable that can be read by a subsequent event.
> > 
> > The basic syntax for saving a variable is to simply prefix a unique
> > variable name not corresponding to any keyword along with an '=' sign
> > to any event field.
> > 
> > Both keys and values can be saved and retrieved in this way:
> > 
> >     # echo 'hist:keys=next_pid:vals=$ts0:ts0=$common_timestamp ...
> >     # echo 'hist:timer_pid=common_pid:key=$timer_pid ...'
> > 
> > If a variable isn't a key variable or prefixed with 'vals=', the
> > associated event field will be saved in a variable but won't be summed
> > as a value:
> > 
> >     # echo 'hist:keys=next_pid:ts1=$common_timestamp:...
> > 
> > Multiple variables can be assigned at the same time:
> > 
> >     # echo 'hist:keys=pid:vals=$ts0,$b,field2:ts0=$common_timestamp,b=field1 ...
> > 
> > Multiple (or single) variables can also be assigned at the same time
> > using separate assignments:
> > 
> >     # echo 'hist:keys=pid:vals=$ts0:ts0=$common_timestamp:b=field1:c=field2 ...
> > 
> > Variables set as above can be used by being referenced from another
> > event, as described in a subsequent patch.
> > 
> > Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> > Signed-off-by: Baohong Liu <baohong.liu@intel.com>
> > ---
> 
> [SNIP]
> > +static int parse_var_defs(struct hist_trigger_data *hist_data)
> > +{
> > +	char *s, *str, *var_name, *field_str;
> > +	unsigned int i, j, n_vars = 0;
> > +	int ret = 0;
> > +
> > +	for (i = 0; i < hist_data->attrs->n_assignments; i++) {
> > +		str = hist_data->attrs->assignment_str[i];
> > +		for (j = 0; j < TRACING_MAP_VARS_MAX; j++) {
> > +			field_str = strsep(&str, ",");
> > +			if (!field_str)
> > +				break;
> > +
> > +			var_name = strsep(&field_str, "=");
> > +			if (!var_name || !field_str) {
> > +				ret = -EINVAL;
> > +				goto free;
> > +			}
> > +
> > +			s = kstrdup(var_name, GFP_KERNEL);
> > +			if (!s) {
> > +				ret = -ENOMEM;
> > +				goto free;
> > +			}
> > +			hist_data->attrs->var_defs.name[n_vars] = s;
> > +
> > +			s = kstrdup(field_str, GFP_KERNEL);
> > +			if (!s) {
> > +				kfree(hist_data->attrs->var_defs.name[n_vars]);
> > +				ret = -ENOMEM;
> > +				goto free;
> > +			}
> > +			hist_data->attrs->var_defs.expr[n_vars++] = s;
> > +
> > +			hist_data->attrs->var_defs.n_vars = n_vars;
> > +
> > +			if (n_vars == TRACING_MAP_VARS_MAX)
> > +				goto free;
> 
> This will silently discard all variables.  Why not returning an error?
> Also I think it should be moved to the beginning of this block..
> 

Yes, thanks for pointing this out.

This should fix it, will merge into the appropriate patches in the next
version...

Tom


From: Tom Zanussi <tom.zanussi@linux.intel.com>
Date: Fri, 10 Nov 2017 09:01:21 -0600
Subject: [PATCH] tracing: Fix parse_var_defs max case

Fix the VARS_MAX case and add an error condition for it.

Merge into variable support and 'last err' patches.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 4d1b636..1ea9304 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -4050,6 +4050,12 @@ static int parse_var_defs(struct hist_trigger_data *hist_data)
 				goto free;
 			}
 
+			if (n_vars == TRACING_MAP_VARS_MAX) {
+				hist_err("Too many variables defined: ", var_name);
+				ret = -EINVAL;
+				goto free;
+			}
+
 			s = kstrdup(var_name, GFP_KERNEL);
 			if (!s) {
 				ret = -ENOMEM;
@@ -4066,9 +4072,6 @@ static int parse_var_defs(struct hist_trigger_data *hist_data)
 			hist_data->attrs->var_defs.expr[n_vars++] = s;
 
 			hist_data->attrs->var_defs.n_vars = n_vars;
-
-			if (n_vars == TRACING_MAP_VARS_MAX)
-				goto free;
 		}
 	}
 
-- 
2.7.4
