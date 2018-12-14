From: Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH v8 20/22] tracing: Use hist trigger's var_ref array to
 destroy var_refs
Date: Fri, 14 Dec 2018 11:29:21 -0600
Message-ID: <1544808561.10497.15.camel@kernel.org>
References: <cover.1544483272.git.tom.zanussi@linux.intel.com>
         <4d6103ab7b4fdef81a82e2977b4005a26212a726.1544483273.git.tom.zanussi@linux.intel.com>
         <20181215013119.dc796fd4d2d21535adb4cf6c@kernel.org>
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
In-Reply-To: <20181215013119.dc796fd4d2d21535adb4cf6c@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Masami,

On Sat, 2018-12-15 at 01:31 +0900, Masami Hiramatsu wrote:
> On Mon, 10 Dec 2018 18:01:34 -0600
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > 
> > Since every var ref for a trigger has an entry in the var_ref[]
> > array,
> > use that to destroy the var_refs, instead of piecemeal via the
> > field
> > expressions.
> > 
> > This allows us to avoid having to keep and treat differently
> > separate
> > lists for the action-related references, which future patches will
> > remove.
> 
> I'm not so sure, but this seems a bugfix... if so, please move this
> at
> the top of this series.
> 

No, none of these are bugfixes - patches 17-22 are just some additional
cleanup that try to make the code easier to follow after Namhyung's
comments that things were confusing here.

Actually, what I should probably do is make these a separate series..

Tom
