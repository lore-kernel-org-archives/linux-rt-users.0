From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH v2 3/4] Implement clockevents driver for powerpc
Date: Wed, 17 Oct 2007 18:34:33 +0400
Message-ID: <47161D79.6000003@ru.mvista.com>
References: <20070921032603.0D3EA32C887@thor>	<4713A616.3090103@ru.mvista.com> <18195.64334.985238.848522@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Tony Breeds <tony@bakeyournoodle.com>, linuxppc-dev@ozlabs.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Realtime Kernel <linux-rt-users@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:32215 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759698AbXJQOeV (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 17 Oct 2007 10:34:21 -0400
In-Reply-To: <18195.64334.985238.848522@cargo.ozlabs.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello.

Paul Mackerras wrote:

>>    I'd use (evt - 1) since the interrupt gets generated at 0xffffffff count, 
>>not 0 (on classic CPUs).  With you removing of the code that compensated for 

> See commit d968014b7280e2c447b20363e576999040ac72ef; I already fixed
> that.

    BTW, while fixing that for classic PPC, but you've broke it for 40x / book 
E CPU which interrupt at 0.  Congratulations. :-)

WBR, Sergei
