From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] 4.4-rc6-rt1
Date: Fri, 22 Jan 2016 21:44:09 +0100
Message-ID: <20160122204409.GB3883@linutronix.de>
References: <20151223225755.GA21121@linutronix.de>
 <56A24C58.8060209@ti.com>
 <56A24F39.2050606@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
To: Grygorii Strashko <grygorii.strashko@ti.com>,
	Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56A24F39.2050606@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Sebastian Andrzej Siewior | 2016-01-22 16:48:09 [+0100]:

>On 01/22/2016 04:35 PM, Grygorii Strashko wrote:
>> Additional note: RCU_BOOST now depends on RCU_EXPERT, so commit
>> 3da4cab "rcu: make RCU_BOOST default on RT" is nop now.
>> 
>> config RCU_BOOST
>>     bool "Enable RCU priority boosting"
>>     depends on RT_MUTEXES && PREEMPT_RCU && RCU_EXPERT
>>     default y if PREEMPT_RT_FULL
>
>yeah, I've been thinking about giving the experts menu item an y on RT
>as well.

Subject: [PATCH] RCU: make RCU_EXPERT y on RT

because we want RCU_BOOST y on RT

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 init/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index 6f4408adf62d..a7c81c0911da 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -498,7 +498,7 @@ config TINY_RCU
 
 config RCU_EXPERT
 	bool "Make expert-level adjustments to RCU configuration"
-	default n
+	default y if PREEMPT_RT_FULL
 	help
 	  This option needs to be enabled if you wish to make
 	  expert-level adjustments to RCU configuration.  By default,
-- 
2.7.0.rc3
