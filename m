From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 0/3] A few hist trigger fixes
Date: Thu, 26 Apr 2018 21:40:29 -0400
Message-ID: <20180426214029.6d36fa7a@gandalf.local.home>
References: <cover.1524790601.git.tom.zanussi@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, julia@ni.com, fengguang.wu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1524790601.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 26 Apr 2018 20:04:46 -0500
Tom Zanussi <tom.zanussi@linux.intel.com> wrote:

> Hi Steve,
> 
> Here are a few patches that fix some problems found when testing the
> hist trigger inter-event (e.g. latency) support patches.
> 
> The first fixes a problem I noticed when printing flags.
> 
> The remaining two add some hist_err() calls for fields, the first
> reported by Masami, the second something I noticed when fixing the
> first.
> 

They look good and I queued them up.

Thanks!

-- Steve
