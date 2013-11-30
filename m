From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: [PATCH 0/4] migration cleanup patches
Date: Sat, 30 Nov 2013 04:05:56 +0100
Message-ID: <20131130030556.GA8101@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hofr.at ([212.69.189.236]:54084 "EHLO mail.hofr.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750933Ab3K3DF6 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 29 Nov 2013 22:05:58 -0500
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi !

 These patches are migrate_disable/enable cleanups only
 basically migrate_disabe/enable is in all of the locking primitives because
 it is not known (or not differenciatable) if the lock is protecting a per
 cpu object or not - so all lock primitives that potentially could also be 
 used for concurrency management of per cpu objects must include 
 migrate_disable/enable to make them safely preemptible (it could get pushed 
 of the cpu and the reference would then be invalid). 

 The location of the migration though is prety much irrelevant as long as the
 access is ensured to be while holding the lock and migration being disabled.
 Locking/migrate_disable patters thus can be any of:

  lock/disable  access  enable/unlock
  disable/lock  access  unlock/enable
  disable/lock  access  enable/unlock
  lock/disable  access  unlock/enable

 Based on this the migrate_disable is pushed down to the latest point before
 signaling a successfully acquired lock

 Further more the first migrate_disable of the task will try to push the task 
 of the CPU before actually disabling migration. For cases of unsuccessful
 lock acquisition this would lead to unnecessary migration of task like in

        int __locked;                           \
        migrate_disable();                      \
        __locked = spin_do_trylock(lock);       \
        if (!__locked)                          \
                migrate_enable();               \
        __locked;                               \

 This patch set pushes the migrate_disable down to the end of the success
 path in the different trylock primitives. 

 patchs are on top of 3.12-rt4

 No change of functional behavior

Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>
