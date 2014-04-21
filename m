From: Stanislav Meduna <stano@meduna.org>
Subject: Re: WAS: linux-rt fails to boot on > 3.12.5.-rt7 ... NOW IS: linux-rt-3.14
 boots by reverting patches
Date: Mon, 21 Apr 2014 10:48:34 +0200
Message-ID: <5354DB62.7010503@meduna.org>
References: <CAOcfFMxc=Ldp_bvvz228_8C9SxqbCbfgzaAjBrf4n2oigG7_wg@mail.gmail.com> <CAOcfFMynnyHL_G6Gez_AZYFky=hLYeoyY8WVHF572RZq1g_aBw@mail.gmail.com> <CAP=VYLrHC3TPAixV8m0u9g8ooyiE0jvS=7bFLHDdCwt3wsA1iA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>,
	jordan <triplesquarednine@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:38426 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750824AbaDUIsp (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 Apr 2014 04:48:45 -0400
In-Reply-To: <CAP=VYLrHC3TPAixV8m0u9g8ooyiE0jvS=7bFLHDdCwt3wsA1iA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 19.04.2014 15:48, Paul Gortmaker wrote:

> I've got some AMD kit that has just been freed up from winter
> heating duty - sometime later this week I should be able to try to
> reproduce what you have seen, and knowing it works w/o the above
> softirq patch monkeying around should be a good lead on this.

After reverting the patches my box experiencing
  http://www.spinics.net/lists/linux-rt-users/msg11655.html
was stable with no more BUGs running for some 2,5 days with
our application plus a cyclictest.

Note: my configuration is an embedded ARM (i.MX28) using periodic
ticks, so this is probably neither nohz nor AMD stuff only.

Thanks
-- 
                                                 Stano

