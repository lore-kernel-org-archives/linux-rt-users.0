From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH RT] Revert "crypto: Convert crypto notifier chain to SRCU"
Date: Fri, 27 Jul 2018 14:59:43 +0200
Message-ID: <20180727125943.zc5v5cmez7swonek@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: tglx@linutronix.de, rostedt@goodmis.org,
        Peter Zilstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This reverts commit Revert "crypto: Convert crypto notifier chain to
SRCU".
This is not longer required because the rwsem is now multi reader
capable on RT.
The other concern was a deadlock because the rwsem is fifo writer fair
in regard to incoming reader. This is currently not an issue because we
have only one crypto_register_notifier() user, which is invoked before
the reader (blocking_notifier_call_chain()) are coming.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 crypto/algapi.c   | 4 ++--
 crypto/api.c      | 6 +++---
 crypto/internal.h | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/crypto/algapi.c b/crypto/algapi.c
index 99ed1c74217f..395b082d03a9 100644
--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -726,13 +726,13 @@ EXPORT_SYMBOL_GPL(crypto_spawn_tfm2);
 
 int crypto_register_notifier(struct notifier_block *nb)
 {
-	return srcu_notifier_chain_register(&crypto_chain, nb);
+	return blocking_notifier_chain_register(&crypto_chain, nb);
 }
 EXPORT_SYMBOL_GPL(crypto_register_notifier);
 
 int crypto_unregister_notifier(struct notifier_block *nb)
 {
-	return srcu_notifier_chain_unregister(&crypto_chain, nb);
+	return blocking_notifier_chain_unregister(&crypto_chain, nb);
 }
 EXPORT_SYMBOL_GPL(crypto_unregister_notifier);
 
diff --git a/crypto/api.c b/crypto/api.c
index d4bbeba587f9..70a894e52ff3 100644
--- a/crypto/api.c
+++ b/crypto/api.c
@@ -32,7 +32,7 @@ EXPORT_SYMBOL_GPL(crypto_alg_list);
 DECLARE_RWSEM(crypto_alg_sem);
 EXPORT_SYMBOL_GPL(crypto_alg_sem);
 
-SRCU_NOTIFIER_HEAD(crypto_chain);
+BLOCKING_NOTIFIER_HEAD(crypto_chain);
 EXPORT_SYMBOL_GPL(crypto_chain);
 
 static struct crypto_alg *crypto_larval_wait(struct crypto_alg *alg);
@@ -237,10 +237,10 @@ int crypto_probing_notify(unsigned long val, void *v)
 {
 	int ok;
 
-	ok = srcu_notifier_call_chain(&crypto_chain, val, v);
+	ok = blocking_notifier_call_chain(&crypto_chain, val, v);
 	if (ok == NOTIFY_DONE) {
 		request_module("cryptomgr");
-		ok = srcu_notifier_call_chain(&crypto_chain, val, v);
+		ok = blocking_notifier_call_chain(&crypto_chain, val, v);
 	}
 
 	return ok;
diff --git a/crypto/internal.h b/crypto/internal.h
index 998a6af375d4..5ac27fba10e8 100644
--- a/crypto/internal.h
+++ b/crypto/internal.h
@@ -44,7 +44,7 @@ struct crypto_larval {
 
 extern struct list_head crypto_alg_list;
 extern struct rw_semaphore crypto_alg_sem;
-extern struct srcu_notifier_head crypto_chain;
+extern struct blocking_notifier_head crypto_chain;
 
 #ifdef CONFIG_PROC_FS
 void __init crypto_init_proc(void);
@@ -139,7 +139,7 @@ static inline int crypto_is_moribund(struct crypto_alg *alg)
 
 static inline void crypto_notify(unsigned long val, void *v)
 {
-	srcu_notifier_call_chain(&crypto_chain, val, v);
+	blocking_notifier_call_chain(&crypto_chain, val, v);
 }
 
 #endif	/* _CRYPTO_INTERNAL_H */
-- 
2.18.0
