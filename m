From: Darren Hart <dvhart@linux.intel.com>
Subject: Re: [ANNOUNCE] 3.0-rt3
Date: Mon, 25 Jul 2011 20:49:27 -0700
Message-ID: <4E2E3947.2040806@linux.intel.com>
References: <alpine.LFD.2.02.1107241223560.2702@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:7304 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752612Ab1GZDtd (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Jul 2011 23:49:33 -0400
In-Reply-To: <alpine.LFD.2.02.1107241223560.2702@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On 07/24/2011 03:33 AM, Thomas Gleixner wrote:
> Dear RT Folks,
> 
> I'm pleased to announce the 3.0-rt3 release.
> 
> Changes versus 3.0-rt2:
> 
>   * Fix earlyprintk really


Confirmed. The following kernel boot parameters now work correctly together:

"console=tty0 console=ttyS1,115200n8 earlyprintk=ttyS1,115200"

Thanks Thomas,

-- 
Darren Hart
Intel Open Source Technology Center
Yocto Project - Linux Kernel
