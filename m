From: Jan de Kruyf <jan.de.kruyf@gmail.com>
Subject: Re: Filesystem lockup with CONFIG_PREEMPT_RT
Date: Tue, 8 Jul 2014 10:03:01 +0200
Message-ID: <CAA85NCg3NRwkupqbr+Krv3=ySp8EhFH_wKO2F1rB56yCz-vEsQ@mail.gmail.com>
References: <CAA85NCgJPczdQ0mhH3n6cwuZ0kTT-ZFayn3RAjpGAJOB3AM47g@mail.gmail.com>
	<CANGgnMZ9rCD1nyrBNa41AHsrYDLoGn8=aOrRP9T0Rfp1oeC4VA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: rt-users <linux-rt-users@vger.kernel.org>, austin@peloton-tech.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43]:33585 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927AbaGHIDC (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 8 Jul 2014 04:03:02 -0400
Received: by mail-qg0-f43.google.com with SMTP id z60so4653378qgd.2
        for <linux-rt-users@vger.kernel.org>; Tue, 08 Jul 2014 01:03:01 -0700 (PDT)
In-Reply-To: <CANGgnMZ9rCD1nyrBNa41AHsrYDLoGn8=aOrRP9T0Rfp1oeC4VA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thank you Austin,

One of these days we will have Kernel Day to see what gives with
Thomas's new patches.
In the mean time I get 45usec max latency under heavy disk io with the
3.2 kernel on some cheap 5 years old Foxconn board (1600Meg duo core)
and no midnight surprises, so I am smiling. It averages between 3 and
4 usec.

When did you post that module? I did not spot it going through the
discussion on rt-users.

cheers,

j.


On Mon, Jul 7, 2014 at 6:23 PM, Austin Schuh <austin@peloton-tech.com> wrote:
> On Mon, Jul 7, 2014 at 1:48 AM, Jan de Kruyf <jan.de.kruyf@gmail.com> wrote:
>> does not give the same problem that I experienced with XFS.
>> So there is a hickup between version 3.2-rt and 3.10-rt I would say.
>
> I posted a simple kernel module that reliably triggers the lockup by
> recreating the circumstances in a controlled manner.  Try testing with
> that module.
>
> Austin
