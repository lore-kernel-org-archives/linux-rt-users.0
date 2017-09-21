From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: RT kernel on Acer laptop unreliable
Date: Thu, 21 Sep 2017 14:57:32 +0200
Message-ID: <20170921125732.nlmqejvuugxqj4ne@linutronix.de>
References: <56cb9f42-83e3-6648-2489-7c9e486c8ecc@jajcus.net>
 <20170818124406.6cem4po52xrzi5qc@linutronix.de>
 <b1209f35-67a2-5cb2-d0e1-ad142b34aab9@jajcus.net>
 <20170821131254.5nuacfv62d3l4rhe@linutronix.de>
 <52e67cfd-0bb3-ce97-7b28-f2afb1d3c1cb@jajcus.net>
 <20170905091712.koywolqt5qwaslpk@linutronix.de>
 <6def1dd2-eaae-a5d2-8bdb-26070ee5de7a@jajcus.net>
 <99107e1e-3013-b90d-40fb-f7f245960af5@jajcus.net>
 <20170911071738.5e42rw2zrtcnx3lg@linutronix.de>
 <c3db738d-81e8-897b-bf22-8384bd46d27d@jajcus.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: linux-rt-users@vger.kernel.org
To: Jacek Konieczny <jajcus@jajcus.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:35729 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751436AbdIUM5e (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 21 Sep 2017 08:57:34 -0400
Content-Disposition: inline
In-Reply-To: <c3db738d-81e8-897b-bf22-8384bd46d27d@jajcus.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-09-14 21:11:24 [+0200], Jacek Konieczny wrote:
> On 2017-09-11 09:17, Sebastian Andrzej Siewior wrote:
> > On 2017-09-10 14:49:24 [+0200], Jacek Konieczny wrote:
> >> I have been running it for a few days and no problems here. It seems
> >> this fixed the locking problem for me.
> > 
> > Okay. Can you try without lockdep, please?
> 
> I have been using it for a few days now – still no crashes or lockups
> here and performance seems significantly better without lockdep
> (subjective feel, I have not measured it).

yes, without lockdep the performance is way better. But it is needed for
debugging :)

> Thanks for the patches!

Thanks for the confirmation that it is working now.

> Jacek

Sebastian
