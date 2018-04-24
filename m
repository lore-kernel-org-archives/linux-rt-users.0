From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH 0/2] selftests: tracing: Update inter-event testcases
Date: Tue, 24 Apr 2018 17:24:40 -0500
Message-ID: <1524608680.26220.4.camel@tzanussi-mobl.amr.corp.intel.com>
References: <152292049091.15769.13306554953968999494.stgit@devbox>
         <20180424152221.7049b706@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Masami Hiramatsu <mhiramat@kernel.org>, tglx@linutronix.de,
        namhyung@kernel.org, vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, julia@ni.com, fengguang.wu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180424152221.7049b706@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2018-04-24 at 15:22 -0400, Steven Rostedt wrote:
> On Thu,  5 Apr 2018 18:28:11 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Hi,
> > 
> > I've fixed a testcase for inter-event extended error
> > and added a testcase for multiple actions on trigger,
> > which is based on what Tom shown in his mail.
> > 
> > This series can be applied on Steven's tracing repo.
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace
> > ftrace/core
> > 
> > Tom, could you review it?
> 
> Even without Tom's review. I took both patches.
> 

Oops, sorry, completely forgot about these.. 

For both patches:

Reviewed-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Tested-by: Tom Zanussi <tom.zanussi@linux.intel.com>

Thanks,

Tom

> Thanks Masami!
> 
> -- Steve
