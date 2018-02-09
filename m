From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v4 00/20] crypto: arm64 - play nice with CONFIG_PREEMPT
Date: Fri, 9 Feb 2018 19:02:22 +0100
Message-ID: <20180209180222.qsi7jcw7pj442rpo@linutronix.de>
References: <20171226102940.26908-1-ard.biesheuvel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: linux-kernel@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-rt-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:34908 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752581AbeBISC2 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 9 Feb 2018 13:02:28 -0500
Content-Disposition: inline
In-Reply-To: <20171226102940.26908-1-ard.biesheuvel@linaro.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-12-26 10:29:20 [+0000], Ard Biesheuvel wrote:
> As reported by Sebastian, the way the arm64 NEON crypto code currently
> keeps kernel mode NEON enabled across calls into skcipher_walk_xxx() is
…
> So let's clean this up for arm64: update the NEON based skcipher drivers to
> no longer keep the NEON enabled when calling into the skcipher walk API.

Thanks for working on this.
What is the status of this? Is this going to be merged?

Sebastian
