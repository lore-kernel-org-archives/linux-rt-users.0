From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] 3.4.41-rt55-feat3
Date: Mon, 29 Apr 2013 22:21:53 -0400
Message-ID: <1367288513.30667.55.camel@gandalf.local.home>
References: <1367283987.30667.49.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1367283987.30667.49.camel@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2013-04-29 at 21:06 -0400, Steven Rostedt wrote:
> Dear RT Folks,
> 
> I'm pleased to announce the 3.4.41-rt55-feat3 feature release.
> 
> Note, I first uploaded -feat2 then realized I didn't add a compile fix by
> Mike Galbraith, and then created the -feat3 with that fix.
> 

Because of the -feat2/3 screw up, I forgot to thank Sebastian Andrzej
Siewior for doing the SLUB backport.

-- Steve
