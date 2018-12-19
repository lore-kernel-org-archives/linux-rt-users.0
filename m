From: Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH 2/7] tracing: Change strlen to sizeof for hist trigger
 static strings
Date: Wed, 19 Dec 2018 14:16:31 -0600
Message-ID: <1545250591.4161.2.camel@kernel.org>
References: <cover.1545161087.git.tom.zanussi@linux.intel.com>
         <e3e754f2bd18e56eaa8baf79bee619316ebf4cfc.1545161087.git.tom.zanussi@linux.intel.com>
         <20181219144047.49fabfa6@gandalf.local.home>
         <1545248809.2396.2.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1545248809.2396.2.camel@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2018-12-19 at 13:46 -0600, Tom Zanussi wrote:
> Hi Steve,
> 
> On Wed, 2018-12-19 at 14:40 -0500, Steven Rostedt wrote:
> > On Tue, 18 Dec 2018 14:33:21 -0600
> > Tom Zanussi <zanussi@kernel.org> wrote:
> > 
> > > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > > 
> > > There's no need to use strlen() for static strings when the
> > > length
> > > is
> > > already known, so update trace_events_hist.c with sizeof() for
> > > those
> > > cases.
> > > 
> > > Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> > > ---
> > >  kernel/trace/trace_events_hist.c | 38 +++++++++++++++++++-------
> > > --
> > > ----------
> > >  1 file changed, 19 insertions(+), 19 deletions(-)
> > > 
> > > diff --git a/kernel/trace/trace_events_hist.c
> > > b/kernel/trace/trace_events_hist.c
> > > index d29bf8a8e1dd..25d06b3ae1f6 100644
> > > --- a/kernel/trace/trace_events_hist.c
> > > +++ b/kernel/trace/trace_events_hist.c
> > > @@ -507,7 +507,7 @@ static int synth_field_string_size(char
> > > *type)
> > >  	start = strstr(type, "char[");
> > >  	if (start == NULL)
> > >  		return -EINVAL;
> > > -	start += strlen("char[");
> > > +	start += sizeof("char[") - 1;
> > >  
> > >  	end = strchr(type, ']');
> > >  	if (!end || end < start)
> > > @@ -1843,8 +1843,8 @@ static int parse_action(char *str, struct
> > > hist_trigger_attrs *attrs)
> > >  	if (attrs->n_actions >= HIST_ACTIONS_MAX)
> > >  		return ret;
> > >  
> > > -	if ((strncmp(str, "onmatch(", strlen("onmatch(")) == 0)
> > > ||
> > > -	    (strncmp(str, "onmax(", strlen("onmax(")) == 0)) {
> > > +	if ((strncmp(str, "onmatch(", sizeof("onmatch(") - 1) ==
> > > 0) ||
> > > +	    (strncmp(str, "onmax(", sizeof("onmax(") - 1) == 0))
> > > {
> > >  		attrs->action_str[attrs->n_actions] =
> > > kstrdup(str,
> > > GFP_KERNEL);
> > >  		if (!attrs->action_str[attrs->n_actions]) {
> > >  			ret = -ENOMEM;
> > > @@ -1861,34 +1861,34 @@ static int parse_assignment(char *str,
> > > struct hist_trigger_attrs *attrs)
> > >  {
> > >  	int ret = 0;
> > >  
> > > -	if ((strncmp(str, "key=", strlen("key=")) == 0) ||
> > > -	    (strncmp(str, "keys=", strlen("keys=")) == 0)) {
> > > +	if ((strncmp(str, "key=", sizeof("key=") - 1) == 0) ||
> > > +	    (strncmp(str, "keys=", sizeof("keys=") - 1) == 0)) {
> > >  		attrs->keys_str = kstrdup(str, GFP_KERNEL);
> > 
> > I'll apply this as is, but since there's a lot of these, I wonder
> > if
> > we
> > should make a marcro for this:
> > 
> > #define strcmp_const(str, str_const) strncmp(str, str_const,
> > sizeof(str_const) - 1)
> > 
> > ?
> > 
> > This would help prevent bugs due to typos and bad cut and paste.
> > 
> 
> Yeah, I had considered it but wasn't sure it was worth it.  Since
> you're suggesting it is, I can send another patch on top of these, or
> feel free if you want to too.  ;-)
> 

How's this?

[PATCH] tracing: Introduce and use strcmp_const() for hist triggers

Provide a new strcmp_const() macro and make use of it instead of the
longer and more error-prone strncmp(str, "str", sizeof("str") - 1).

Idea-and-macro-by: Steve Rostedt <rostedt@goodmis.org>
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index c5448c103770..aaf0d2ac4aab 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -22,6 +22,9 @@
 
 #define STR_VAR_LEN_MAX		32 /* must be multiple of sizeof(u64) */
 
+#define strcmp_const(str, str_const) \
+	strncmp(str, str_const, sizeof(str_const) - 1)
+
 struct hist_field;
 
 typedef u64 (*hist_field_fn_t) (struct hist_field *field,
@@ -1881,8 +1884,8 @@ static int parse_action(char *str, struct hist_trigger_attrs *attrs)
 	if (attrs->n_actions >= HIST_ACTIONS_MAX)
 		return ret;
 
-	if ((strncmp(str, "onmatch(", sizeof("onmatch(") - 1) == 0) ||
-	    (strncmp(str, "onmax(", sizeof("onmax(") - 1) == 0)) {
+	if ((strcmp_const(str, "onmatch(") == 0) ||
+	    (strcmp_const(str, "onmax(") == 0)) {
 		attrs->action_str[attrs->n_actions] = kstrdup(str, GFP_KERNEL);
 		if (!attrs->action_str[attrs->n_actions]) {
 			ret = -ENOMEM;
@@ -1899,34 +1902,34 @@ static int parse_assignment(char *str, struct hist_trigger_attrs *attrs)
 {
 	int ret = 0;
 
-	if ((strncmp(str, "key=", sizeof("key=") - 1) == 0) ||
-	    (strncmp(str, "keys=", sizeof("keys=") - 1) == 0)) {
+	if ((strcmp_const(str, "key=") == 0) ||
+	    (strcmp_const(str, "keys=") == 0)) {
 		attrs->keys_str = kstrdup(str, GFP_KERNEL);
 		if (!attrs->keys_str) {
 			ret = -ENOMEM;
 			goto out;
 		}
-	} else if ((strncmp(str, "val=", sizeof("val=") - 1) == 0) ||
-		 (strncmp(str, "vals=", sizeof("vals=") - 1) == 0) ||
-		 (strncmp(str, "values=", sizeof("values=") - 1) == 0)) {
+	} else if ((strcmp_const(str, "val=") == 0) ||
+		 (strcmp_const(str, "vals=") == 0) ||
+		 (strcmp_const(str, "values=") == 0)) {
 		attrs->vals_str = kstrdup(str, GFP_KERNEL);
 		if (!attrs->vals_str) {
 			ret = -ENOMEM;
 			goto out;
 		}
-	} else if (strncmp(str, "sort=", sizeof("sort=") - 1) == 0) {
+	} else if (strcmp_const(str, "sort=") == 0) {
 		attrs->sort_key_str = kstrdup(str, GFP_KERNEL);
 		if (!attrs->sort_key_str) {
 			ret = -ENOMEM;
 			goto out;
 		}
-	} else if (strncmp(str, "name=", sizeof("name=") - 1) == 0) {
+	} else if (strcmp_const(str, "name=") == 0) {
 		attrs->name = kstrdup(str, GFP_KERNEL);
 		if (!attrs->name) {
 			ret = -ENOMEM;
 			goto out;
 		}
-	} else if (strncmp(str, "clock=", sizeof("clock=") - 1) == 0) {
+	} else if (strcmp_const(str, "clock=") == 0) {
 		strsep(&str, "=");
 		if (!str) {
 			ret = -EINVAL;
@@ -1939,7 +1942,7 @@ static int parse_assignment(char *str, struct hist_trigger_attrs *attrs)
 			ret = -ENOMEM;
 			goto out;
 		}
-	} else if (strncmp(str, "size=", sizeof("size=") - 1) == 0) {
+	} else if (strcmp_const(str, "size=") == 0) {
 		int map_bits = parse_map_size(str);
 
 		if (map_bits < 0) {
@@ -3558,7 +3561,7 @@ static struct action_data *onmax_parse(char *str)
 	if (!onmax_fn_name || !str)
 		goto free;
 
-	if (strncmp(onmax_fn_name, "save", sizeof("save") - 1) == 0) {
+	if (strcmp_const(onmax_fn_name, "save") == 0) {
 		char *params = strsep(&str, ")");
 
 		if (!params) {
@@ -4346,7 +4349,7 @@ static int parse_actions(struct hist_trigger_data *hist_data)
 	for (i = 0; i < hist_data->attrs->n_actions; i++) {
 		str = hist_data->attrs->action_str[i];
 
-		if (strncmp(str, "onmatch(", sizeof("onmatch(") - 1) == 0) {
+		if (strcmp_const(str, "onmatch(") == 0) {
 			char *action_str = str + sizeof("onmatch(") - 1;
 
 			data = onmatch_parse(tr, action_str);
@@ -4355,7 +4358,7 @@ static int parse_actions(struct hist_trigger_data *hist_data)
 				break;
 			}
 			data->fn = action_trace;
-		} else if (strncmp(str, "onmax(", sizeof("onmax(") - 1) == 0) {
+		} else if (strcmp_const(str, "onmax(") == 0) {
 			char *action_str = str + sizeof("onmax(") - 1;
 
 			data = onmax_parse(action_str);
-- 
2.14.1



> Tom
