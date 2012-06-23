From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 2/3] Oops during Init IRQ
Date: Sat, 23 Jun 2012 09:42:17 -0400
Message-ID: <1340458937.27036.291.camel@gandalf.stny.rr.com>
References: <20120623030548.500374594@goodmis.org>
	 <20120623030639.113614886@goodmis.org>
	 <alpine.LFD.2.02.1206231257560.2853@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	leroy christophe <christophe.leroy@c-s.fr>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.02.1206231257560.2853@ionos>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sat, 2012-06-23 at 12:59 +0200, Thomas Gleixner wrote:
> On Fri, 22 Jun 2012, Steven Rostedt wrote:
> 
> You asked for a changelog. Here you go:
> 
> Subject: powerpc: Mark low level irq handlers NO_THREAD
> 
> These low level handlers cannot be threaded. Mark them NO_THREAD
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Thanks! I'll add this when I commit it into the git tree.

-- Steve
