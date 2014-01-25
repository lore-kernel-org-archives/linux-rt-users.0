From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT v2] timer: Raise softirq if there's irq_work
Date: Fri, 24 Jan 2014 21:16:55 -0500
Message-ID: <20140124211655.0a684f31@gandalf.local.home>
References: <20140124145157.1f30d447@gandalf.local.home>
	<20140124150933.22d8c20a@gandalf.local.home>
	<20140124202039.GA32662@linutronix.de>
	<20140124153542.6a92ef27@gandalf.local.home>
	<20140125001936.GB9012@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	"Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
	John Kacur <jkacur@redhat.com>,
	Mike Galbraith <bitbucket@online.de>,
	Joakim Hernberg <jbh@alchemy.lu>,
	Joe Korty <joe.korty@ccur.com>,
	Muli Baron <muli.baron@gmail.com>
To: paulmck@linux.vnet.ibm.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140125001936.GB9012@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 24 Jan 2014 16:19:36 -0800
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
 
> Failing to invoke rsp_wakeup() when it was needed could potentially
> stop RCU grace periods from happening, so having rsp_wakeup() happen
> when it is needed is pretty important...
> 
> But I would guess that you knew that already.  ;-)

Yep, I did. But it's always nice to hear confirmation, which is why I
Cc'd you ;-)

-- Steve
