From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: [rfc patch 0/2]  Kill hotplug_lock()/hotplug_unlock()
Date: Tue, 05 Apr 2016 14:49:38 +0200
Message-ID: <1459860578.7776.0.camel@gmail.com>
References: <1455318168-7125-1-git-send-email-bigeasy@linutronix.de>
	 <1455318168-7125-4-git-send-email-bigeasy@linutronix.de>
	 <1458463425.3908.5.camel@gmail.com> <1458814024.23732.35.camel@gmail.com>
	 <alpine.DEB.2.11.1603241140510.3978@nanos>
	 <1459405903.14336.64.camel@gmail.com>
	 <20160401211105.GE29603@linutronix.de> <1459566735.3779.36.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459566735.3779.36.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This is my stab at whacking $subject without adding any duct tape.  My
desktop box has run a thousand iterations of Steven's hotplug stress
script accompanied with stockfish, futextest, hackbench and tbench to
give hotplug lots of opportunity to prove this broken.  So far, it has
failed.  64 core DL980 is nowhere near as quick at iteration increment,
but has been happily chugging along all the while.

Patches are against 4.6-rc2-rt13.  Barring any frozen projectiles
lobbed by either humans or hotplug, I'll see what a backport to 4.4-rt
would look like.  This one has lots of minus signs.

patch1:
 kernel/cpu.c |  267 ++++++++++-------------------------------------------------
 1 file changed, 47 insertions(+), 220 deletions(-)
patch2:
 kernel/locking/rtmutex.c |   37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)
