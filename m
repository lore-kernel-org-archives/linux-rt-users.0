From: Jacek Konieczny <jajcus@jajcus.net>
Subject: Re: RT kernel on Acer laptop unreliable
Date: Thu, 14 Sep 2017 21:11:24 +0200
Message-ID: <c3db738d-81e8-897b-bf22-8384bd46d27d@jajcus.net>
References: <8c1a0cb6-d90c-1f6f-2d23-9865a17b379e@jajcus.net>
 <20170807131937.ijj7n4yuk6inds4h@linutronix.de>
 <56cb9f42-83e3-6648-2489-7c9e486c8ecc@jajcus.net>
 <20170818124406.6cem4po52xrzi5qc@linutronix.de>
 <b1209f35-67a2-5cb2-d0e1-ad142b34aab9@jajcus.net>
 <20170821131254.5nuacfv62d3l4rhe@linutronix.de>
 <52e67cfd-0bb3-ce97-7b28-f2afb1d3c1cb@jajcus.net>
 <20170905091712.koywolqt5qwaslpk@linutronix.de>
 <6def1dd2-eaae-a5d2-8bdb-26070ee5de7a@jajcus.net>
 <99107e1e-3013-b90d-40fb-f7f245960af5@jajcus.net>
 <20170911071738.5e42rw2zrtcnx3lg@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from tropek.jajcus.net ([31.179.132.94]:58504 "EHLO
        tropek.jajcus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751682AbdINTLf (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 14 Sep 2017 15:11:35 -0400
In-Reply-To: <20170911071738.5e42rw2zrtcnx3lg@linutronix.de>
Content-Language: en-GB
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-09-11 09:17, Sebastian Andrzej Siewior wrote:
> On 2017-09-10 14:49:24 [+0200], Jacek Konieczny wrote:
>> I have been running it for a few days and no problems here. It seems
>> this fixed the locking problem for me.
> 
> Okay. Can you try without lockdep, please?

I have been using it for a few days now – still no crashes or lockups
here and performance seems significantly better without lockdep
(subjective feel, I have not measured it).

Thanks for the patches!

Jacek
