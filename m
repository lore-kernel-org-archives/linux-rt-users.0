From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] rcu: update: make RCU_EXPEDITE_BOOT default
Date: Mon, 7 Nov 2016 12:19:39 -0500
Message-ID: <20161107121939.7346923f@gandalf.local.home>
References: <20161012203223.GK29518@linux.vnet.ibm.com>
        <20161013191332-mutt-send-email-mst@kernel.org>
        <20161014092050.GW29518@linux.vnet.ibm.com>
        <20161016044420-mutt-send-email-mst@kernel.org>
        <20161016112846.GR29518@linux.vnet.ibm.com>
        <20161031173852.a3ji7hhgjis5l3u4@linutronix.de>
        <20161031181543.GN3716@linux.vnet.ibm.com>
        <20161102163002.igni3zdnid535nou@linutronix.de>
        <20161103162228.GG3716@linux.vnet.ibm.com>
        <20161103163326.jkjbncoz7a5oriy5@linutronix.de>
        <20161103165931.GJ3716@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        linux-rt-users@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161103165931.GJ3716@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 3 Nov 2016 09:59:31 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

> On Thu, Nov 03, 2016 at 05:33:27PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2016-11-03 09:22:28 [-0700], Paul E. McKenney wrote:  
> > > On Wed, Nov 02, 2016 at 05:30:02PM +0100, Sebastian Andrzej Siewior wrote:  
> > > > RCU_EXPEDITE_BOOT should speed up the boot process by enforcing
> > > > synchronize_rcu_expedited() instead of synchronize_rcu() during the boot
> > > > process. There should be no reason why one does not want this and there
> > > > is no need worry about real time latency at this point.
> > > > Therefore make it default.
> > > > 
> > > > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>  
> > > 
> > > Well, it has been awhile since I removed a Kconfig parameter.
> > > 
> > > So why could this be a bad thing?
> > > 
> > > 1.	Very large systems might see scalability issues with unconditional
> > > 	expediting at boot.  But if we don't try it, we won't know.  
> > 
> > You mean we would make the boot process slower for them instead of
> > faster?  
> 
> For really bit systems, quite possibly, where "really big" means
> many hundreds or (more likely) thousands of CPUs.
> 
> But there are things that I can do to fix this when and if.
> 
> > > 2.	People bringing up new hardware might not want quite so many
> > > 	IPIs.  But they can just set rcu_normal to prevent that.  
> > 
> > I wanted to make things simple and not complicated…  
> 
> I know that feeling.  ;-)
> 

I agree, but if this creates a boot time regression in large machines,
it may not be warranted.

I know Linus usually doesn't like options with default y, but this may
be one of those exceptions. Perhaps we should make it on by default and
say in the config "if you have a machine with 100s or 1000s of CPUs,
you may want to disable this".

-- Steve
