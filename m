From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 4.8-rt] x86-32: fix stalled boot issues due to missing
 thread info in %ebp
Date: Mon, 24 Oct 2016 10:45:25 +0200
Message-ID: <20161024084525.qqn6esku3m5v426w@linutronix.de>
References: <20161021181051.25437-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:57155 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934850AbcJXIpa (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 24 Oct 2016 04:45:30 -0400
Content-Disposition: inline
In-Reply-To: <20161021181051.25437-1-paul.gortmaker@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2016-10-21 14:10:51 [-0400], Paul Gortmaker wrote:
> Load up %ebp just before we try to use it ; this is also basically
> what x86-64 does in the -rt preempt lazy patch mentioned above,
> but it instead uses %rcx.

Applied, thanks.

> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Sebastian
