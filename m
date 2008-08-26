From: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH 2/5] sched: pull only one task during NEWIDLE balancing to limit critical section
Date: Tue, 26 Aug 2008 16:21:33 +1000
Message-ID: <200808261621.33810.nickpiggin@yahoo.com.au>
References: <20080825200852.23217.13842.stgit@dev.haskins.net> <20080825201529.23217.8708.stgit@dev.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: mingo@elte.hu, srostedt@redhat.com, peterz@infradead.org,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	npiggin@suse.de, gregory.haskins@gmail.com
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp114.mail.mud.yahoo.com ([209.191.84.67]:29030 "HELO
	smtp114.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751344AbYHZGVk (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 26 Aug 2008 02:21:40 -0400
In-Reply-To: <20080825201529.23217.8708.stgit@dev.haskins.net>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tuesday 26 August 2008 06:15, Gregory Haskins wrote:
> git-id c4acb2c0669c5c5c9b28e9d02a34b5c67edf7092 attempted to limit
> newidle critical section length by stopping after at least one task
> was moved.  Further investigation has shown that there are other
> paths nested further inside the algorithm which still remain that allow
> long latencies to occur with newidle balancing.  This patch applies
> the same technique inside balance_tasks() to limit the duration of
> this optional balancing operation.
>
> Signed-off-by: Gregory Haskins <ghaskins@novell.com>
> CC: Nick Piggin <npiggin@suse.de>

Hmm, this (andc4acb2c0669c5c5c9b28e9d02a34b5c67edf7092) still could
increase the amount of work to do significantly for workloads where
the CPU is going idle and pulling tasks over frequently. I don't
really like either of them too much.

Maybe increasing the limit would effectively amortize most of the
problem (say, limit to move 16 tasks at most).
