From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: rt5, sleeping function called from invalid context
Date: Thu, 28 Jul 2011 12:30:03 -0700
Message-ID: <4E31B8BB.5030300@am.sony.com>
References: <4E31B6F3.80602@am.sony.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: "Rowand, Frank" <Frank_Rowand@sonyusa.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:42770 "EHLO
	TX2EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754606Ab1G1TaZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 28 Jul 2011 15:30:25 -0400
In-Reply-To: <4E31B6F3.80602@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 07/28/11 12:22, Frank Rowand wrote:
> Thomas,
> 
> Here is one of my current BUGs, from rt5 (same panda board, same config):

Oops, that was rt4, plus the compile fix patch for arch/arm/include/asm/mmu.h

-Frank

