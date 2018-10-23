From: Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH v6 07/15] tracing: Move hist trigger key printing into a
 separate function
Date: Tue, 23 Oct 2018 16:24:02 -0500
Message-ID: <1540329842.6502.9.camel@kernel.org>
References: <cover.1539288364.git.tom.zanussi@linux.intel.com>
         <7b9b456df5b0738f73aa6a688db82c345d0358e1.1539288364.git.tom.zanussi@linux.intel.com>
         <20181023233722.95a6685f2395c0ba979698a4@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, tglx@linutronix.de, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
To: Masami Hiramatsu <mhiramat@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181023233722.95a6685f2395c0ba979698a4@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Masami,

On Tue, 2018-10-23 at 23:37 +0900, Masami Hiramatsu wrote:
> Hi Tom,
> 
> On Thu, 11 Oct 2018 16:02:04 -0500
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > 
> > Future patches will want to print a histogram key outside a
> > histogram
> > - add and use hist_trigger_print_key() for that purpose.
> 
> Hmm, I think this change should be done with such user code, because
> without
> the user code I can not decide it is good or not.
> 

OK, will move it into the following patch, 'tracing: Add hist trigger
snapshot() action'.

Thanks,

Tom
