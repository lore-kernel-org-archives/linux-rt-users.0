From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH 1/3] tracing: Added hardware latency tracer
Date: Fri, 5 Aug 2016 11:36:40 -0400
Message-ID: <20160805113640.5464702e@gandalf.local.home>
References: <20160804145708.158968389@goodmis.org>
	<20160804145839.856286626@goodmis.org>
	<20160805142521.GA21312@linutronix.de>
	<20160805104413.781611b5@gandalf.local.home>
	<866492b0-182c-4810-e738-6d19605c858f@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Clark Williams <williams@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jon Masters <jcm@redhat.com>, Daniel Wagner <wagi@monom.org>,
	Carsten Emde <C.Emde@osadl.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <866492b0-182c-4810-e738-6d19605c858f@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 5 Aug 2016 17:28:33 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:


> If you want to keep it, keep it. I just assumed it was a leftover.

I have mixed feelings about it. I may just nuke it anyway. I forgot to
add #3 laziness, it worked and I didn't want to add bugs by removing it.

--Steve
