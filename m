From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [GIT PULL rcu/urgent] Fixes for RCU regressions in 3.8
Date: Fri, 11 Jan 2013 08:08:13 -0800
Message-ID: <20130111160813.GA14503@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paul.gortmaker@windriver.com, fweisbec@gmail.com,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: mingo@elte.hu
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello, Ingo,

Paul Gortmaker found some problems with no-CBs-CPU support in 3.8
mainline, and kindly supplied fixes.  The first problem is soft-lockup
complaints that can occur on systems running with no-CBs CPUs that have
long periods of time where RCU is completely idle, which can happen on
some embedded systems.  The second problem is a documentation error
for the "rcutree.rcu_nocb_poll" boot parameter.  In this case, Paul Gortmaker
(rightly) noted that the need for "rcutree." was inconsistent with the
"rcu_nocbs=<cpumap>" boot parameter.  The fix therefore to make the boot
parameter named "rcu_nocb_poll".

These problems only affect kernels built with the new CONFIG_RCU_NOCB_CPU
kernel parameter, but still should be fixed.

These fixes are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/urgent

							Thanx, Paul

------------------>
Paul Gortmaker (2):
      rcu: Prevent soft-lockup complaints about no-CBs CPUs
      rcu: Make rcu_nocb_poll an early_param instead of module_param

 Documentation/kernel-parameters.txt |    2 +-
 kernel/rcutree_plugin.h             |   13 ++++++++++---
 2 files changed, 11 insertions(+), 4 deletions(-)
