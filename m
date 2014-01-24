From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT v2] timer: Raise softirq if there's irq_work
Date: Fri, 24 Jan 2014 21:42:49 +0100
Message-ID: <52E2D049.3060800@linutronix.de>
References: <20140124145157.1f30d447@gandalf.local.home> <20140124150933.22d8c20a@gandalf.local.home> <20140124202039.GA32662@linutronix.de> <20140124153542.6a92ef27@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	"Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
	John Kacur <jkacur@redhat.com>,
	Mike Galbraith <bitbucket@online.de>,
	Joakim Hernberg <jbh@alchemy.lu>,
	Joe Korty <joe.korty@ccur.com>,
	Muli Baron <muli.baron@gmail.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140124153542.6a92ef27@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 01/24/2014 09:35 PM, Steven Rostedt wrote:
> 
> I know we discussed this on IRC, but I wanted to publicly state that
> the missing irq work callback was the RCU's rsp_wakeup() function.

Let me add that part to that commit message since I can't find it.

> 
> -- Steve

Sebastian
