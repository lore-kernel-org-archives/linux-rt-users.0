From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: [patchlet] locking/rt: fix rt_read_lock() lockdep annotation.
Date: Wed, 07 May 2014 09:54:07 +0200
Message-ID: <1399449247.5142.14.camel@marge.simpson.net>
References: <20140503170110.GA10652@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ee0-f51.google.com ([74.125.83.51]:35393 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905AbaEGHyK (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 7 May 2014 03:54:10 -0400
Received: by mail-ee0-f51.google.com with SMTP id e51so405220eek.38
        for <linux-rt-users@vger.kernel.org>; Wed, 07 May 2014 00:54:09 -0700 (PDT)
In-Reply-To: <20140503170110.GA10652@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


rt-rw-lockdep-annotations.patch missed an rwlock_acquire_read()

Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
---
 kernel/locking/rt.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/kernel/locking/rt.c
+++ b/kernel/locking/rt.c
@@ -244,13 +244,12 @@ void __lockfunc rt_read_lock(rwlock_t *r
 {
 	struct rt_mutex *lock = &rwlock->lock;
 
