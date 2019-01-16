From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v12 01/16] tracing: Use str_has_prefix() in
 synth_event_create()
Date: Tue, 15 Jan 2019 20:59:16 -0800
Message-ID: <7c07519607d08c0afe448a03fb2010bce13cd77f.camel@perches.com>
References: <cover.1547589128.git.tom.zanussi@linux.intel.com>
         <aa6e33335e1ff99c7ac3d00fa5e27faaad04f981.1547589128.git.tom.zanussi@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
To: Tom Zanussi <zanussi@kernel.org>, rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <aa6e33335e1ff99c7ac3d00fa5e27faaad04f981.1547589128.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2019-01-15 at 16:05 -0600, Tom Zanussi wrote:
> Since we now have a str_has_prefix() that returns the length, we can
> use that instead of explicitly calculating it.
[]
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
[]
> @@ -1200,8 +1200,7 @@ static int synth_event_create(int argc, const char **argv)
>  
>  	/* This interface accepts group name prefix */
>  	if (strchr(name, '/')) {
> -		len = sizeof(SYNTH_SYSTEM "/") - 1;
> -		if (strncmp(name, SYNTH_SYSTEM "/", len))
> +		if ((len = str_has_prefix(name, SYNTH_SYSTEM "/")) == 0)

Since this is a single test, and not multiple if/else if
blocks, I believe this would read better on two lines

		len = str_has_prefix(name, SYNTH_SYSTEM "/");
		if (len == 0)

>  			return -EINVAL;
>  		name += len;
>  	}
