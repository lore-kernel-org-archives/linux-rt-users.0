From: "Bryan Wu" <cooloney@kernel.org>
Subject: Re: How to enable CONFIG_PREEMPT_RT on Blackfin (nommu embedded world)?
Date: Thu, 22 May 2008 10:23:59 +0800
Message-ID: <386072610805211923va731394y968efb8f2e483625@mail.gmail.com>
References: <386072610805190035v17a0476ds964fc70241477595@mail.gmail.com>
	 <1211388079.18130.48.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: "Daniel Walker" <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.31]:9798 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbYEVCYV (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 21 May 2008 22:24:21 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1841718ywe.1
        for <linux-rt-users@vger.kernel.org>; Wed, 21 May 2008 19:23:59 -0700 (PDT)
In-Reply-To: <1211388079.18130.48.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, May 22, 2008 at 12:41 AM, Daniel Walker <dwalker@mvista.com> wrote:
>
> On Mon, 2008-05-19 at 15:35 +0800, Bryan Wu wrote:
>> Hi forks,
>>
>> I'm a Blackfin guy. We'd like to enable -rt tree in Blackfin architecture.
>> Could you please provide some hints about that? Any document or URL?
>> I am studing at rt.wiki.kernel.org currently.
>
> Does the non-mmu-ness depend on disabling interrupt or preemption?
>

I am not sure I fully understand your question.
Do you mean NOMMU arch can not enable preemption and -rt tree?

-Bryan
