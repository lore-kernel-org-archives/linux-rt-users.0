From: Jon Masters <jcm@redhat.com>
Subject: Re: [RFC][PATCH 4/3] tracing: Add NMI tracing in hwlat detector
Date: Wed, 10 Aug 2016 10:10:05 -0400
Message-ID: <c9973e20-eb77-91b0-2af0-a08dd101bb72@redhat.com>
References: <20160804145708.158968389@goodmis.org>
 <20160804125618.6db9b5b3@gandalf.local.home>
 <20160804131645.1ba3244a@gandalf.local.home>
 <20160805143555.GB21312@linutronix.de>
 <20160805105207.16e26a41@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Clark Williams <williams@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Wagner <wagi@monom.org>, Carsten Emde <C.Emde@osadl.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160805105207.16e26a41@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 08/05/2016 10:52 AM, Steven Rostedt wrote:

> Ah, this is when we have GENERIC_SCHED_CLOCK, which would break tracing
> if any arch that has this also has NMIs. Probably need to look at arm64.

Today, we don't have NMIs on arm64 that are supported in Linux.

Jon.

-- 
Computer Architect | Sent from my Fedora powered laptop
