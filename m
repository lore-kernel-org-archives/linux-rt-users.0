From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PREEMPT RT] SLUB and split softirq lock for v3.2-rt
Date: Wed, 13 Feb 2013 17:11:55 +0100
Message-ID: <1360771932-27150-1-git-send-email-bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Carsten Emde <C.Emde@osadl.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.2-rt is a long term supported kernel, which lacks two RT features
from 3.6: SLUB support and the split softirq lock implementation.

SLUB has a way better performance than SLAB on RT and the split
softirq lock implementation is necessary especially for realtime
networking applications.

The following patch series backports these features to 3.2-rt.

Steven, could you please apply these patches to a separate
3.2-rt-features branch?

Sebastian
