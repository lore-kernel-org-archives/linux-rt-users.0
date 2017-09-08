From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v2 25/40] tracing: Add support for dynamic tracepoints
Date: Fri, 08 Sep 2017 09:18:27 -0500
Message-ID: <1504880307.13310.15.camel@tzanussi-mobl.amr.corp.intel.com>
References: <cover.1504642143.git.tom.zanussi@linux.intel.com>
         <9f89af4588c84850a58edcf72d2591ba78906c30.1504642143.git.tom.zanussi@linux.intel.com>
         <20170907180226.1497e96c@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170907180226.1497e96c@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Steve,

On Thu, 2017-09-07 at 18:02 -0400, Steven Rostedt wrote:
> On Tue,  5 Sep 2017 16:57:37 -0500
> Tom Zanussi <tom.zanussi@linux.intel.com> wrote:
> 
> > The tracepoint infrastructure assumes statically-defined tracepoints
> > and uses static_keys for tracepoint enablement.  In order to define
> > tracepoints on the fly, we need to have a dynamic counterpart.
> 
> Do we?
> 
> I believe the static keys should work just fine if you don't have any
> defined static keys jumps, and they should work as a simple counter.
> 
> Could we do that instead of adding another variable to a structure that
> is defined over a thousand times? Save us 4k of memory.
> 

OK, yeah, makes sense if possible - let me look into that... 

Tom
