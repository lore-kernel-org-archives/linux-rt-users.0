From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [ANNOUNCE] 3.6.6-rt17
Date: Wed, 14 Nov 2012 11:56:13 -0800
Message-ID: <50A3F75D.8090105@localhost>
References: <alpine.LFD.2.02.1211122223300.10000@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp1.Stanford.EDU ([171.67.219.81]:43560 "EHLO
	smtp.stanford.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753526Ab2KNUCT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 14 Nov 2012 15:02:19 -0500
In-Reply-To: <alpine.LFD.2.02.1211122223300.10000@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 11/12/2012 01:28 PM, Thomas Gleixner wrote:
> Dear RT Folks,
>
> I'm pleased to announce the 3.6.6-rt17 release. 3.6.6-rt16 is just a
> not announced update release to 3.6.6.

Got this:

----
net/nfc/llcp/llcp.c: In function 'nfc_llcp_register_device':
net/nfc/llcp/llcp.c:1185:24: error: expected expression before '{' token
net/nfc/llcp/llcp.c:1186:35: error: expected expression before '{' token
----

when building with CONFIG_NFC / CONFIG_NFS_LLCP (builds fine when those 
are not set)
-- Fernando


> Changes since 3.6.6-rt16:
>
>     * Finally make the NOHZ softirq pending detection work with the new
>       softirq scheme.
>
>     * Remove the WARN_ON from __raise_softirq_irqoff(). I got the
>       information I want for now.
