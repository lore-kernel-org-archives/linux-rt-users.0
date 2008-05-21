From: Daniel Walker <dwalker@mvista.com>
Subject: Re: How to enable CONFIG_PREEMPT_RT on Blackfin (nommu embedded
	world)?
Date: Wed, 21 May 2008 09:41:19 -0700
Message-ID: <1211388079.18130.48.camel@localhost.localdomain>
References: <386072610805190035v17a0476ds964fc70241477595@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Bryan Wu <cooloney@kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:2343 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754793AbYEUQlV (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 21 May 2008 12:41:21 -0400
In-Reply-To: <386072610805190035v17a0476ds964fc70241477595@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Mon, 2008-05-19 at 15:35 +0800, Bryan Wu wrote:
> Hi forks,
> 
> I'm a Blackfin guy. We'd like to enable -rt tree in Blackfin architecture.
> Could you please provide some hints about that? Any document or URL?
> I am studing at rt.wiki.kernel.org currently.

Does the non-mmu-ness depend on disabling interrupt or preemption?

Daniel

