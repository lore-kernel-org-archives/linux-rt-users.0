From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [RFD 0/5] Add latency histogram
Date: Thu, 30 Apr 2015 12:06:20 +0200
Message-ID: <1430388385-29558-1-git-send-email-daniel.wagner@bmw-carit.de>
Cc: Ingo Molnar <mingo@redhat.com>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Carsten Emde <C.Emde@osadl.org>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Wagner <daniel.wagner@bmw-carit.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

I would like to discuss a possible way of getting the feature of the
latecy_hist.patch [1] added to mainline.

"Latency histograms are primarily relevant in the context of real-time
enabled kernels (CONFIG_PREEMPT/CONFIG_PREEMPT_RT)and are used in the
quality management of the Linux real-time capabilities."

Steven pointed out that this might be doable based on Tom Zanussi's
"[PATCH v4 0/7] tracing: 'hist' triggers" [2].

Here are my findings. It was not too complicated to get it working,
though I had to add some hacks. I have added comments to each patch.

cheers,
daniel

[2] https://lkml.org/lkml/2015/4/10/591
[1] https://git.kernel.org/cgit/linux/kernel/git/rt/linux-stable-rt.git/commit/?h=v3.14-rt-rebase&id=56d50cc34943bbba12b8c5942ee1ae3b29f73acb

Daniel Wagner (4):
  tracing: Add support to sort on the key
  tracing: Add option to quantize key values
  tracing: Deference pointers without RCU checks
  tracing: Add trace_irqsoff tracepoints

Tom Zanussi (1):
  tracing: 'hist' triggers

 include/linux/rculist.h             | 36 +++++++++++++++++++++++++++++
 include/linux/tracepoint.h          |  4 ++--
 include/trace/events/latency.h      | 40 ++++++++++++++++++++++++++++++++
 kernel/trace/trace_events_hist.c    | 46 +++++++++++++++++++++++++++++++++----
 kernel/trace/trace_events_trigger.c | 18 +++++++++------
 kernel/trace/trace_irqsoff.c        | 38 ++++++++++++++++++++++++++++++
 6 files changed, 168 insertions(+), 14 deletions(-)
 create mode 100644 include/trace/events/latency.h

-- 
2.1.0
