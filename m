From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 17/18] tracing: Add indirect to indirect access for
 function based events
Date: Fri, 9 Feb 2018 12:18:40 -0500
Message-ID: <20180209121840.5f96d400@gandalf.local.home>
References: <20180202230458.840252014@goodmis.org>
        <20180202231019.582037880@goodmis.org>
        <20180209051301.GE28206@sejong>
        <20180209104758.093d31ad@gandalf.local.home>
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
In-Reply-To: <20180209104758.093d31ad@gandalf.local.home>
Sender: linux-trace-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 9 Feb 2018 10:47:58 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> Good catch!
> 
> It should have been:
> 
> 		return process_redirects(arg, val, buf);

Although I need to add this :-p

diff --git a/kernel/trace/trace_event_ftrace.c b/kernel/trace/trace_event_ftrace.c
index 673336e352be..2690d4e46322 100644
--- a/kernel/trace/trace_event_ftrace.c
+++ b/kernel/trace/trace_event_ftrace.c
@@ -562,7 +564,7 @@ process_event(struct func_event *fevent, const char *token, enum func_states sta
                ret = add_arg_redirect(fevent->last_arg, val, 0);
                if (ret)
                        break;
-               return FUNC_STATE_VAR;
+               return FUNC_STATE_BRACKET_END;
 
        case FUNC_STATE_REDIRECT_BRACKET:
                if (WARN_ON(!fevent->last_arg))
@@ -656,6 +658,7 @@ static unsigned long process_redirects(struct func_arg *arg, unsigned long val,
                        ret = probe_kernel_read(buf, (void *)val, sizeof(long));
                        if (ret)
                                return 0;
+                       val = *(unsigned long *)buf;
                }
        }
        return val;

Because it wasn't parsing properly, and then not getting the redirect.

-- Steve
