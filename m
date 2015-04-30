From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH][RT] xfs: Disable preemption when grabbing all icsb
 counter locks
Date: Thu, 30 Apr 2015 11:33:27 -0700
Message-ID: <20150430183327.GA28821@infradead.org>
References: <20150430123303.30f5bd12@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	Dave Chinner <david@fromorbit.com>,
	Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150430123303.30f5bd12@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

FYI, this code is gone in 4.1-rc.
