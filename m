From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT] crypto: limit more FPU-enabled sections
Date: Thu, 30 Nov 2017 16:22:36 +0100
Message-ID: <20171130152236.GA11362@linutronix.de>
References: <20171130142216.GB12606@linutronix.de>
 <20171130101943.15f7ade4@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:45574 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751960AbdK3PWi (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 30 Nov 2017 10:22:38 -0500
Content-Disposition: inline
In-Reply-To: <20171130101943.15f7ade4@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-11-30 10:19:43 [-0500], Steven Rostedt wrote:
…
> It really shows that these functions are only used by RT. IMO it's bad
> taste to have functions with the entire body encapsulated in #ifdefs.
> 
> And the same goes for the other functions in this patch.

No problem, I will change that.

> -- Steve

Sebastian
