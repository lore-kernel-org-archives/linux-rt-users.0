From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH][RT] xfs: Disable preemption when grabbing all icsb
 counter locks
Date: Thu, 30 Apr 2015 14:36:53 -0400
Message-ID: <20150430143653.4ee3bed6@gandalf.local.home>
References: <20150430123303.30f5bd12@gandalf.local.home>
	<20150430183327.GA28821@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	Dave Chinner <david@fromorbit.com>,
	Peter Zijlstra <peterz@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0178.hostedemail.com ([216.40.44.178]:56548 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751231AbbD3Sg4 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 30 Apr 2015 14:36:56 -0400
In-Reply-To: <20150430183327.GA28821@infradead.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 30 Apr 2015 11:33:27 -0700
Christoph Hellwig <hch@infradead.org> wrote:

> FYI, this code is gone in 4.1-rc.

:-)

Well, when we port -rt to 4.1 that will be the answer!

But for now, we need to band-aid the older versions of the kernel that
we do support.

-- Steve
