From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [4.14.66-rt40] [report][cpuhotplug] BUG: sleeping function
 called from invalid context at kernel/locking/rtmutex.c:974
Date: Thu, 30 Aug 2018 11:14:56 +0200
Message-ID: <20180830091456.mz73o26ohrc3rq2f@linutronix.de>
References: <4277080d-fbd1-282c-164d-c07796260c36@ti.com>
 <20180829140817.7pr5g2aonbp55fjr@linutronix.de>
 <3aaebda9-a956-55d6-0b04-f84daa6e4866@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: Steven Rostedt <rostedt@goodmis.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Mike Galbraith <efault@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>
To: Grygorii Strashko <grygorii.strashko@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3aaebda9-a956-55d6-0b04-f84daa6e4866@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2018-08-29 16:28:50 [-0500], Grygorii Strashko wrote:
> 
> Thank you. Are there any plans to back port them for 4.14-rt?
> Patch [1] need to be reworked a bit, [2] - I was able to cherry-pick from 4.18-rt.

Grygorii, could you please replace the second patch with

  https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/plain/patches/irqchip-gic-v3-its-Move-pending-table-allocation-to-.patch?h=linux-4.18.y-rt-patches

(incremental patch  
  https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/patch/?id=4a0819bb25d12d39c0390636122eefba232596c1
)

and check if it works? It should work but I can't test it myself because
my box with GICv3 died recently…

Sebastian
