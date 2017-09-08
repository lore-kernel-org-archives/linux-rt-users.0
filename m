From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 34/40] tracing: Add 'last error' error facility for
 hist triggers
Date: Fri, 8 Sep 2017 15:25:14 -0400
Message-ID: <20170908152514.70d50052@gandalf.local.home>
References: <cover.1504642143.git.tom.zanussi@linux.intel.com>
        <89e851e663a2322cbe1d952d6e7695dacfed8a96.1504642143.git.tom.zanussi@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <89e851e663a2322cbe1d952d6e7695dacfed8a96.1504642143.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue,  5 Sep 2017 16:57:46 -0500
Tom Zanussi <tom.zanussi@linux.intel.com> wrote:

> +static char *hist_err_str;
> +static char *last_hist_cmd;
> +
> +static int hist_err_alloc(void)
> +{
> +	int ret = 0;
> +
> +	last_hist_cmd = kzalloc(MAX_FILTER_STR_VAL, GFP_KERNEL);
> +	if (!last_hist_cmd)
> +		return -ENOMEM;
> +
> +	hist_err_str = kzalloc(MAX_FILTER_STR_VAL, GFP_KERNEL);
> +	if (!hist_err_str) {
> +		kfree(last_hist_cmd);
> +		ret = -ENOMEM;
> +	}

This gets allocated during boot up. Why have it be allocated in the
first place? Just have it be strings:

static char hist_err_str[MAX_FILTER_STR_VAL];
static char last_hist_cmd[MAX_FILTER_STR_VAL];

You are not saving any space by doing it this way. In fact, you waste
it because now you need to add the pointers to the strings.

> +
> +	return ret;
> +}
> +
> +static void last_cmd_set(char *str)
> +{
> +	if (!last_hist_cmd || !str)
> +		return;
> +
> +	if (strlen(str) > MAX_FILTER_STR_VAL - 1)
> +		return;

Instead of returning nothing, why not just truncate it?

> +
> +	strcpy(last_hist_cmd, str);

	strncpy(last_hist_cmd, str, MAX_FILTER_STR_VAL - 1);
	last_hist_cmd[MAX_FILTER_STR_VAL - 1] = 0;

> +}
> +
> +static void hist_err(char *str, char *var)
> +{
> +	int maxlen = MAX_FILTER_STR_VAL - 1;
> +
> +	if (!hist_err_str || !str)
> +		return;
> +
> +	if (strlen(hist_err_str))
> +		return;
> +
> +	if (!var)
> +		var = "";
> +
> +	if (strlen(hist_err_str) + strlen(str) + strlen(var) > maxlen)
> +		return;
> +
> +	strcat(hist_err_str, str);
> +	strcat(hist_err_str, var);
> +}
> +
> +static void hist_err_event(char *str, char *system, char *event, char *var)
> +{
> +	char err[MAX_FILTER_STR_VAL];
> +
> +	if (system && var)
> +		sprintf(err, "%s.%s.%s", system, event, var);
> +	else if (system)
> +		sprintf(err, "%s.%s", system, event);
> +	else
> +		strcpy(err, var);

Use snprintf() and strncpy() for the above.

-- Steve

> +
> +	hist_err(str, err);
> +}
> +
> +static void hist_err_clear(void)
> +{
> +	if (!hist_err_str)
> +		return;
> +
> +	hist_err_str[0] = '\0';
> +}
> +
> +static bool have_hist_err(void)
> +{
> +	if (hist_err_str && strlen(hist_err_str))
> +		return true;
> +
> +	return false;
> +}
> +
