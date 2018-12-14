From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v8 10/22] tracing: Add hist trigger onchange() handler
Date: Sat, 15 Dec 2018 01:09:36 +0900
Message-ID: <20181215010936.ac9ae50716be12c332f30d58@kernel.org>
References: <cover.1544483272.git.tom.zanussi@linux.intel.com>
        <033a34023c6ef2a64adba8fd0a6c00061873f80c.1544483273.git.tom.zanussi@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        namhyung@kernel.org, vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
To: Tom Zanussi <zanussi@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <033a34023c6ef2a64adba8fd0a6c00061873f80c.1544483273.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Tom,

Just a nitpick.

On Mon, 10 Dec 2018 18:01:24 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

>  enum action_id {
> @@ -1961,7 +1962,8 @@ static int parse_action(char *str, struct hist_trigger_attrs *attrs)
>  		return ret;
>  
>  	if ((strncmp(str, "onmatch(", strlen("onmatch(")) == 0) ||
> -	    (strncmp(str, "onmax(", strlen("onmax(")) == 0)) {
> +	    (strncmp(str, "onmax(", strlen("onmax(")) == 0) ||
> +	    (strncmp(str, "onchange(", strlen("onchange(")) == 0)) {

You can use sizeof() instead of strlen() for static string.

[...]
> @@ -4740,6 +4767,15 @@ static int parse_actions(struct hist_trigger_data *hist_data)
>  				ret = PTR_ERR(data);
>  				break;
>  			}
> +		} else if (strncmp(str, "onchange(", strlen("onchange(")) == 0) {
> +			char *action_str = str + strlen("onchange(");

Ditto.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
