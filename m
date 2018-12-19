From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/7] tracing: Change strlen to sizeof for hist trigger
 static strings
Date: Wed, 19 Dec 2018 15:34:47 -0500
Message-ID: <20181219153447.3684100d@gandalf.local.home>
References: <cover.1545161087.git.tom.zanussi@linux.intel.com>
        <e3e754f2bd18e56eaa8baf79bee619316ebf4cfc.1545161087.git.tom.zanussi@linux.intel.com>
        <20181219144047.49fabfa6@gandalf.local.home>
        <1545248809.2396.2.camel@kernel.org>
        <1545250591.4161.2.camel@kernel.org>
        <af216c227fa3ec310d8c4271485dd6c7f829174f.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Tom Zanussi <zanussi@kernel.org>, tglx@linutronix.de,
        mhiramat@kernel.org, namhyung@kernel.org, vedang.patel@intel.com,
        bigeasy@linutronix.de, joel@joelfernandes.org,
        mathieu.desnoyers@efficios.com, julia@ni.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Joe Perches <joe@perches.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <af216c227fa3ec310d8c4271485dd6c7f829174f.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 19 Dec 2018 12:22:38 -0800
Joe Perches <joe@perches.com> wrote:

> On Wed, 2018-12-19 at 14:16 -0600, Tom Zanussi wrote:
> > 
> > How's this?
> > 
> > [PATCH] tracing: Introduce and use strcmp_const() for hist triggers
> > 
> > Provide a new strcmp_const() macro and make use of it instead of the
> > longer and more error-prone strncmp(str, "str", sizeof("str") - 1).  
> []
> > diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c  
> []
> > @@ -22,6 +22,9 @@
> >  
> >  #define STR_VAR_LEN_MAX		32 /* must be multiple of sizeof(u64) */
> >  
> > +#define strcmp_const(str, str_const) \
> > +	strncmp(str, str_const, sizeof(str_const) - 1)  
> 
> Not good as it's too easy to pass a pointer as str_const
> and sizeof(pointer) - 1 isn't likely the string length.

Agreed. And I noticed that this is used all over the kernel, so I'm not
going to add this patch. I'm going to add a:

#define strncmp_prefix(str, prefix) \
	strncmp(str, prefix, strlen(prefix))

in include/linux/string.h

And go around and use that throughout the kernel. By doing a quick
grep, I already spotted a few bugs.

-- Steve
