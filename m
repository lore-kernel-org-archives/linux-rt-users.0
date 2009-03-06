From: Cliff Brake <cliff.brake@gmail.com>
Subject: Re: [Announce] 2.6.29-rc6-rt3
Date: Fri, 6 Mar 2009 17:23:59 -0500
Message-ID: <f96d234e0903061423j4820acefie0cd7d7bf9089b16@mail.gmail.com>
References: <alpine.LFD.2.00.0902112332370.415@localhost.localdomain>
	 <alpine.LFD.2.00.0902122353050.16972@localhost.localdomain>
	 <alpine.LFD.2.00.0902231854360.3523@localhost.localdomain>
	 <alpine.LFD.2.00.0902241849230.3523@localhost.localdomain>
	 <alpine.LFD.2.00.0902241856480.9135@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Carsten Emde <ce@ceag.ch>, Clark Williams <williams@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.234]:34621 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755874AbZCFWYB (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 6 Mar 2009 17:24:01 -0500
Received: by rv-out-0506.google.com with SMTP id g37so698426rvb.1
        for <linux-rt-users@vger.kernel.org>; Fri, 06 Mar 2009 14:23:59 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0902241856480.9135@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Feb 24, 2009 at 12:57 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> We are pleased to announce the next update to our new preempt-rt

What is the issues with JFFS2?

--- linux-2.6-tip.orig/fs/jffs2/Kconfig
+++ linux-2.6-tip/fs/jffs2/Kconfig
@@ -2,6 +2,8 @@ config JFFS2_FS
 	tristate "Journalling Flash File System v2 (JFFS2) support"
 	select CRC32
 	depends on MTD
+	# build breakage
+	depends on 0
 	help
 	  JFFS2 is the second generation of the Journalling Flash File System
 	  for use on diskless embedded devices. It provides improved wear


Thanks,
Cliff
