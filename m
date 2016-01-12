From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [4.4-rc6-rt1 PATCH 0/2] ARM: am437x: boot test report
Date: Tue, 12 Jan 2016 18:15:56 +0100
Message-ID: <20160112171556.GB31009@linutronix.de>
References: <1451325611-21678-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sekhar Nori <nsekhar@ti.com>
To: Grygorii Strashko <grygorii.strashko@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1451325611-21678-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Grygorii Strashko | 2015-12-28 20:00:09 [+0200]:

>Hi All, Sebastian,
Hi Grygorii,

>3) Seems there are some problem with HIGHMEM :(. System crashes if I'm trying
>   to run hackbench (see log 1). I can run hackbench only if HIGHMEM is disabled.
>   I've also tried to disable CONFIG_CPU_SW_DOMAIN_PAN, CONFIG_ARM_PATCH_PHYS_VIRT,
>   and CONFIG_CPUSETS, before disabling HIGHMEM.
>   Sorry, I'll not able to investigate it further because of Christmas holidays here.  

I see. It seems not to trigger anything on x86.

>4) Could we revert commit 4fa5422 'ARM: OMAP2: Drop the concept of certain power
>   domains not being able to lose context.'? It's not required for 4.4-rt wakeup
>   and introduces build warnings.

done.

Sebastian
