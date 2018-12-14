From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v8 03/22] tracing: Add hist trigger handler.action
 documentation to README
Date: Fri, 14 Dec 2018 22:11:21 +0900
Message-ID: <20181214221121.6e3d56b7ada3b5fed6124d28@kernel.org>
References: <cover.1544483272.git.tom.zanussi@linux.intel.com>
        <aed0a478f683ac4a7669c62d72e8a01d975e525b.1544483272.git.tom.zanussi@linux.intel.com>
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
In-Reply-To: <aed0a478f683ac4a7669c62d72e8a01d975e525b.1544483272.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Tom,

On Mon, 10 Dec 2018 18:01:17 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> From: Tom Zanussi <tom.zanussi@linux.intel.com>
> 
> Add abbreviated documentation for handlers and actions to README.

This change itself is good to me, and I would rather like to see this
in the patch which does actual change, since user (or test code) may
check this to decide whether the kernel supports this feature or not.

If we separate this from the change, the test code may fail when bisecting.

Thank you,

> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---
>  kernel/trace/trace.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 911470ad9e94..1abde13a7eab 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -4698,6 +4698,7 @@ static const char readme_msg[] =
>  	"\t            [:size=#entries]\n"
>  	"\t            [:pause][:continue][:clear]\n"
>  	"\t            [:name=histname1]\n"
> +	"\t            [:<handler>.<action>]\n"
>  	"\t            [if <filter>]\n\n"
>  	"\t    When a matching event is hit, an entry is added to a hash\n"
>  	"\t    table using the key(s) and value(s) named, and the value of a\n"
> @@ -4739,7 +4740,16 @@ static const char readme_msg[] =
>  	"\t    The enable_hist and disable_hist triggers can be used to\n"
>  	"\t    have one event conditionally start and stop another event's\n"
>  	"\t    already-attached hist trigger.  The syntax is analagous to\n"
> -	"\t    the enable_event and disable_event triggers.\n"
> +	"\t    the enable_event and disable_event triggers.\n\n"
> +	"\t    Hist trigger handlers and actions are executed whenever a\n"
> +	"\t    a histogram entry is added or updated.  They take the form:\n\n"
> +	"\t        <handler>.<action>\n\n"
> +	"\t    The available handlers are:\n\n"
> +	"\t        onmatch(matching.event)  - invoke on addition or update\n"
> +	"\t        onmax(var)               - invoke if var exceeds current max\n\n"
> +	"\t    The available actions are:\n\n"
> +	"\t        <synthetic_event>(param list)        - generate synthetic event\n"
> +	"\t        save(field,...)                      - save current event fields\n"
>  #endif
>  ;
>  
> -- 
> 2.14.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
