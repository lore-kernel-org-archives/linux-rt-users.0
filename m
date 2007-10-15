From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v2 1/4] Implement {read,update}_persistent_clock.
Date: Tue, 16 Oct 2007 09:46:06 +1000
Message-ID: <18195.64446.825842.427068@cargo.ozlabs.ibm.com>
References: <1190345162.620000.305760830507.qpush@thor>
	<Pine.LNX.4.58.0709261502590.4465@gandalf.stny.rr.com>
	<46FAB56E.8080509@ru.mvista.com>
	<Pine.LNX.4.58.0709261543080.5123@gandalf.stny.rr.com>
	<1190836713.23376.41.camel@chaos>
	<4713ABDA.2000506@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tony Breeds <tony@bakeyournoodle.com>, linuxppc-dev@ozlabs.org,
	Realtime Kernel <linux-rt-users@vger.kernel.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:53922 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755937AbXJOXr1 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 15 Oct 2007 19:47:27 -0400
In-Reply-To: <4713ABDA.2000506@ru.mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Sergei Shtylyov writes:

>    Eh... poor you. Tony got clockevent driver reengineered for no apparent 
> reason.  And he's introduced the jiffy drift by deleting the main loop from 
> timer_interrupt().

The main loop in timer_interrupt() became unnecessary, because
update_wall_time contains an equivalent loop.

Paul.
