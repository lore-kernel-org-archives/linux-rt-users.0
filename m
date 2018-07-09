From: Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH v2 0/7] tracing: Hist trigger snapshot and onchange
 additions
Date: Mon, 09 Jul 2018 13:25:35 -0500
Message-ID: <1531160735.20374.17.camel@kernel.org>
References: <cover.1530561352.git.tom.zanussi@linux.intel.com>
         <20180708000006.5b93884b8123392ab2446809@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, tglx@linutronix.de, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180708000006.5b93884b8123392ab2446809@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Masami,

On Sun, 2018-07-08 at 00:00 +0900, Masami Hiramatsu wrote:
> Hi Tom,
> 
> On Mon,  2 Jul 2018 15:22:19 -0500
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > 
> > Hi,
> > 
> > This is v2 of the hist trigger snapshot and onchange additions
> > patchset.  It adds a couple fixes to problems flagged by the kbuild
> > test robot, but is otherwise the same as v1.
> > 
> > Changes since v1:
> > 
> >   - added missing tracing_cond_snapshot_data() definition for when
> >     CONFIG_TRACER_SNAPSHOT not defined
> >   - removed an unnecessary WARN_ON() in track_data_snapshot_print()
> > 
> > 
> > Original text:
> > 
> > This patchset adds some useful new functions to the hist
> > trigger code: a snapshot action and an onchange handler.
> > 
> > In order to make it easier to add these and in the process make the
> > code more generic, I separated the code into explicit 'handlers'
> > and
> > 'actions', handlers being things like 'onmax' and 'onchange', and
> > 'actions' being things like 'take a snapshot' or 'save some
> > fields'.
> 
> Sounds great!
> 
> By the way, it seems that nowadays the syntax of trigger is
> very complicated. For example, we can set some 'actions' without
> handlers, but this introduce new 'handlers' on it.
> 
> Could you consider not just extending it, but refactor it from
> the viewpoint of consistent and extensible syntax?
> 
> e.g. if we support
> 
> <actions> if <condition>
> 
> syntax, why we can not do 
> 
> <actions> onchange(<var>)

It seems that doing this would restrict you to only one handler e.g.
you could no longer do something like:

  ...:onchange($var1).save(...):onmax($var2).snapshot()

I'm not sure how you would do that with your syntax.

On the other hand, if the most common use case is just a single handler
  along with one or more actions, I think it would make sense to
provide a shorthand like you describe which just gets translated into
the longer more explicit form.  Or were you thinking of something more
radical?

Thanks,

Tom

> 
