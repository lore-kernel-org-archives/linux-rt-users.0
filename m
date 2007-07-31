From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/2][RFC] VFCIPI v3
Date: Tue, 31 Jul 2007 16:25:57 +0200
Message-ID: <1185891957.12034.12.camel@twins>
References: <20070731132153.4790.37217.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@elte.hu>
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:34228 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752309AbXGaO0B (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 31 Jul 2007 10:26:01 -0400
In-Reply-To: <20070731132153.4790.37217.stgit@novell1.haskins.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Hi Gregory,

This patch set approaches the problem from the wrong angle (and has a
few problems due to that).

The idea to use a workqueue (or in your case workqueue-like) solution to
the problem is valid, however instead of re-using (and improving) the
current workqueue infrastructure, you re-implement it (with mistakes).

The solution currently in -rt uses regular workqueues to implement
schedule_on_each_cpu() - a drop in replacement for on_each_cpu() in the
context of -rt and useful outside of that if people do require such
functionality.

Your idea of using priority arrays in the workqueue is a good one,
please implement that for the regular workqueues.

Your idea that GFP_ATOMIC is broken in -rt is unfortunate, it isn't. The
whole allocator is preemptable - that is a feature!

Please keep up the good work, looking forward to those prio-workqueue
patches.

Peter
