From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] 3.4.41-rt55-feat1
Date: Thu, 25 Apr 2013 09:15:19 -0400
Message-ID: <1366895719.10248.13.camel@gandalf.local.home>
References: <1366760662.9609.176.camel@gandalf.local.home>
	   <2156546.QlsX0XyPQz@dabox> <51792277.8000205@linutronix.de>
	   <1366893374.6139.5.camel@marge.simpson.net>
	  <1366893787.10248.4.camel@gandalf.local.home>
	  <alpine.LFD.2.02.1304251445520.21884@ionos>
	 <1366894324.10248.6.camel@gandalf.local.home>
	 <alpine.LFD.2.02.1304251507370.21884@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Mike Galbraith <bitbucket@online.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Tim Sander <tim.sander@hbm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.02.1304251507370.21884@ionos>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2013-04-25 at 15:09 +0200, Thomas Gleixner wrote:

> Well, if your application is driven by an external interrupt, then you
> do not need highres timers at all.

Fair point.

-- Steve
