From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [ANNOUNCE] 3.18.7-rt2
Date: Wed, 25 Feb 2015 03:27:40 +0100
Message-ID: <1424831260.6749.7.camel@gmail.com>
References: <20150223090617.GA26453@linutronix.de>
	 <1424785301.8767.11.camel@gmail.com>
	 <CAA8Xd+9QEn0XE2pV-7fW0cBXKBSK9=oZyTaFH2urGvJLGb=gFw@mail.gmail.com>
	 <1424800214.6955.30.camel@gmail.com>
	 <CAA8Xd+-+zGz8R2H2t1Smp0erN7NtwDLbxAWshRz_FjU2T8CnEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Kacur <jkacur@redhat.com>
To: Gustavo Bittencourt <gbitten@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAA8Xd+-+zGz8R2H2t1Smp0erN7NtwDLbxAWshRz_FjU2T8CnEA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2015-02-24 at 17:00 -0300, Gustavo Bittencourt wrote:

> Is there anyway that I could help? I think I can write a code to
> reproduce the deadlock without the nouveau driver.

A non-drm testcase would be nice.  The people who decided that serial
ports could just _go away_ should be pelted mightily with frozen shark.

	-Mike
