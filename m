From: Klaas van Gend <klaas.van.gend@mvista.com>
Subject: Re: preempt rt in commercial use
Date: Wed, 15 Sep 2010 10:59:22 +0200
Message-ID: <201009151059.23039.klaas.van.gend@mvista.com>
References: <AANLkTinUYXDM_pGoJTd3veNNfYzWVu3Obv8v4RAL0urq@mail.gmail.com> <AANLkTi=v_vgk=QwCZPDZWVp+z57_jaPc5=CCnA0Wfmr_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Raz <raziebe@gmail.com>,
	"linux-rt-users" <linux-rt-users@vger.kernel.org>
To: jordan <triplesquarednine@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:61151 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751699Ab0IOI7b (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 15 Sep 2010 04:59:31 -0400
Received: by gxk23 with SMTP id 23so2660341gxk.19
        for <linux-rt-users@vger.kernel.org>; Wed, 15 Sep 2010 01:59:30 -0700 (PDT)
In-Reply-To: <AANLkTi=v_vgk=QwCZPDZWVp+z57_jaPc5=CCnA0Wfmr_@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wednesday 15 September 2010 05:38:49 jordan wrote:
>
> Which leads me to my last example. Most people are aware that since
> about 1999-2000, Linux has dominated the movie industry. Beginning
> with Titanic and even today with say, Avatar.
> 
> I would be willing to bet, that all of those wonderful rendering farms
> and production suites, are
> in fact using rt-linux.


Please put a lot of money on that bet, because I'd like to win it :-)

Why would those rendering farms use rt-linux?

Rendering is not done in real-time - far from it actually. It can take minutes 
of the entire farm to render a single frame. So rendering is nothing but CPU-
intensive (calculating how all those lightbeams are reflected by each surface) 
- and everything I/O bound is about throughput: writing the rendered pixels to 
disk and getting more surfaces from disk.

There are no deadlines for rendering, there are no penalties if a frame is 
late by seconds - if the farm cannot complete its job overnight, they'll add 
more CPU power.


-- 
Klaas van Gend
Senior Solutions Architect, MontaVista Software LLC

phone: +31 40 2801386
