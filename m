From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] arm64: replace read_lock to rcu lock in call_step_hook
Date: Tue, 9 Feb 2016 16:04:42 +0000
Message-ID: <20160209160442.GS22874@arm.com>
References: <1454971764-30720-1-git-send-email-yang.shi@linaro.org>
 <20160209145426.GR22874@arm.com>
 <20160209100758.69d9006f@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yang Shi <yang.shi@linaro.org>, linaro-kernel@lists.linaro.org,
	linux-rt-users@vger.kernel.org, catalin.marinas@arm.com,
	bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160209100758.69d9006f@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, Feb 09, 2016 at 10:07:58AM -0500, Steven Rostedt wrote:
> On Tue, 9 Feb 2016 14:54:26 +0000
> Will Deacon <will.deacon@arm.com> wrote:
> 
> 
> > Acked-by: Will Deacon <will.deacon@arm.com>
> 
> Will,

Hi Steve,

> The patch looks good to me. Do you want to take it through your tree?
> 
> It benefits mainline too as a rcu_read_lock() is more efficient than
> rwlocks. Although I will say this is a slow path anyway.

I was thinking that Catalin would queue it for 4.6 in the arm64 tree,
since that's probably easiest in case any unlikely conflicts crop up.

Will
