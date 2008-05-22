From: Daniel Walker <dwalker@mvista.com>
Subject: Re: How to enable CONFIG_PREEMPT_RT on Blackfin (nommu embedded
	world)?
Date: Wed, 21 May 2008 19:39:41 -0700
Message-ID: <1211423981.18130.59.camel@localhost.localdomain>
References: <386072610805190035v17a0476ds964fc70241477595@mail.gmail.com>
	 <1211388079.18130.48.camel@localhost.localdomain>
	 <386072610805211923va731394y968efb8f2e483625@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Bryan Wu <cooloney@kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:19510 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757192AbYEVCjn (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 21 May 2008 22:39:43 -0400
In-Reply-To: <386072610805211923va731394y968efb8f2e483625@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Thu, 2008-05-22 at 10:23 +0800, Bryan Wu wrote:
> On Thu, May 22, 2008 at 12:41 AM, Daniel Walker <dwalker@mvista.com> wrote:
> >
> > On Mon, 2008-05-19 at 15:35 +0800, Bryan Wu wrote:
> >> Hi forks,
> >>
> >> I'm a Blackfin guy. We'd like to enable -rt tree in Blackfin architecture.
> >> Could you please provide some hints about that? Any document or URL?
> >> I am studing at rt.wiki.kernel.org currently.
> >
> > Does the non-mmu-ness depend on disabling interrupt or preemption?
> >
> 
> I am not sure I fully understand your question.
> Do you mean NOMMU arch can not enable preemption and -rt tree?

I'm wondering if nommu machines require interrupts or preemption to be
off for different reason, or to handle the fact that there is no mmu.

Daniel 

