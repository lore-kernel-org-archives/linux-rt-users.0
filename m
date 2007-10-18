From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH v2 3/4] Implement clockevents driver for powerpc
Date: Thu, 18 Oct 2007 18:48:09 +0400
Message-ID: <47177229.2030200@ru.mvista.com>
References: <20070921032603.0D3EA32C887@thor>	<4713A616.3090103@ru.mvista.com>	<18195.64334.985238.848522@cargo.ozlabs.ibm.com>	<47161D79.6000003@ru.mvista.com> <18198.43687.44059.477047@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Tony Breeds <tony@bakeyournoodle.com>, linuxppc-dev@ozlabs.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Realtime Kernel <linux-rt-users@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:43564 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756207AbXJROr6 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 18 Oct 2007 10:47:58 -0400
In-Reply-To: <18198.43687.44059.477047@cargo.ozlabs.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Paul Mackerras wrote:

>>    BTW, while fixing that for classic PPC, but you've broke it for 40x / book 
>>E CPU which interrupt at 0.  Congratulations. :-)

> What problem do you see arising from this?

    Timers firing too early.

> Paul.

WBR, Sergei
