From: Jon Masters <jonathan@jonmasters.org>
Subject: try_module_get and friends
Date: Tue, 04 Mar 2008 00:20:58 -0500
Message-ID: <1204608058.11912.3.camel@perihelion>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from dallas.jonmasters.org ([72.29.103.172]:60559 "EHLO
	dallas.jonmasters.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752208AbYCDFVu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 4 Mar 2008 00:21:50 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Yo,

Ok...so I might just be missing something and you guys will set me right
if that is indeed the case, but...

What's protecting the -RT kernel from assumptions about atomicity of
module symbol references? Specifically, the kernel doesn't normally need
to protect against inter-module symbol references to EXPORT_SYMBOL(s),
however, it requires special protection when a function pointer is being
passed around - that's why we use things like try_module_get. But it is
assumed that it is ok not to do this in atomic contexts.

So, what's protecting the RT kernel from falling over if a CPU frequency
governor module is removed at the wrong moment?

Jon.


