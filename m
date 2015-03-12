From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 38/39] staging: Mark rtl8821ae as broken
Date: Thu, 12 Mar 2015 15:13:45 -0400
Message-ID: <20150312191413.250256578@goodmis.org>
References: <20150312191307.081068717@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0038-staging-Mark-rtl8821ae-as-broken.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.14.34-rt32-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>

rtl8821ae does not build with a make allmodconfig.

Mark it as broken.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 drivers/staging/rtl8821ae/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/rtl8821ae/Kconfig b/drivers/staging/rtl8821ae/Kconfig
index abccc9dabd65..50a407f71717 100644
--- a/drivers/staging/rtl8821ae/Kconfig
+++ b/drivers/staging/rtl8821ae/Kconfig
@@ -2,6 +2,7 @@ config R8821AE
 	tristate "RealTek RTL8821AE Wireless LAN NIC driver"
 	depends on PCI && WLAN && MAC80211
 	depends on m
+	depends on BROKEN
 	select WIRELESS_EXT
 	select WEXT_PRIV
 	select EEPROM_93CX6
-- 
2.1.4
