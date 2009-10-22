From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: Re: proposed FAQ entry for rt.wiki.kernel.org
Date: Thu, 22 Oct 2009 11:57:20 -0700
Message-ID: <1256237840.10735.46.camel@quadrophenia.thebigcorporation.com>
References: <20091022120832.4bfd29e2@torg>
	 <1256235503.10735.32.camel@quadrophenia.thebigcorporation.com>
	 <20091022134139.0c8a4cc2@torg>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:46991 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756757AbZJVS5R (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 22 Oct 2009 14:57:17 -0400
Received: by pwj1 with SMTP id 1so1607999pwj.21
        for <linux-rt-users@vger.kernel.org>; Thu, 22 Oct 2009 11:57:22 -0700 (PDT)
In-Reply-To: <20091022134139.0c8a4cc2@torg>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2009-10-22 at 13:41 -0500, Clark Williams wrote:
> > Further, user-level processes may be prioritized above device-level
> > services, allowing computational load and I/O load to be dynamically
> > expedited, partitioned, or decoupled.
> 
> You used to work in marketing, didn't you :)
> 

No, but I learned English in Germany :)

> How about:
> 
> Further, using realtime priorities, user-level threads may be
> prioritized *above* certain device level activity, allowing critical
> application tasks to take precedence over device activity deemed less
> important.

Gets the point across.

Cheers,

Sven

