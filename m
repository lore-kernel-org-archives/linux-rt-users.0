From: Ingo Molnar <mingo@elte.hu>
Subject: Re: v2.6.20-rt1, yum/rpm
Date: Wed, 7 Feb 2007 13:32:17 +0100
Message-ID: <20070207123217.GA12977@elte.hu>
References: <20070205065636.GA1652@elte.hu> <1170756645.7324.8.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:60295 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030618AbXBGMcD (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 7 Feb 2007 07:32:03 -0500
Content-Disposition: inline
In-Reply-To: <1170756645.7324.8.camel@laptopd505.fenrus.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Arjan van de Ven <arjan@infradead.org> wrote:

> patch below has 2 tweaks
> 1) the new RCU feature wakes up once per second, make sure this is using
> the new round_jiffies() infrastructure
> 2) the slab background reap code is waking up once per 2 seconds per
> cpu. The patch makes this more dynamic; if no work was done (no activity
> on the cpu happened) then this is made to be 4 seconds

thanks, i've applied both tweaks.

	Ingo
