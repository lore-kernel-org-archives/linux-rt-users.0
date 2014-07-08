From: Austin Schuh <austin@peloton-tech.com>
Subject: Re: Filesystem lockup with CONFIG_PREEMPT_RT
Date: Tue, 8 Jul 2014 09:09:32 -0700
Message-ID: <CANGgnMbaQtiinErQKB+kDReE_8pQgs2EQWwrAZeTEzmrH9R=PQ@mail.gmail.com>
References: <CAA85NCgJPczdQ0mhH3n6cwuZ0kTT-ZFayn3RAjpGAJOB3AM47g@mail.gmail.com>
 <CANGgnMZ9rCD1nyrBNa41AHsrYDLoGn8=aOrRP9T0Rfp1oeC4VA@mail.gmail.com> <CAA85NCg3NRwkupqbr+Krv3=ySp8EhFH_wKO2F1rB56yCz-vEsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: Jan de Kruyf <jan.de.kruyf@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:56035 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753063AbaGHQJx (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 8 Jul 2014 12:09:53 -0400
Received: by mail-ig0-f178.google.com with SMTP id hn18so844151igb.17
        for <linux-rt-users@vger.kernel.org>; Tue, 08 Jul 2014 09:09:52 -0700 (PDT)
In-Reply-To: <CAA85NCg3NRwkupqbr+Krv3=ySp8EhFH_wKO2F1rB56yCz-vEsQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Jul 8, 2014 at 1:03 AM, Jan de Kruyf <jan.de.kruyf@gmail.com> wrote:
> When did you post that module? I did not spot it going through the
> discussion on rt-users.


https://lkml.org/lkml/2014/6/26/436
