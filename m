From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH 00/32]  tracing: Inter-event (e.g. latency) support
Date: Wed, 12 Jul 2017 14:20:39 -0500
Message-ID: <1499887239.3995.30.camel@tzanussi-mobl.amr.corp.intel.com>
References: <cover.1498510759.git.tom.zanussi@linux.intel.com>
         <20170704161240.4qmwbm4gcy474tc4@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Cc: rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        namhyung@kernel.org, vedang.patel@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:15930 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751871AbdGLTUr (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 12 Jul 2017 15:20:47 -0400
In-Reply-To: <20170704161240.4qmwbm4gcy474tc4@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Sebastian,

On Tue, 2017-07-04 at 18:12 +0200, Sebastian Andrzej Siewior wrote:
> On 2017-06-26 17:49:00 [-0500], Tom Zanussi wrote:
> > This patchset adds support for 'inter-event' quantities to the trace
> > event subsystem.  The most important example of inter-event quantities
> > are latencies, or the time differences between two events.
> …
> 
> I took this series and pushed into my v4.11 RT tree and removed the
> "old" latency hist patches I had there.

That's great, thanks!

> Please keep me in CC if you post new versions of this series.
> 

I will, and will have a new version coming soon. ;-)

Tom

> Sebastian


