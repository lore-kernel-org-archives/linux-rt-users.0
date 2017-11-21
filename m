From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 3/8] random: avoid preempt_disable()ed section
Date: Tue, 21 Nov 2017 11:06:57 -0500
Message-ID: <20171121160706.107185478@goodmis.org>
References: <20171121160654.493640386@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, Alex Shi <alex.shi@linaro.org>
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751606AbdKUQHH (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 21 Nov 2017 11:07:07 -0500
Content-Disposition: inline; filename=0003-random-avoid-preempt_disable-ed-section.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

4.4.97-rt111-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

extract_crng() will use sleeping locks while in a preempt_disable()
section due to get_cpu_var().
Work around it with local_locks.

Cc: stable-rt@vger.kernel.org # where it applies to
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 drivers/char/random.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index fecc40a69df8..b41745c5962c 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -260,6 +260,7 @@
 #include <linux/irq.h>
 #include <linux/syscalls.h>
 #include <linux/completion.h>
+#include <linux/locallock.h>
 
 #include <asm/processor.h>
 #include <asm/uaccess.h>
@@ -1796,6 +1797,7 @@ int random_int_secret_init(void)
 
 static DEFINE_PER_CPU(__u32 [MD5_DIGEST_WORDS], get_random_int_hash)
 		__aligned(sizeof(unsigned long));
+static DEFINE_LOCAL_IRQ_LOCK(hash_entropy_int_lock);
 
 /*
  * Get a random word for internal kernel use only. Similar to urandom but
@@ -1811,12 +1813,12 @@ unsigned int get_random_int(void)
 	if (arch_get_random_int(&ret))
 		return ret;
 
-	hash = get_cpu_var(get_random_int_hash);
+	hash = &get_locked_var(hash_entropy_int_lock, get_random_int_hash);
 
 	hash[0] += current->pid + jiffies + random_get_entropy();
 	md5_transform(hash, random_int_secret);
 	ret = hash[0];
-	put_cpu_var(get_random_int_hash);
+	put_locked_var(hash_entropy_int_lock, get_random_int_hash);
 
 	return ret;
 }
@@ -1833,12 +1835,12 @@ unsigned long get_random_long(void)
 	if (arch_get_random_long(&ret))
 		return ret;
 
-	hash = get_cpu_var(get_random_int_hash);
+	hash = &get_locked_var(hash_entropy_int_lock, get_random_int_hash);
 
 	hash[0] += current->pid + jiffies + random_get_entropy();
 	md5_transform(hash, random_int_secret);
 	ret = *(unsigned long *)hash;
-	put_cpu_var(get_random_int_hash);
+	put_locked_var(hash_entropy_int_lock, get_random_int_hash);
 
 	return ret;
 }
-- 
2.13.2


