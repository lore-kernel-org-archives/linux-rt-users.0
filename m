From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v3 03/33] ring-buffer: Add interface for setting
 absolute time stamps
Date: Thu, 05 Oct 2017 06:34:33 -0500
Message-ID: <1507203273.29707.0.camel@tzanussi-mobl.amr.corp.intel.com>
References: <cover.1506105131.git.tom.zanussi@linux.intel.com>
         <df519705509bf3ed5fccf2a88dec2b216d19f088.1506105131.git.tom.zanussi@linux.intel.com>
         <20171004131430.6e459b0a@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171004131430.6e459b0a@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Steve,

On Wed, 2017-10-04 at 13:14 -0400, Steven Rostedt wrote:
> On Fri, 22 Sep 2017 14:59:43 -0500
> Tom Zanussi <tom.zanussi@linux.intel.com> wrote:
> 
> > +	/*
> > +	 * New timestamps may not be consistent with the previous setting.
> > +	 * Reset the buffer so that it doesn't have incomparable timestamps.
> 
> I would like to make the ring buffer robust enough to handle both. Can
> this be done?
> 

Probably - I'll take a look at doing this for V4...

Tom

> -- Steve
> 
> > +	 */
> > +	tracing_reset_online_cpus(&tr->trace_buffer);
> > +
