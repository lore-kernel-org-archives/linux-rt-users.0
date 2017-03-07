From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 08/10] rt: Drop the removal of _GPL from rt_mutex_destroy()s EXPORT_SYMBOL
Date: Tue, 07 Mar 2017 16:20:49 -0500
Message-ID: <20170307212314.324699775@goodmis.org>
References: <20170307212041.431615000@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0008-rt-Drop-the-removal-of-_GPL-from-rt_mutex_destroy-s-.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.4.50-rt63-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

What we have now should be enough, the EXPORT_SYMBOL statement for
rt_mutex_destroy() is not required.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/locking/rtmutex.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 56f5f1a9baf8..0e9a6260441d 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -2216,7 +2216,8 @@ void rt_mutex_destroy(struct rt_mutex *lock)
 	lock->magic = NULL;
 #endif
 }
-EXPORT_SYMBOL(rt_mutex_destroy);
+
+EXPORT_SYMBOL_GPL(rt_mutex_destroy);
 
 /**
  * __rt_mutex_init - initialize the rt lock
-- 
2.10.2
