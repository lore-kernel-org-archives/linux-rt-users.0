From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v8 20/22] tracing: Use hist trigger's var_ref array to
 destroy var_refs
Date: Sat, 15 Dec 2018 15:50:18 +0900
Message-ID: <CAM9d7ciW3cHVFLeuP+pdC-+1fnGMkRnfwGsbeKX_Zj30f-r4hA@mail.gmail.com>
References: <cover.1544483272.git.tom.zanussi@linux.intel.com>
 <4d6103ab7b4fdef81a82e2977b4005a26212a726.1544483273.git.tom.zanussi@linux.intel.com>
 <20181215013119.dc796fd4d2d21535adb4cf6c@kernel.org> <1544808561.10497.15.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>, vedang.patel@intel.com,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        julia@ni.com, linux-kernel <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
To: zanussi@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1544808561.10497.15.camel@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Tom and Masami,

On Sat, Dec 15, 2018 at 2:29 AM Tom Zanussi <zanussi@kernel.org> wrote:
>
> Hi Masami,
>
> On Sat, 2018-12-15 at 01:31 +0900, Masami Hiramatsu wrote:
> > On Mon, 10 Dec 2018 18:01:34 -0600
> > Tom Zanussi <zanussi@kernel.org> wrote:
> >
> > > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > >
> > > Since every var ref for a trigger has an entry in the var_ref[]
> > > array,
> > > use that to destroy the var_refs, instead of piecemeal via the
> > > field
> > > expressions.
> > >
> > > This allows us to avoid having to keep and treat differently
> > > separate
> > > lists for the action-related references, which future patches will
> > > remove.
> >
> > I'm not so sure, but this seems a bugfix... if so, please move this
> > at
> > the top of this series.
> >
>
> No, none of these are bugfixes - patches 17-22 are just some additional
> cleanup that try to make the code easier to follow after Namhyung's
> comments that things were confusing here.
>
> Actually, what I should probably do is make these a separate series..

Agreed, I also think it's getting bigger and having these cleanups
before the actual change would make things little bit easier IMHO.

Thanks,
Namhyung
