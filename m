From: Tom Zanussi <zanussi@kernel.org>
Subject: Re: [RFC PATCH v2 4/5] tracing: Use tracing error_log with kprobe
 events (incomplete)
Date: Thu, 14 Feb 2019 09:16:46 -0600
Message-ID: <1550157406.2498.4.camel@kernel.org>
References: <cover.1550074795.git.tom.zanussi@linux.intel.com>
         <db931dea3818fb79a710f7b83cb53b06cf565de1.1550074795.git.tom.zanussi@linux.intel.com>
         <20190214121359.fff5e00e036fec5bfe39351e@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, tglx@linutronix.de, namhyung@kernel.org,
        bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Masami Hiramatsu <mhiramat@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190214121359.fff5e00e036fec5bfe39351e@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Masami,

On Thu, 2019-02-14 at 12:13 +0900, Masami Hiramatsu wrote:
> Hi Tom,
> 
> On Wed, 13 Feb 2019 12:17:55 -0600
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > 
> > Here are a few examples of replacing kprobe_events error handling
> > with
> > tracing_log_err() from the new tracing error_log mechanism.  Only a
> > few example errors are converted, and even these are incomplete,
> > since
> > I didn't know where to get the current command and used a dummy
> > string
> > for those.  Also, these are completely untested, just provided for
> > RFC purposes.
> 
> OK, can I take this over? I would like to try to use this framework.
> 

Sure, be my guest. ;-)

Thanks,

Tom
