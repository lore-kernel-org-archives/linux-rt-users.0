From: kbuild test robot <lkp@intel.com>
Subject: Re: [4.1.3-rt10][RFC PATCH] PM / sleep: freeze: fix bug "sleeping
 function called from invalid context"
Date: Wed, 21 Oct 2015 06:35:56 +0800
Message-ID: <201510210647.9xx8nY9L%fengguang.wu@intel.com>
References: <1445373303-26264-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="cWoXeonUoKmBZSoM"
Cc: kbuild-all@01.org, tglx@linutronix.de,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, bigeasy@linutronix.de,
	linux-rt-users@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Grygorii Strashko <grygorii.strashko@ti.com>
To: Grygorii Strashko <grygorii.strashko@ti.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1445373303-26264-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Grygorii,

[auto build test ERROR on v4.3-rc6 -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/Grygorii-Strashko/PM-sleep-freeze-fix-bug-sleeping-function-called-from-invalid-context/20151021-043733
config: avr32-atngw100_defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=avr32 

All error/warnings (new ones prefixed by >>):

>> kernel/power/suspend.c:32:31: error: linux/wait-simple.h: No such file or directory
>> kernel/power/suspend.c:41: warning: type defaults to 'int' in declaration of 'DEFINE_SWAIT_HEAD'
>> kernel/power/suspend.c:41: warning: parameter names (without types) in function declaration
   kernel/power/suspend.c: In function 'freeze_enter':
>> kernel/power/suspend.c:74: error: implicit declaration of function 'swait_event'
>> kernel/power/suspend.c:74: error: 'suspend_freeze_wait_head' undeclared (first use in this function)
   kernel/power/suspend.c:74: error: (Each undeclared identifier is reported only once
   kernel/power/suspend.c:74: error: for each function it appears in.)
   kernel/power/suspend.c: In function 'freeze_wake':
>> kernel/power/suspend.c:95: error: implicit declaration of function 'swait_wake'
   kernel/power/suspend.c:95: error: 'suspend_freeze_wait_head' undeclared (first use in this function)

vim +32 kernel/power/suspend.c

    26	#include <linux/suspend.h>
    27	#include <linux/syscore_ops.h>
    28	#include <linux/ftrace.h>
    29	#include <trace/events/power.h>
    30	#include <linux/compiler.h>
    31	#include <linux/moduleparam.h>
  > 32	#include <linux/wait-simple.h>
    33	
    34	#include "power.h"
    35	
    36	const char *pm_labels[] = { "mem", "standby", "freeze", NULL };
    37	const char *pm_states[PM_SUSPEND_MAX];
    38	
    39	static const struct platform_suspend_ops *suspend_ops;
    40	static const struct platform_freeze_ops *freeze_ops;
  > 41	static DEFINE_SWAIT_HEAD(suspend_freeze_wait_head);
    42	
    43	enum freeze_state __read_mostly suspend_freeze_state;
    44	static DEFINE_RAW_SPINLOCK(suspend_freeze_lock);
    45	
    46	void freeze_set_ops(const struct platform_freeze_ops *ops)
    47	{
    48		lock_system_sleep();
    49		freeze_ops = ops;
    50		unlock_system_sleep();
    51	}
    52	
    53	static void freeze_begin(void)
    54	{
    55		suspend_freeze_state = FREEZE_STATE_NONE;
    56	}
    57	
    58	static void freeze_enter(void)
    59	{
    60		if (pm_wakeup_pending())
    61			goto out;
    62	
    63		raw_spin_lock_irq(&suspend_freeze_lock);
    64		suspend_freeze_state = FREEZE_STATE_ENTER;
    65		raw_spin_unlock_irq(&suspend_freeze_lock);
    66	
    67		get_online_cpus();
    68		cpuidle_resume();
    69	
    70		/* Push all the CPUs into the idle loop. */
    71		wake_up_all_idle_cpus();
    72		pr_debug("PM: suspend-to-idle\n");
    73		/* Make the current CPU wait so it can enter the idle loop too. */
  > 74		swait_event(suspend_freeze_wait_head,
    75			    suspend_freeze_state == FREEZE_STATE_WAKE);
    76		pr_debug("PM: resume from suspend-to-idle\n");
    77	
    78		cpuidle_pause();
    79		put_online_cpus();
    80	
    81		raw_spin_lock_irq(&suspend_freeze_lock);
    82	
    83	 out:
    84		suspend_freeze_state = FREEZE_STATE_NONE;
    85		raw_spin_unlock_irq(&suspend_freeze_lock);
    86	}
    87	
    88	void freeze_wake(void)
    89	{
    90		unsigned long flags;
    91	
    92		raw_spin_lock_irqsave(&suspend_freeze_lock, flags);
    93		if (suspend_freeze_state > FREEZE_STATE_NONE) {
    94			suspend_freeze_state = FREEZE_STATE_WAKE;
  > 95			swait_wake(&suspend_freeze_wait_head);
    96		}
    97		raw_spin_unlock_irqrestore(&suspend_freeze_lock, flags);
    98	}

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--cWoXeonUoKmBZSoM
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
vP4/LHPH/Fq4AAA=

--cWoXeonUoKmBZSoM--
