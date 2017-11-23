From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v6 31/37] tracing: Add 'last error' error facility for
 hist triggers
Date: Thu, 23 Nov 2017 15:22:25 +0900
Message-ID: <20171123062225.GC25472@sejong>
References: <cover.1510948725.git.tom.zanussi@linux.intel.com>
 <a8005b6ceb8d5d9aa50fe9b4f8b5d88c75414d0a.1510948725.git.tom.zanussi@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, julia@ni.com, fengguang.wu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        kernel-team@lge.com
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from LGEAMRELO11.lge.com ([156.147.23.51]:53156 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752563AbdKWGWd (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 23 Nov 2017 01:22:33 -0500
Content-Disposition: inline
In-Reply-To: <a8005b6ceb8d5d9aa50fe9b4f8b5d88c75414d0a.1510948725.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Nov 17, 2017 at 02:33:10PM -0600, Tom Zanussi wrote:
> With the addition of variables and actions, it's become necessary to
> provide more detailed error information to users about syntax errors.
> 
> Add a 'last error' facility accessible via the erroring event's 'hist'
> file.  Reading the hist file after an error will display more detailed
> information about what went wrong, if information is available.  This
> extended error information will be available until the next hist
> trigger command for that event.
> 
>   # echo xxx > /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
>   echo: write error: Invalid argument
> 
>   # cat /sys/kernel/debug/tracing/events/sched/sched_wakeup/hist
> 
>   ERROR: Couldn't yyy: zzz
>   Last command: xxx
> 
> Also add specific error messages for variable and action errors.
> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---
> @@ -2271,9 +2333,18 @@ static struct hist_field *create_var_ref(struct hist_field *var_field,
>  	return ref_field;
>  }
>  
> +static bool is_common_field(char *var_name)
> +{
> +	if (strncmp(var_name, "$common_timestamp", strlen("$common_timestamp")) == 0)
> +		return true;
> +
> +	return false;
> +}
> +
>  static bool is_var_ref(char *var_name)
>  {
> -	if (!var_name || strlen(var_name) < 2 || var_name[0] != '$')
> +	if (!var_name || strlen(var_name) < 2 || var_name[0] != '$' ||
> +	    is_common_field(var_name))

Looks like it's not a part of this change.

Thanks,
Namhyung


>  		return false;
>  
>  	return true;
