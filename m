From: Reza Roboubi <reza@earthdetails.com>
Subject: Re: disable address translation (virtual/physical)
Date: Sat, 31 Jul 2010 12:34:01 -0700
Message-ID: <AANLkTimV3kfH-MJjRf4DvGKubfEKJA56zxq5Qm7Lrfpt@mail.gmail.com>
References: <AANLkTimfPqKxXvU=xhxaRXdnWU7q7YR2kXQuL+Uk9GB9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:54060 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755556Ab0GaTeE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 31 Jul 2010 15:34:04 -0400
Received: by wyb39 with SMTP id 39so2157846wyb.19
        for <linux-rt-users@vger.kernel.org>; Sat, 31 Jul 2010 12:34:02 -0700 (PDT)
In-Reply-To: <AANLkTimfPqKxXvU=xhxaRXdnWU7q7YR2kXQuL+Uk9GB9@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, Jul 31, 2010 at 7:19 AM, Reza Roboubi <reza@earthdetails.com> w=
rote:
> Can we turn off address translation overheads (let's say with
> something like SCHED_FIFO?) =A0That's really all I want, as opposed t=
o
> RT interrupt handling.

Looks like HUGE pages is the way to do it.  How do I find out the TLB
entry count available for HUGE page use?

Reza.
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
