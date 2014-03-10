From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 2/5] a few open coded completions
Date: Mon, 10 Mar 2014 10:29:28 -0400
Message-ID: <20140310102928.7b2a2cfa@gandalf.local.home>
References: <20131211003732.351606520@goodmis.org>
	<20131211003801.836995968@goodmis.org>
	<20131211144946.27d82a78@gandalf.local.home>
	<1394324841.2861.56.camel@deadeye.wl.decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Corey Minyard <cminyard@mvista.com>
To: Ben Hutchings <ben@decadent.org.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1394324841.2861.56.camel@deadeye.wl.decadent.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sun, 09 Mar 2014 00:27:21 +0000
Ben Hutchings <ben@decadent.org.uk> wrote:

> On Wed, 2013-12-11 at 14:49 -0500, Steven Rostedt wrote:
> > Here's the new patch:
> 
> Doesn't add #includes and doesn't change any types, so of course it
> doesn't compile.  WTF?
> 

Hi Ben,

This is an old thread. Which kernel did you apply it to. Before I send
any patch set out, I run a small test (heavy stress test, and also
compile several different configs). This patch was against 3.10-rt, and
may have already had the includes needed. I know the original patch
compiled, but I may not have tested the second patch.

Do you need this patch? Or did I miss something for 3.2-rt?

-- Steve
