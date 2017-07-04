From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 00/32]  tracing: Inter-event (e.g. latency) support
Date: Tue, 4 Jul 2017 18:12:44 +0200
Message-ID: <20170704161240.4qmwbm4gcy474tc4@linutronix.de>
References: <cover.1498510759.git.tom.zanussi@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        namhyung@kernel.org, vedang.patel@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1498510759.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2017-06-26 17:49:00 [-0500], Tom Zanussi wrote:
> This patchset adds support for 'inter-event' quantities to the trace
> event subsystem.  The most important example of inter-event quantities
> are latencies, or the time differences between two events.
…

I took this series and pushed into my v4.11 RT tree and removed the
"old" latency hist patches I had there.
Please keep me in CC if you post new versions of this series.

Sebastian
