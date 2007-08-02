From: John Sigler <linux.kernel@free.fr>
Subject: PROFILE_NMI kernel config symbol
Date: Thu, 02 Aug 2007 14:47:42 +0200
Message-ID: <46B1D26E.2010508@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, oprofile-list@lists.sourceforge.net
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp4-g19.free.fr ([212.27.42.30]:59972 "EHLO smtp4-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755487AbXHBMtM (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 2 Aug 2007 08:49:12 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello,

The -rt patch includes the following update:

Index: linux/arch/i386/oprofile/Kconfig
===================================================================
--- linux.orig/arch/i386/oprofile/Kconfig
+++ linux/arch/i386/oprofile/Kconfig
@@ -15,3 +15,6 @@ config OPROFILE

  	  If unsure, say N.

+config PROFILE_NMI
+	bool
+	default y


What is the purpose of the PROFILE_NMI config symbol?
(It does not seem to be used anywhere else in the -rt patch.)

Regards.
