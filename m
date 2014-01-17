From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: [PATCH RT] add missing local serialization in ip_output.c
Date: Fri, 17 Jan 2014 16:33:23 +0100
Message-ID: <20140117153323.GA23566@opentech.at>
References: <20131229171154.GA23586@opentech.at> <20140117144729.GB5785@linutronix.de> <20140117145955.GA5637@opentech.at> <52D94891.80109@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org,
	Sami Pietikainen <Sami.Pietikainen@wapice.com>,
	Jouko Haapaluoma <jouko.haapaluoma@wapice.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <52D94891.80109@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 17 Jan 2014, Sebastian Andrzej Siewior wrote:

> On 01/17/2014 03:59 PM, Nicholas Mc Guire wrote:
> > On Fri, 17 Jan 2014, Sebastian Andrzej Siewior wrote:
> > 
> >> This is what I am going to apply. It also dropped the get_cpu_light()
> >> call which was added in a patch to remove the get_cpu_var() and is now
> >> no longer required since we have the get_locked_var() thingy now.
> >>
> > 
> > I do not think you can drop that - what is preventing migration now ?
> 
> Nothing but I do not see the need for it.
> 
> > 
> > #define get_locked_var(lvar, var)                                       \
> >         (*({                                                            \
> >                 local_lock(lvar);                                       \
> >                 &__get_cpu_var(var);                                    \
> >         }))
> > 
q> > No migrate_disable here - so how is this protected against migration ?
> 
> It does not. If you get here on CPU0, you the variable from CPU0. If
> you get migrated to CPU1 you still use the variable from CPU0. If
> another task is active on CPU0 then it will be blocked until the other
> now running on CPU1 completes and releases the lock.
> 
> > Note that I did send out mail on this because I believe get_locked_var
> > should actually be doing a a migrate_disable/enable but got no feedback on that
> > yet.
> 
> I don't see a reason why you should not leave the CPU on which you got
> access to the variable as long as you do not do any further assumption
> regarding the CPU number. I don't see that this happens here.
> 
> > So for now I think you need to retain the get_cpu_light/put_cpu_light
> 
> Are you still sure?
>
yes and no - it is needed I believe but it is actually already provided.
what I overlooked is that (actually my path-diagram was wrong - so
thanks for the catch):

#define get_locked_var(lvar, var)                                       \
        (*({                                                            \
                local_lock(lvar);                                       \
                &__get_cpu_var(var);                                    \
        }))
      ->#define local_lock(lvar)                                        \
        	do { __local_lock(&get_local_var(lvar)); } while (0)

                -> # define get_local_var(var) (*({                        \
        	       migrate_disable();                              \
        	       &__get_cpu_var(var); }))
                       -> #define __get_cpu_var(var) (*this_cpu_ptr(&(var)))

so its fine to drop the get_cpu_light/put_cpu_light as migration is
in fact already disabled at this point. the access to the local spinlock
object here is via this_cpu_ptr so if we would allow migration I think
you would end up unlocking the wrong lock.

thx!
hofrat
