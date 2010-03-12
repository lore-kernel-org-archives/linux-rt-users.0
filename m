From: John Kacur <jkacur@redhat.com>
Subject: [PATCH] ide: Build break in ide-iops.c
Date: Fri, 12 Mar 2010 13:10:50 +0100
Message-ID: <1268395850-23408-2-git-send-email-jkacur@redhat.com>
References: <1268395850-23408-1-git-send-email-jkacur@redhat.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Wu Zhangjin <wuzhangjin@gmail.com>,
	John Kacur <jkacur@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1268395850-23408-1-git-send-email-jkacur@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

I get the following build break due to 876c52cc046e00eaa2ffc5124dc187106ef57594

drivers/ide/ide-iops.c:29:26: error: asm/bootinfo.h: No such file or directory

Protect the include by #ifdef CONFIG_MIPS

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 drivers/ide/ide-iops.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/ide/ide-iops.c b/drivers/ide/ide-iops.c
index 9dba71e..8d32dda 100644
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -26,7 +26,10 @@
 #include <asm/irq.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
+
+#ifdef CONFIG_MIPS
 #include <asm/bootinfo.h>
+#endif
 
 void SELECT_MASK(ide_drive_t *drive, int mask)
 {
-- 
1.6.6.1
