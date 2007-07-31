From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/2][RFC] VFCIPI v3
Date: Tue, 31 Jul 2007 18:22:20 +0200
Message-ID: <1185898941.12034.22.camel@twins>
References: <20070731132153.4790.37217.stgit@novell1.haskins.net>
	 <1185891957.12034.12.camel@twins> <46AF1DA6.BA47.005A.0@novell.com>
	 <1185896412.12034.17.camel@twins>  <46AF2752.BA47.005A.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:58400 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756508AbXGaQWY (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 31 Jul 2007 12:22:24 -0400
In-Reply-To: <46AF2752.BA47.005A.0@novell.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2007-07-31 at 12:14 -0400, Gregory Haskins wrote:

> Out of curiosity and for my own edification:  What *is* GFP_ATOMIC meant for?

It is meant as you used it, _except_ for !PREEMPT_RT.

With PREEMPT_RT all allocators are fully preemptable, that is both the
slab as well as the underlying page allocator.

Allocation from atomic context is a BUG() with -rt.
