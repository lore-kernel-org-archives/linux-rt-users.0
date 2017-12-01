From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH RT] arm*: disable NEON in kernel mode
Date: Fri, 1 Dec 2017 18:08:28 +0000
Message-ID: <20171201180828.GN10595@n2100.armlinux.org.uk>
References: <20171130142216.GB12606@linutronix.de>
 <20171130143028.GA1351@linutronix.de>
 <20171201104331.GB1612@linutronix.de>
 <20171201134506.GF1612@linutronix.de>
 <20171201141827.yip6pl3tt7kxzek7@lakrids.cambridge.arm.com>
 <20171201143648.GK1612@linutronix.de>
 <24FDBFF1-8351-46FC-885A-6B6F972F4C6C@linaro.org>
 <20171201175844.GT22781@e103592.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-rt-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        tglx@linutronix.de, linux-arm-kernel@lists.infradead.org
To: Dave Martin <Dave.Martin@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171201175844.GT22781@e103592.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, Dec 01, 2017 at 05:58:45PM +0000, Dave Martin wrote:
> +1, at least for arm64.  I don't see a really compelling reason for
> holding kernel-mode NEON around memory management now that we have a
> strict save-once-restore-lazily model.
> 
> This may not work so well for arm though -- I haven't looked at that
> code for a while.
> 
> 
> If there is memory manamement in any core loop, you already lost
> the performance battle, and an extra
> kernel_neon_end()+kernel_neon_begin() may not be that catastrophic.

Remember that we don't permit context switches while kernel neon is
in use on ARM - if there's any possibility of scheduling to occur,
the get_cpu() in kernel_neon_begin() should trigger a schedule-while-
atomic warning.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
