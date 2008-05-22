From: Daniel Walker <dwalker@mvista.com>
Subject: Re: How to enable CONFIG_PREEMPT_RT on Blackfin (nommu embedded
	world)?
Date: Thu, 22 May 2008 08:17:14 -0700
Message-ID: <1211469434.18130.62.camel@localhost.localdomain>
References: <386072610805190035v17a0476ds964fc70241477595@mail.gmail.com>
	 <1211388079.18130.48.camel@localhost.localdomain>
	 <386072610805211923va731394y968efb8f2e483625@mail.gmail.com>
	 <1211423981.18130.59.camel@localhost.localdomain>
	 <386072610805220115l8a03d86yac1b47ed3a9c45e4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Bryan Wu <cooloney@kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:12745 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752596AbYEVPRQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 22 May 2008 11:17:16 -0400
In-Reply-To: <386072610805220115l8a03d86yac1b47ed3a9c45e4@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Thu, 2008-05-22 at 16:15 +0800, Bryan Wu wrote:
> 
> AFAIK, there is no such requirement in NOMMU. But for Blackfin, there
> are some silicon anomaly which
> requires to turn off the interrupt.

Then I would think porting to blackfin would be the same as porting to
the other architectures.

> Is there any other nommu folks who enabled the -rt tree on their NOMMU machine?
> Maybe ARM-NOMMU or SH-NOMMU.

None, that I know of.

Daniel

