From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 2/2 v4] preempt-rt/x86: Delay calling signals in int3
Date: Mon, 06 Feb 2012 11:38:08 -0500
Message-ID: <1328546288.2200.16.camel@gandalf.stny.rr.com>
References: <20120203182853.547078531@goodmis.org>
	 <20120203183041.427463295@goodmis.org> <20120203184016.GA10413@redhat.com>
	 <1328299833.5882.211.camel@gandalf.stny.rr.com>
	 <20120205192305.GB12183@redhat.com> <20120205193146.GC12183@redhat.com>
	 <1328544744.2200.11.camel@gandalf.stny.rr.com>
	 <20120206162532.GA6951@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
	Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@linux-foundation.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Alexander van Heukelum <heukelum@fastmail.fm>,
	Andi Kleen <ak@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>, stable-rt@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120206162532.GA6951@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2012-02-06 at 17:25 +0100, Oleg Nesterov wrote:
> On 02/06, Steven Rostedt wrote:

> > > This is certainly wrong in upstream kernel. It does use force_
> > > this way although it shouldn't imho.
> >
> > It's wrong in upstream even with the #ifdef define here?
> 
> No, the patch has no effect if !CONFIG_PREEMPT_RT_FULL.

Well then, it is perfectly correct for the upstream kernel with the
#ifdef CONFIG_PREEMPT_RT_FULL added ;-)

-- Steve
