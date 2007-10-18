From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH v2 1/4] Implement {read,update}_persistent_clock.
Date: Thu, 18 Oct 2007 18:18:33 +0400
Message-ID: <47176B39.1070300@ru.mvista.com>
References: <1190345162.620000.305760830507.qpush@thor> <47162B6F.40903@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Tony Breeds <tony@bakeyournoodle.com>, linuxppc-dev@ozlabs.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Paul Mackerras <paulus@samba.org>,
	Realtime Kernel <linux-rt-users@vger.kernel.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:43394 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S933857AbXJROSW (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 18 Oct 2007 10:18:22 -0400
In-Reply-To: <47162B6F.40903@ru.mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello, I wrote:

>>With these functions implemented we cooperate better with the generic
>>timekeeping code.  This obsoletes the need for the timer sysdev as a bonus.

>     Aha, I'm seeing it's not merged to mainline yet!

    Contrarywise, it's been merged first -- looks like this all happened 
because of me not commenting on the patches in time... :-(
    Now one can only send incremental patches... sigh...

WBR, Sergei
