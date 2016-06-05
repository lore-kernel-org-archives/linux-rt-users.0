From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: [patch] mm/memcontrol.c::mem_cgroup_migrate() - replace another
 local_irq_disable() w. local_lock_irq()
Date: Sun, 05 Jun 2016 08:11:13 +0200
Message-ID: <1465107073.4263.3.camel@gmail.com>
References: <20160603104424.GA18975@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37546 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751364AbcFEGLT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 5 Jun 2016 02:11:19 -0400
In-Reply-To: <20160603104424.GA18975@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

v4.6 grew a local_irq_disable() in mm/memcontrol.c::mem_cgroup_migrate().
Convert it to use the existing local lock (event_lock) like the others.

Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
---
 mm/memcontrol.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5557,10 +5557,10 @@ void mem_cgroup_migrate(struct page *old
 
 	commit_charge(newpage, memcg, false);
 
-	local_irq_disable();
+	local_lock_irq(event_lock);
 	mem_cgroup_charge_statistics(memcg, newpage, compound, nr_pages);
 	memcg_check_events(memcg, newpage);
-	local_irq_enable();
+	local_unlock_irq(event_lock);
 }
 
 DEFINE_STATIC_KEY_FALSE(memcg_sockets_enabled_key);
