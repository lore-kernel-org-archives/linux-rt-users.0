From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 3/4] tracing: Add action comparisons when testing
 matching hist triggers
Date: Wed, 4 Apr 2018 09:01:34 -0400
Message-ID: <20180404090134.4db3de17@gandalf.local.home>
References: <cover.1522256721.git.tom.zanussi@linux.intel.com>
        <a7fd668b87ec10736c8f016ac4279c8480d50c2b.1522256721.git.tom.zanussi@linux.intel.com>
        <20180403001025.6dfed9403d50d20104e54458@kernel.org>
        <1522688973.3254.8.camel@tzanussi-mobl.amr.corp.intel.com>
        <20180404213338.5bcd14994d8e0142b5bfefc6@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>, tglx@linutronix.de,
        namhyung@kernel.org, vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, julia@ni.com, fengguang.wu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Masami Hiramatsu <mhiramat@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180404213338.5bcd14994d8e0142b5bfefc6@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 4 Apr 2018 21:33:38 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hmm, how can I undef ts0 and test it again?
> If I can not clean it, the testcase must fail on the 2nd time.

Tom,

I already pulled in your patches and almost completed my tests (which
obviously are not stress testing this code).

Any fixes you make to address Masami's concerns, can you please make as
separate patches on top of this. You can see my current tree that I'm
testing and base on top of that one.

 git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
 branch: ftrace/core

(Note, that can rebase, but mostly to add acks)

Thanks!

-- Steve
