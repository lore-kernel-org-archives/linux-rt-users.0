From: Stanislav Meduna <stano@meduna.org>
Subject: Re: BUG: spinlock trylock failure on UP - reverting timer patches
 helps
Date: Fri, 18 Apr 2014 00:55:19 +0200
Message-ID: <53505BD7.9050004@meduna.org>
References: <534C3606.7010206@meduna.org> <534C731F.1050406@meduna.org> <534DADF1.6060608@meduna.org> <53500184.4050309@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	bigeasy@linutronix.de, Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	triplesquarednine@gmail.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:39364 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750928AbaDQWz3 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 17 Apr 2014 18:55:29 -0400
In-Reply-To: <53500184.4050309@meduna.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 17.04.2014 18:29, Stanislav Meduna wrote:

> Note: the bug goes away reverting the very same patches that are
> helping the Jordan's problms. I did follow
> 
> http://www.spinics.net/lists/linux-rt-users/msg11639.html
> 
> and no BUG while booting anymore. I'll try to let it run some
> more time.

Erm.. nope

# (cat /proc/meminfo ; cat /proc/meminfo) |  grep KernelStack
KernelStack:        5920 kB
KernelStack:        5928 kB

# (cat /proc/meminfo ; cat /proc/meminfo) |  grep KernelStack
KernelStack:        5952 kB
KernelStack:        5960 kB

maybe interrupt nesting ad nauseum? How does one debug
such issues?

It is possible that my previous posting was also caused by this -
disregard, I'll post again if the problem persists.

Jordan, could you check whether your kernel stack remains
stable with only the 3 patches reverted?

Thanks
-- 
                                     Stano

