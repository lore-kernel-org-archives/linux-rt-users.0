From: Kirill Tkhai <tkhai@yandex.ru>
Subject: Re: [ANNOUNCE] 3.10.10-rt7
Date: Fri, 30 Aug 2013 21:16:08 +0400
Message-ID: <537051377882968@web17h.yandex.ru>
References: <20130829184228.GD15360@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from forward2h.mail.yandex.net ([84.201.187.147]:33777 "EHLO
	forward2h.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753886Ab3H3RW2 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 30 Aug 2013 13:22:28 -0400
In-Reply-To: <20130829184228.GD15360@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

29.08.2013, 22:42, "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>:
> Dear RT folks!
>
> I'm pleased to announce the v3.10.10-rt7 patch set.
>
> Changes since v3.10.10-rt6
> - hwlat compiles on 32bit (again). Reported by Fernando Lopez-Lezcano=
=2E
> - bcache is disabled due to usage of anon semaphores. Anyone interres=
ted
> =9A=9Ain using it?
> - "genirq affinity callback" are fixed. Reported by Joe Korty. There =
are
> =9A=9Atwo nics using this feature.
> - Paul Gortmaker's swait rename patch has been included.

sparc does not have CONFIG_EARLY_PRINTK option.

So early-printk-consolidate.patch breaks compilation:

arch/sparc/built-in.o: In function `setup_arch':
(.init.text+0x15e4): undefined reference to `early_console'
arch/sparc/built-in.o: In function `setup_arch':
(.init.text+0x15ec): undefined reference to `early_console'

The below addition fixes that.

Signed-off-by: Kirill Tkhai <tkhai@yandex.ru>
---
 arch/sparc/Kconfig |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 9ac9f16..6787bd3 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -521,6 +521,10 @@ menu "Executable file formats"
=20
 source "fs/Kconfig.binfmt"
=20
+config EARLY_PRINTK
+	bool
+	default y
+
 config COMPAT
 	bool
 	depends on SPARC64
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
