From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 15/18] tracing: Add string type for dynamic strings in
 function based events
Date: Thu, 8 Feb 2018 22:31:53 -0500
Message-ID: <20180208223153.3bc3c87d@vmware.local.home>
References: <20180202230458.840252014@goodmis.org>
        <20180202231019.285051395@goodmis.org>
        <20180209031547.GD28206@sejong>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        linux-rt-users@vger.kernel.org, linux-trace-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        kernel-team@lge.com
To: Namhyung Kim <namhyung@kernel.org>
Return-path: <linux-trace-users-owner@vger.kernel.org>
In-Reply-To: <20180209031547.GD28206@sejong>
Sender: linux-trace-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 9 Feb 2018 12:15:47 +0900
Namhyung Kim <namhyung@kernel.org> wrote:

> > @@ -124,6 +128,16 @@ enum {
> >  	FUNC_TYPE_MAX
> >  };
> >  
> > +#define MAX_STR		512
> > +
> > +/* Two contexts, normal and NMI, hence the " * 2" */
> > +struct func_string {
> > +	char		buf[MAX_STR * 2];
> > +};
> > +
> > +static struct func_string __percpu *str_buffer;
> > +static int nr_strings;  
> 
> What protects it?

Grumble, I was thinking that the entire create_function_event was under
the func_event_mutex, which it is not. So nr_strings is not fully
protected. I'll fix that thanks.

As for str_buffer, I should comment this as it is rather subtle.


+static int read_string(char *str, unsigned long addr)
+{
+	unsigned long flags;
+	struct func_string *strbuf;
+	char *ptr = (void *)addr;
+	char *buf;
+	int ret;
+
+	if (!str_buffer)
+		return 0;
+
+	strbuf = this_cpu_ptr(str_buffer);
+	buf = &strbuf->buf[0];
+
+	if (in_nmi())
+		buf += MAX_STR;
+
+	local_irq_save(flags);

Like I said, this is really subtle, and desperately needs a comment.

The str_buffer is per cpu and can only be access under irqs disabled.
If we are in NMI, then we move the starting position forward by MAX_STR.

I'll add comments and protect create_function_event with the mutex.

Thanks for pointing this out!

-- Steve


+	ret = strncpy_from_unsafe(buf, ptr, MAX_STR);
+	if (ret < 0)
+		ret = 0;
+	if (ret > 0 && str)
+		memcpy(str, buf, ret);
+	local_irq_restore(flags);
+
+	return ret;
+}
