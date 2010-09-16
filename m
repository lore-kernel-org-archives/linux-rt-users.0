From: Armin Steinhoff <armin@steinhoff.de>
Subject: Re: TinxCore and PREEMPT_RT
Date: Thu, 16 Sep 2010 11:38:38 +0200
Message-ID: <4C91E59E.5010203@steinhoff.de>
References: <AANLkTinUYXDM_pGoJTd3veNNfYzWVu3Obv8v4RAL0urq@mail.gmail.com> <AANLkTi=v_vgk=QwCZPDZWVp+z57_jaPc5=CCnA0Wfmr_@mail.gmail.com> <201009151059.23039.klaas.van.gend@mvista.com> <4C90A814.8020605@steinhoff.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:55301 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752170Ab0IPJgd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 16 Sep 2010 05:36:33 -0400
In-Reply-To: <4C90A814.8020605@steinhoff.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Hi all,

yes, it's running !

TinyCore is very small (10MB) , works with the PREEMPT_RT patch (at 
least version 2.6.29.6), full SMP support and boots in few seconds!
The MicroCore version needs only 6MB ...

--Armin




Armin Steinhoff wrote:
>
> Hi all,
>
> are there any experiences in using the TinyCore distribution as a base 
> for PREEMPT_RT Linux ?
>
> Patching a PREEMPT_RT kernel (2.6.29.6) with the TinyCore patch 
> 2.6.29.1 seems to work ... no error messages so far.
>
>
> --Armin
>
> -- 
> To unsubscribe from this list: send the line "unsubscribe 
> linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

