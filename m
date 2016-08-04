From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH 0/3] tracing: Add Hardware Latency detector tracer
Date: Thu, 4 Aug 2016 11:30:33 -0400
Message-ID: <20160804113033.78132a93@gandalf.local.home>
References: <20160804145708.158968389@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Clark Williams <williams@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jon Masters <jcm@redhat.com>, Daniel Wagner <wagi@monom.org>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160804145708.158968389@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Note, I'm currently working on adding code to detect NMIs to this as
well. And perhaps even tracing SMI counters. Just to show what caused
the latency, as latency isn't measured by the counters (that I know of).

-- Steve
