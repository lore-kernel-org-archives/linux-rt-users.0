From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [patch 2/4] ARM: NO_HZ support
Date: Wed, 20 Dec 2006 10:20:56 +0100
Message-ID: <45890078.4070606@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030405070205010404020200"
Cc: tglx@linutronix.de, David Brownell <david-b@pacbell.net>,
	Daniel Walker <dwalker@mvista.com>,
	Kevin Hilman <khilman@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:21787 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964951AbWLTJU6 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 20 Dec 2006 04:20:58 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2594570nfa
        for <linux-rt-users@vger.kernel.org>; Wed, 20 Dec 2006 01:20:57 -0800 (PST)
To: linux-rt-users@vger.kernel.org
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This is a multi-part message in MIME format.
--------------030405070205010404020200
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

ARM: NO_HZ support

This is an update of the initial patch from Daniel Walker
and Kevin Hilman.

Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>


--------------030405070205010404020200
Content-Type: text/plain;
 name="arm-no-hz-patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="arm-no-hz-patch.txt"

Index: linux-2.6.20-rc1/arch/arm/Kconfig
===================================================================
--- linux-2.6.20-rc1.orig/arch/arm/Kconfig
+++ linux-2.6.20-rc1/arch/arm/Kconfig
@@ -529,6 +529,7 @@ source kernel/Kconfig.preempt
 
 config NO_IDLE_HZ
 	bool "Dynamic tick timer"
+	depends on !GENERIC_CLOCKEVENTS
 	help
 	  Select this option if you want to disable continuous timer ticks
 	  and have them programmed to occur as required. This option saves


--------------030405070205010404020200--
