From: <lionel.debieve@st.com>
Subject: [PATCH RT] tty: serial: st-asc: Make the locking RT aware
Date: Tue, 21 Mar 2017 17:05:40 +0100
Message-ID: <1490112340-29772-1-git-send-email-lionel.debieve@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <bigeasy@linutronix.de>, <tglx@linutronix.de>,
        <rostedt@goodmis.org>, Patrice Chotard <patrice.chotard@st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Lionel Debieve <lionel.debieve@st.com>
To: <linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Lionel Debieve <lionel.debieve@st.com>

The lock is a sleeping lock and local_irq_save() is not the
standard implementation now. Working for both -RT and non
RT.

Signed-off-by: Lionel Debieve <lionel.debieve@st.com>
---
 drivers/tty/serial/st-asc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index 379e5bd..1815423 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -803,13 +803,12 @@ static void asc_console_write(struct console *co, const char *s, unsigned count)
 	int locked = 1;
 	u32 intenable;
 
-	local_irq_save(flags);
 	if (port->sysrq)
 		locked = 0; /* asc_interrupt has already claimed the lock */
 	else if (oops_in_progress)
-		locked = spin_trylock(&port->lock);
+		locked = spin_trylock_irqsave(&port->lock, flags);
 	else
-		spin_lock(&port->lock);
+		spin_lock_irqsave(&port->lock, flags);
 
 	/*
 	 * Disable interrupts so we don't get the IRQ line bouncing
@@ -827,8 +826,7 @@ static void asc_console_write(struct console *co, const char *s, unsigned count)
 	asc_out(port, ASC_INTEN, intenable);
 
 	if (locked)
-		spin_unlock(&port->lock);
-	local_irq_restore(flags);
+		spin_unlock_irqrestore(&port->lock, flags);
 }
 
 static int asc_console_setup(struct console *co, char *options)
-- 
2.7.4
