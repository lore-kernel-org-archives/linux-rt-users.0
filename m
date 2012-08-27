From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: [PATCH RT 0/2] [ANNOUNCE] 3.0.41-rt62-rc1 stable review
Date: Mon, 27 Aug 2012 15:54:48 -0700
Message-ID: <503BFAB8.4070708@am.sony.com>
References: <20120825034900.144648579@goodmis.org>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>, <michael.thalmeier@hale.at>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120825034900.144648579@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 08/24/12 20:49, Steven Rostedt wrote:
> 
> Dear RT Folks,
> 
> This is the RT stable review cycle of patch 3.0.41-rt62-rc1.
> 
> Please scream at me if I messed something up. Please test the patches too.

I should have looked harder when Michael requested my patch be applied to the
stable series.

My patch was part of a two patch series, sent 5/16.  The first patch was
a reversal of preempt-rt-allow-immediate-magic-sysrq-output-for-preempt_rt_full.patch

The second patch works fine without the first patch.  But the second patch (the one
in 3.0.41-rt62-rc1) removes the need for
preempt-rt-allow-immediate-magic-sysrq-output-for-preempt_rt_full.patch

It is not a big deal if the reversal patch gets left out of the stable releases,
but it is cleaner if it is included.

This also applies to 3.2.28-rt42-rc1

< snip >

> Changes from 3.0.41-rt61:
> 
> ---
> 
> 
> Frank Rowand (1):
>       fix printk flush of messages
> 
> Steven Rostedt (1):
>       Linux 3.0.41-rt62-rc1
> 
> ----
>  kernel/printk.c |    2 +-
>  localversion-rt |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

-Frank
