From: Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH v7 09/16] tracing: Add hist trigger snapshot() action
 test case
Date: Wed, 28 Nov 2018 19:12:25 -0600
Message-ID: <1543453945.4149.6.camel@kernel.org>
References: <cover.1542221862.git.tom.zanussi@linux.intel.com>
         <a40dadf6ffa267a1a573b62bb1c9b4db9d91f744.1542221863.git.tom.zanussi@linux.intel.com>
         <20181126220332.215b461779d1d57f37b46e20@kernel.org>
         <1543359225.4223.5.camel@kernel.org>
         <20181128111558.5869fa4be7104314e833a801@kernel.org>
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
In-Reply-To: <20181128111558.5869fa4be7104314e833a801@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Masami,

On Wed, 2018-11-28 at 11:15 +0900, Masami Hiramatsu wrote:
> Hi Tom,
> 
> On Tue, 27 Nov 2018 16:53:45 -0600
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > > > +ping $LOCALHOST -c 3
> > > > +nice -n 1 ping $LOCALHOST -c 3
> > > > +
> > > > +echo 0 > /sys/kernel/debug/tracing/events/sched/enable
> > > 
> > > Shouldn't we stop tracing instead of disabling the event?
> > > 
> > 
> > This is just reversing the enable, so should be fine, but I can
> > stop
> > tracing instead if you prefer.
> 
> Oops, maybe we have to check the difference between event enabling
> and
> trace enabling.
> echo 0 > tracing_on will stop writing ring buffer, but event may
> continue
> to be called. Does this mean hist will be updated? (and I guess
> preferrable
> behavior is to stop hist too, isn't it?)
> 

For this test case, we're only enabling the sched events so we have
something in the snapshot buffer to verify that the snapshot worked, so
either should work for this purpose.

The triggers are supposed to work even if nothing is being logged to
the ring buffer, so the hist triggers updating when tracing to the
buffers is disabled is consistent with that...

Tom

> Thank you,
> 
> 
