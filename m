From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH v2 1/4] Implement {read,update}_persistent_clock.
Date: Wed, 26 Sep 2007 23:39:26 +0400
Message-ID: <46FAB56E.8080509@ru.mvista.com>
References: <1190345162.620000.305760830507.qpush@thor> <Pine.LNX.4.58.0709261502590.4465@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Tony Breeds <tony@bakeyournoodle.com>, linuxppc-dev@ozlabs.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Paul Mackerras <paulus@samba.org>,
	Realtime Kernel <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:22804 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753099AbXIZTjn (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 26 Sep 2007 15:39:43 -0400
In-Reply-To: <Pine.LNX.4.58.0709261502590.4465@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello.

Steven Rostedt wrote:
> Tony,

> I'm about to release a new -rt patch based on -rc8. This patch series
> blew up totally in trying to get it applied. I'm leaving it out, so after
> I release the next series, could you update these patches.

    No wonder here: the -rt patch already has much of this code since around 
2.6.21.  They have been submitted by me, mostly... and this patchset is 
against the Linus' tree.

WBR, Sergei
