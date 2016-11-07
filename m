From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] rcu: update: make RCU_EXPEDITE_BOOT default
Date: Mon, 7 Nov 2016 18:30:30 +0100
Message-ID: <20161107173029.caktxw4piluk5atu@linutronix.de>
References: <20161014092050.GW29518@linux.vnet.ibm.com>
 <20161016044420-mutt-send-email-mst@kernel.org>
 <20161016112846.GR29518@linux.vnet.ibm.com>
 <20161031173852.a3ji7hhgjis5l3u4@linutronix.de>
 <20161031181543.GN3716@linux.vnet.ibm.com>
 <20161102163002.igni3zdnid535nou@linutronix.de>
 <20161103162228.GG3716@linux.vnet.ibm.com>
 <20161103163326.jkjbncoz7a5oriy5@linutronix.de>
 <20161103165931.GJ3716@linux.vnet.ibm.com>
 <20161107121939.7346923f@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        linux-rt-users@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161107121939.7346923f@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2016-11-07 12:19:39 [-0500], Steven Rostedt wrote:
> I agree, but if this creates a boot time regression in large machines,
> it may not be warranted.
> 
> I know Linus usually doesn't like options with default y, but this may
> be one of those exceptions. Perhaps we should make it on by default and
> say in the config "if you have a machine with 100s or 1000s of CPUs,
> you may want to disable this".

The default could change if we know where the limit is. I have access to
a box with approx 140 CPUs so I could check there if it is already bad.
But everything above that / in the 1000 range is a different story.

> -- Steve

Sebastian
