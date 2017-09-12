From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v2 38/40] tracing: Make tracing_set_clock() non-static
Date: Tue, 12 Sep 2017 09:18:00 -0500
Message-ID: <1505225880.1331.5.camel@tzanussi-mobl.amr.corp.intel.com>
References: <cover.1504642143.git.tom.zanussi@linux.intel.com>
         <b279a2707aaf0077577fa05596bb6d80628a7b52.1504642143.git.tom.zanussi@linux.intel.com>
         <20170912111850.8536d7986d4f0c9dfaa210fc@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, tglx@linutronix.de, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Masami Hiramatsu <mhiramat@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170912111850.8536d7986d4f0c9dfaa210fc@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2017-09-12 at 11:18 +0900, Masami Hiramatsu wrote:
> On Tue,  5 Sep 2017 16:57:50 -0500
> Tom Zanussi <tom.zanussi@linux.intel.com> wrote:
> 
> > Allow tracing code outside of trace.c to access tracing_set_clock().
> > 
> > Some applications may require a particular clock in order to function
> > properly, such as latency calculations.
> > 
> > Also, add an accessor returning the current clock string.
> 
> It seems this patch should be merged in the next patch, which
> is actual consumer of this API.
> 

Yeah, that might make more sense in this case.

Thanks,

Tom
