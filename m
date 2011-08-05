From: hermann <brummer-@web.de>
Subject: Re: [ANNOUNCE] 3.0-rt7
Date: Fri, 05 Aug 2011 11:12:22 +0200
Message-ID: <1312535543.2653.5.camel@box>
References: <1312465990.16729.22.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Paul E. McKenney" <paulmck@us.ibm.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from fmmailgate03.web.de ([217.72.192.234]:55118 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756436Ab1HEJMi (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 5 Aug 2011 05:12:38 -0400
In-Reply-To: <1312465990.16729.22.camel@twins>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Am Donnerstag, den 04.08.2011, 15:53 +0200 schrieb Peter Zijlstra:
> Hi,
> 
> With Thomas enjoying his well earned holidays, I hereby present you with
> 3.0-rt7.
> 
> Goodies included since last time:
> 
>  - some raw_spinlock patch from Uwe.
>  - cpupri rework from Rostedt, something which should greatly benefit
>    everybody with smp hardware, the more cpus the more benefit.
>  - a possible fix for some posix timer splat reported by Fernando.
>  - i386-highmem support because I'd already written the code anyway
>    so I thought I might as well make it work.
> 
> I'll take patches implementing similar highmem muck on other arches, if
> there's any code to be shared between the arches, do so.

Hi

Many thanks for enable i386-highmem support, the missing highmem was the
biggest issue I've with the latest 3.0-rt patch. Indeed I run into swap
and therewith receive Xruns from jack. 
I've just switch back to 2.6.39 some hours before you announce -rt7, now
I'm back on 3.0-rt
lucky I'm 

regards
hermann
  

