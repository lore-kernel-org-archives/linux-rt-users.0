From: Sven-Thorsten Dietrich <sdietrich@novell.com>
Subject: Re: [PATCH 1/3] mitigate-resched-interrupt-floods
Date: Thu, 26 Jul 2007 01:13:25 -0700
Message-ID: <1185437605.17414.57.camel@sx.thebigcorporation.com>
References: <20070725205814.GA9021@tsunami.ccur.com>
	 <20070726074954.GA18994@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Joe Korty <joe.korty@ccur.com>, tglx@linutronix.de,
	linux-rt-users@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:51042 "EHLO
	victor.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757566AbXGZINd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 26 Jul 2007 04:13:33 -0400
In-Reply-To: <20070726074954.GA18994@elte.hu>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2007-07-26 at 09:49 +0200, Ingo Molnar wrote:
> * Joe Korty <joe.korty@ccur.com> wrote:
> 
> > Mitigate rescheduling interrupt floods.
> 
> makes sense - i've applied it. 

> (please Cc: lkml too for -rt patch 
> submissions in the future - thanks!)
> 

Especially in this case, where the patch is relevant to Linus's tree as
well.

Thanks,

Sven


> 	Ingo
-- 
Sven-Thorsten Dietrich
+1 415 694-2930
( www.novell.com/linux )
