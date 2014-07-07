From: Austin Schuh <austin@peloton-tech.com>
Subject: Re: Filesystem lockup with CONFIG_PREEMPT_RT
Date: Mon, 7 Jul 2014 09:23:32 -0700
Message-ID: <CANGgnMZ9rCD1nyrBNa41AHsrYDLoGn8=aOrRP9T0Rfp1oeC4VA@mail.gmail.com>
References: <CAA85NCgJPczdQ0mhH3n6cwuZ0kTT-ZFayn3RAjpGAJOB3AM47g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: Jan de Kruyf <jan.de.kruyf@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:39740 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751077AbaGGQXx (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 7 Jul 2014 12:23:53 -0400
Received: by mail-ig0-f169.google.com with SMTP id c1so10602376igq.2
        for <linux-rt-users@vger.kernel.org>; Mon, 07 Jul 2014 09:23:53 -0700 (PDT)
In-Reply-To: <CAA85NCgJPczdQ0mhH3n6cwuZ0kTT-ZFayn3RAjpGAJOB3AM47g@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Jul 7, 2014 at 1:48 AM, Jan de Kruyf <jan.de.kruyf@gmail.com> wrote:
> does not give the same problem that I experienced with XFS.
> So there is a hickup between version 3.2-rt and 3.10-rt I would say.

I posted a simple kernel module that reliably triggers the lockup by
recreating the circumstances in a controlled manner.  Try testing with
that module.

Austin
