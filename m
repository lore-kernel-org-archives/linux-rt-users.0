From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH v2 3/4] Implement clockevents driver for powerpc
Date: Wed, 24 Oct 2007 16:07:41 +0400
Message-ID: <471F358D.7070300@ru.mvista.com>
References: <20070921032603.0D3EA32C887@thor>	<4713A616.3090103@ru.mvista.com>	<18195.64334.985238.848522@cargo.ozlabs.ibm.com>	<47161C38.2070305@ru.mvista.com>	<18198.44590.721412.314409@cargo.ozlabs.ibm.com>	<471777BD.8090800@ru.mvista.com>	<18200.3600.459275.823335@cargo.ozlabs.ibm.com>	<47189EF3.7010103@ru.mvista.com>	<18200.42194.853246.935329@cargo.ozlabs.ibm.com> <4718B287.20306@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Realtime Kernel <linux-rt-users@vger.kernel.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:31649 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757210AbXJXMHd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 24 Oct 2007 08:07:33 -0400
In-Reply-To: <4718B287.20306@ru.mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello, I wrote:

>>>   The only thing I'm still unusre about is that deterministic accounting. 
>>>Could you point me at the patch which deals with this (at least for System 390 

>>See efe567fc8281661524ffa75477a7c4ca9b466c63 in Linus' tree, and look

>     Wait, how this is related to the hrtimer's event handlers not being able 
> to call account_process_time() from arch/powerpc/kernel/time.c instead of 
> update_process_timess()?

    I've just realized that I've missed the call to account_process_time() in 
the new timer_interrupt(). :-<
    Anyway, this leads to each tick being accounted twice if the deterministic 
accounting is not enabled -- first by timer_interrupt() and then by the 
hrtimers core, doesn't it?

WBR, Sergei
