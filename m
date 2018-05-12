From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [RFC][PATCH 07/10] tracing: Have zero size length in filter
 logic be full string
Date: Sat, 12 May 2018 21:40:29 +0900
Message-ID: <20180512214029.8610c88ecc3de94a95822189@kernel.org>
References: <20180511194927.190877137@goodmis.org>
        <20180511195341.034688188@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Brendan Gregg <bgregg@netflix.com>,
        Joel Fernandes <joelaf@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180511195341.034688188@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 11 May 2018 15:49:34 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> As strings in trace events may not have a nul terminating character, the
> filter string compares use the defined string length for the field for the
> compares.
> 
> The trace_marker records data slightly different than do normal events. It's
> size is zero, meaning that the string is the rest of the array, and that the
> string also ends with '\0'.
> 
> If the size is zero, assume that the string is nul terminated and read the
> string in question as is.
> 
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_events_filter.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
> index 7d306b74230f..675392b9edd2 100644
> --- a/kernel/trace/trace_events_filter.c
> +++ b/kernel/trace/trace_events_filter.c
> @@ -750,31 +750,32 @@ static int filter_pred_none(struct filter_pred *pred, void *event)
>   *
>   * Note:
>   * - @str might not be NULL-terminated if it's of type DYN_STRING
> - *   or STATIC_STRING
> + *   or STATIC_STRING, unless @len is zero.
>   */
>  
>  static int regex_match_full(char *str, struct regex *r, int len)
>  {
> -	if (strncmp(str, r->pattern, len) == 0)
> -		return 1;
> -	return 0;
> +	/* len means str is dynamic and ends with '\0' */
           ^^^
          !len (or len == 0)?

Thank you,




-- 
Masami Hiramatsu <mhiramat@kernel.org>
