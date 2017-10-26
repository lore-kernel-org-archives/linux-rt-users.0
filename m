From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] PREEMPT_RT: sched/rr, sched/fair: defer CFS scheduler
 put_prev_task()
Date: Thu, 26 Oct 2017 15:43:18 +0200
Message-ID: <20171026134318.GS3165@worktop.lehotels.local>
References: <1508970403-19912-1-git-send-email-amartin@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mingo@kernel.org, tglx@linutronix.de,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Allen Martin <amartin@nvidia.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:37408 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932246AbdJZNn3 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 26 Oct 2017 09:43:29 -0400
Content-Disposition: inline
In-Reply-To: <1508970403-19912-1-git-send-email-amartin@nvidia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Oct 25, 2017 at 03:26:43PM -0700, Allen Martin wrote:

This is a _really_ ugly patch.
