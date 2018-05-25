From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 13/14] tracing/selftest: Add selftests to test
 trace_marker histogram triggers
Date: Fri, 25 May 2018 17:13:53 -0400
Message-ID: <20180525171353.53b44f5e@gandalf.local.home>
References: <20180516150012.135869655@goodmis.org>
        <20180516150201.246539183@goodmis.org>
        <20180523231331.bf69453f05478e11b00451ab@kernel.org>
        <20180525140731.07d7543a@gandalf.local.home>
        <20180525171229.76bae7a8@gandalf.local.home>
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
        Joel Fernandes <joel@joelfernandes.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Yann Ylavic <ylavic.dev@gmail.com>,
        linux-rt-users@vger.kernel.org, Shuah Khan <shuahkhan@gmail.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180525171229.76bae7a8@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 25 May 2018 17:12:29 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

 
> #!/bin/sh

Hmm, I think I need to make this #!/bin/bash

> test_trace() {
>     file=$1
>     x=$2
> 
>     cat $file | while read line; do
> 	if [ "$line" != "${line/\#/}" ]; then
> 	    continue
> 	fi
> 	echo "testing $line for >$x<"
> 	if [ "$line" == "${line/>$x</}" ]; then

The ${line/>$x</} is unique to bash I believe.

-- Steve

> 	    fail "$line does not have >$x< in it"
> 	fi
> 	let x=$x+2
>     done
> }
> 
