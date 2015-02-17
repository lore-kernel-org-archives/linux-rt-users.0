From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: 3.14.23-rt20 - x86, UV: raw_spinlock conversion
Date: Tue, 17 Feb 2015 15:11:18 +0100
Message-ID: <1424182278.2955.13.camel@gmail.com>
References: <20141031170326.1491a63f@gandalf.local.home>
	 <1414910967.5380.81.camel@marge.simpson.net>
	 <1414913497.5380.116.camel@marge.simpson.net>
	 <20150217130249.GK26177@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150217130249.GK26177@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2015-02-17 at 14:02 +0100, Sebastian Andrzej Siewior wrote:
> * Mike Galbraith | 2014-11-02 08:31:37 [+0100]:
> 
> >Shrug.  Lots of hobbyists have a beast in their basement, right?
> 
> I can take this as is if you want.

Or you can trash it since SGI didn't seem to care.  This patch was born
while getting 2.6.33-rt running on a UV100 box, I've been carrying it
ever since.

	-Mike
