From: Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH RT 6/9] tty: serial: pl011: explicitly initialize the flags variable
Date: Fri, 21 Dec 2018 09:21:18 -0600
Message-ID: <cbe003d988c3904bb5164e6b83282bafc85f6bd0.1545347029.git.tom.zanussi@linux.intel.com>
References: <cover.1545347029.git.tom.zanussi@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: rostedt@goodmis.org, tglx@linutronix.de, C.Emde@osadl.org,
        jkacur@redhat.com, bigeasy@linutronix.de,
        daniel.wagner@siemens.com, julia@ni.com
To: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1545347029.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1545347029.git.tom.zanussi@linux.intel.com>
References: <cover.1545347029.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

v3.18.129-rt111 rt-stable review patch.  If anyone has any objections,
please let me know.

------------------
From: Kurt Kanzenbach <kurt@linutronix.de>

[ Upstream commit 3260983a587d528811a15fc00fa2a9e4473c4453 ]

Silence the following gcc warning:

drivers/tty/serial/amba-pl011.c: In function ‘pl011_console_write’:
./include/linux/spinlock.h:260:3: warning: ‘flags’ may be used uninitialized in this function [-Wmaybe-uninitialized]
   _raw_spin_unlock_irqrestore(lock, flags); \
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/tty/serial/amba-pl011.c:2214:16: note: ‘flags’ was declared here
  unsigned long flags;
                ^~~~~

The code is correct. Thus, initializing flags to zero doesn't change the
behavior and resolves the warning.

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 drivers/tty/serial/amba-pl011.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 5ef2c62bb904..dede68aa679e 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1930,7 +1930,7 @@ pl011_console_write(struct console *co, const char *s, unsigned int count)
 {
 	struct uart_amba_port *uap = amba_ports[co->index];
 	unsigned int status, old_cr, new_cr;
-	unsigned long flags;
+	unsigned long flags = 0;
 	int locked = 1;
 
 	clk_enable(uap->clk);
-- 
2.14.1
