From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 00/32]  tracing: Inter-event (e.g. latency) support
Date: Tue, 27 Jun 2017 10:58:10 -0400
Message-ID: <20170627105810.3c3b89d0@gandalf.local.home>
References: <cover.1498510759.git.tom.zanussi@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1498510759.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 26 Jun 2017 17:49:00 -0500
Tom Zanussi <tom.zanussi@linux.intel.com> wrote:

> This patchset adds support for 'inter-event' quantities to the trace
> event subsystem.  The most important example of inter-event quantities
> are latencies, or the time differences between two events.
>

Hi Tom,

Thanks for sending this out. I'm going to try to find some time this
week to take a look at it. It's quite a lot to go over. I don't think
it will be ready for this merge window, as I don't like rushing things
like this, and we are already at rc7. But I want to get this in by 4.14.

-- Steve
