From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] arm64: replace read_lock to rcu lock in call_step_hook
Date: Tue, 9 Feb 2016 10:07:58 -0500
Message-ID: <20160209100758.69d9006f@gandalf.local.home>
References: <1454971764-30720-1-git-send-email-yang.shi@linaro.org>
	<20160209145426.GR22874@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Yang Shi <yang.shi@linaro.org>, catalin.marinas@arm.com,
	bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linaro-kernel@lists.linaro.org
To: Will Deacon <will.deacon@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160209145426.GR22874@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 9 Feb 2016 14:54:26 +0000
Will Deacon <will.deacon@arm.com> wrote:


> Acked-by: Will Deacon <will.deacon@arm.com>

Will,

The patch looks good to me. Do you want to take it through your tree?

It benefits mainline too as a rcu_read_lock() is more efficient than
rwlocks. Although I will say this is a slow path anyway.

-- Steve
