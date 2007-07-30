From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH -rt 3/9] Fix jiffies wrap issue in update_times
Date: Mon, 30 Jul 2007 11:25:14 +0200
Message-ID: <20070730092514.GC25640@elte.hu>
References: <20070730024534.369897977@mvista.com> <20070730024719.502748134@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Daniel Walker <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:33253 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933366AbXG3JZZ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 30 Jul 2007 05:25:25 -0400
Content-Disposition: inline
In-Reply-To: <20070730024719.502748134@mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> In prior -rt verisons the last_tick value was called wall_jiffies and 
> was initialized in this same way as below. If this value isn't 
> initialized the calc_load function gets skewed for several minutes 
> right after boot up. Skewed meaning always zero.

thanks, applied.

	Ingo
