From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 3/5] trace: correct off by one while recording the
 trace-event
Date: Tue, 12 Jul 2016 10:47:43 -0400
Message-ID: <20160712104743.31004504@gandalf.local.home>
References: <20160712142153.609204728@goodmis.org>
	<20160712142214.920054617@goodmis.org>
	<20160712144050.GA22814@linutronix.de>
	<20160712104555.317c1781@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	stable-rt@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160712104555.317c1781@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 12 Jul 2016 10:45:55 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 12 Jul 2016 16:40:50 +0200
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> > I am not the Author of this commit (and it is not yet in TIP). I haven't

Oh, I forgot to add, I don't go through the tip tree.

-- Steve
