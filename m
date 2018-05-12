From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH 07/10] tracing: Have zero size length in filter
 logic be full string
Date: Sat, 12 May 2018 13:27:32 -0400
Message-ID: <20180512132732.792468da@gandalf.local.home>
References: <20180511194927.190877137@goodmis.org>
        <20180511195341.034688188@goodmis.org>
        <20180512214029.8610c88ecc3de94a95822189@kernel.org>
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
        Namhyung Kim <namhyung@kernel.org>,
        linux-rt-users@vger.kernel.org
To: Masami Hiramatsu <mhiramat@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180512214029.8610c88ecc3de94a95822189@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sat, 12 May 2018 21:40:29 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:


> >  static int regex_match_full(char *str, struct regex *r, int len)
> >  {
> > -	if (strncmp(str, r->pattern, len) == 0)
> > -		return 1;
> > -	return 0;
> > +	/* len means str is dynamic and ends with '\0' */  
>            ^^^
>           !len (or len == 0)?
> 
> Thank you,
> 

Yes, agreed. Thanks for the review!

-- Steve
