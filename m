From: Rahul Kumar <mailforgroup@gmail.com>
Subject: Compilation Issues with patch
Date: Sat, 17 Jul 2010 00:01:14 -0400
Message-ID: <AANLkTimvT47mTnrAAZxUjQCKzj3IDP-dN2fwC2bCzl6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:48680 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699Ab0GQEBR (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 17 Jul 2010 00:01:17 -0400
Received: by wyb42 with SMTP id 42so2513678wyb.19
        for <linux-rt-users@vger.kernel.org>; Fri, 16 Jul 2010 21:01:16 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I have applied the patch patch-2.6.21-rt8 to linux-2.6.21
with the command:patch < patch-2.6.21-rt8 -p1

Does any one have any idea on how to resolve this issue.
I have very limited knowledge on data structures that is used. So, I'm
reluctant to change any code.
Please let me know if i'm missing some thing.

In file included from include/linux/spinlock.h:100,
                 from include/linux/signal.h:9,
                 from arch/powerpc/kernel/asm-offsets.c:16:
include/linux/spinlock_types.h:38: error: expected
specifier-qualifier-list before '__raw_spinlock_t'
include/linux/spinlock_types.h:49: error: conflicting types for 'raw_spinlock_t'
include/linux/spinlock_types_up.h:25: error: previous declaration of
'raw_spinlock_t' was here
include/linux/spinlock_types.h:54: error: expected
specifier-qualifier-list before '__raw_rwlock_t'
include/linux/spinlock_types.h:65: error: conflicting types for 'raw_rwlock_t'
include/linux/spinlock_types_up.h:33: error: previous declaration of
'raw_rwlock_t' was here
In file included from include/linux/signal.h:9,
                 from arch/powerpc/kernel/asm-offsets.c:16:
include/linux/spinlock.h: In function 'double_spin_lock':
include/linux/spinlock.h:291: warning: implicit declaration of
function '_spin_lock'
include/linux/spinlock.h: In function 'raw_double_spin_unlock':
include/linux/spinlock.h:312: warning: implicit declaration of
function '_spin_unlock'
In file included from include/linux/time.h:7,
                 from include/linux/timex.h:57,
                 from include/linux/sched.h:52,
                 from arch/powerpc/kernel/asm-offsets.c:17:
include/linux/seqlock.h: In function '__write_tryseqlock':
include/linux/seqlock.h:102: warning: implicit declaration of function
'_spin_trylock'
include/linux/seqlock.h: In function '__read_seqretry':
include/linux/seqlock.h:139: warning: implicit declaration of function
'_spin_lock_irqsave'
include/linux/seqlock.h:140: warning: implicit declaration of function
'_spin_unlock_irqrestore'
In file included from include/linux/fs.h:279,
                 from include/linux/mm.h:15,
                 from include/linux/mman.h:14,
                 from arch/powerpc/kernel/asm-offsets.c:22:
include/linux/lock_list.h: In function 'INIT_LOCK_LIST_HEAD':
include/linux/lock_list.h:35: warning: implicit declaration of
function 'spin_lock_init'
