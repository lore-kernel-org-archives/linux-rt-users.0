From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH] ipc: mqueue: wq_add priority changed to dynamic
 priority
Date: Mon, 11 Dec 2017 15:15:37 -0500
Message-ID: <20171211151537.58212890@gandalf.local.home>
References: <1513006652-7014-1-git-send-email-jhaws@sdl.usu.edu>
        <1513012323038.16494@sdl.usu.edu>
        <20171211143241.6b5e627d@gandalf.local.home>
        <1513022070.2797.13.camel@sdl.usu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "deepa.kernel@gmail.com" <deepa.kernel@gmail.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>
To: Jonathan Haws <jhaws@sdl.usu.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1513022070.2797.13.camel@sdl.usu.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 11 Dec 2017 19:54:33 +0000
Jonathan Haws <jhaws@sdl.usu.edu> wrote:

> > Probably a better subject would be:
> > 
> >  ipc: mqueue: Have RT tasks queue in by priority in wq_add()  
> 
> Is the best way to change that just to change it in the email thread or
> resubmit the patch as v2?

That, or whoever takes it could change it before they pull it into git.

> 
> > 
> > Other than that (and that this doesn't handle DL tasks),
> > 
> > Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > 
> > -- Steve
> >   
> 
> I'm still new to kernel scheduling details - can you elaborate on what
> a DL task is?  I'm happy to update the patch to handle DL tasks as well
> if it makes sense to do so.

DL is a SCHED_DEADLINE task that has a dynamic priority that changes
over time. It's not a trivial task to compare them in these situations,
and they are currently not used much, and having DL tasks use this
queue is probably even more rare of an occurrence.

-- Steve
