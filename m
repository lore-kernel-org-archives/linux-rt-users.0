From: Mike Galbraith <efault@gmx.de>
Subject: [patch-rt] drivers/zram: pass num_pages to
 zram_meta_init_table_locks()
Date: Thu, 19 Oct 2017 06:27:27 +0200
Message-ID: <1508387247.12823.38.camel@gmx.de>
References: <20171017152952.6ab7qsgeqgisqci4@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171017152952.6ab7qsgeqgisqci4@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


zram cleanup forgot to adjust passed argument when changing
zram_meta_init_table_locks() to expect page count instead
of disk size.  Doing so fixes ltp inspired explosions.

Signed-off-by: Mike Galbraith <efault@gmx.de>
---
 drivers/block/zram/zram_drv.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -819,7 +819,7 @@ static bool zram_meta_alloc(struct zram
 		return false;
 	}
 
-	zram_meta_init_table_locks(zram, disksize);
+	zram_meta_init_table_locks(zram, num_pages);
 	return true;
 }
 
