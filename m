From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT] crypto: limit more FPU-enabled sections
Date: Thu, 30 Nov 2017 15:30:29 +0100
Message-ID: <20171130143028.GA1351@linutronix.de>
References: <20171130142216.GB12606@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171130142216.GB12606@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2017-11-30 15:22:17 [+0100], To linux-rt-users@vger.kernel.org wrote:
> Probably we should meassure the performance those ciphers in pure SW
> mode and with this optimisations to see if it makes sense to keep them
> for RT.

This is only x86. We have the same fun with kernel_neon_begin() on the
arm/arm64 side…

Sebastian
