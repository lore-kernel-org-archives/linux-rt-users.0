From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/7] tracing: Change strlen to sizeof for hist trigger
 static strings
Date: Wed, 19 Dec 2018 16:03:17 -0500
Message-ID: <20181219160317.71c3e3ff@gandalf.local.home>
References: <cover.1545161087.git.tom.zanussi@linux.intel.com>
        <e3e754f2bd18e56eaa8baf79bee619316ebf4cfc.1545161087.git.tom.zanussi@linux.intel.com>
        <20181219144047.49fabfa6@gandalf.local.home>
        <1545248809.2396.2.camel@kernel.org>
        <1545250591.4161.2.camel@kernel.org>
        <af216c227fa3ec310d8c4271485dd6c7f829174f.camel@perches.com>
        <20181219153447.3684100d@gandalf.local.home>
        <426609d1a7c8217187f18011add87ca4fdd54f1e.camel@perches.com>
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
In-Reply-To: <426609d1a7c8217187f18011add87ca4fdd54f1e.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 19 Dec 2018 12:51:59 -0800
Joe Perches <joe@perches.com> wrote:


> > #define strncmp_prefix(str, prefix) \
> > 	strncmp(str, prefix, strlen(prefix))
> > 
> > in include/linux/string.h
> > 
> > And go around and use that throughout the kernel. By doing a quick
> > grep, I already spotted a few bugs.  
> 
> I hope you also convert the existing uses like
> 
> 	strncmp(str1, "str2", 4)
> 
> where the length value is precalculated to the strlen
> of the const string

Yeah sure.

> 
> But there seem to be _a lot_ of those...
> 
> $ git grep -P "\bstrncmp\s*\([^,]+,[^,]+,\s*\d+\s*\)" | wc -l
> 1681
> 

Right.

I'm going to first create the macro and probably just apply it to the
tracing directory. Then when the macro is added to the next merge
window, I'll post a bunch of patches that clean up the rest of the code.

-- Steve
