From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: locking changes in tty broke low latency feature
Date: Thu, 20 Feb 2014 17:06:08 -0500
Message-ID: <53067C50.9010708@hurleysoftware.com>
References: <20140219230623.736E8406062@ip-64-139-1-69.sjc.megapath.net> <53056E99.9070900@hurleysoftware.com> <53064672.3000807@hurleysoftware.com> <le5laq$40s$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-rt-users@vger.kernel.org,
	Hal Murray <murray+fedora@ip-64-139-1-69.sjc.megapath.net>,
	One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
	Stanislaw Gruszka <sgruszka@redhat.com>
To: Grant Edwards <grant.b.edwards@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:57725 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751350AbaBTWGN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 20 Feb 2014 17:06:13 -0500
In-Reply-To: <le5laq$40s$1@ger.gmane.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 02/20/2014 02:33 PM, Grant Edwards wrote:
> On 2014-02-20, Peter Hurley <peter@hurleysoftware.com> wrote:
>> Sender completes 2000 loops in 160ms total run time;
>> that's 80us average per complete round-trip.
>
> If I understand correctly, that 80us _includes_ the actual time for
> the bits on the wire (which means the actual "baud rate" involved is
> high enough that it's negligible).

Yes, 80us includes the transmit time.

>> I think this shows that low_latency is unnecessary and should
>> just be removed/ignored by the tty core.
>
> If that's the sort of latency that you get for typical kernel
> configurations for typical distros, then I agree that the low_latency
> flag is not needed by the tty later.

Stock ubuntu kernel config but preempt and 250hz (and debugging stuff).

> However, it might still be useful for the lower-level tty or
> serial-core driver to control CPU usage vs. latency trade-offs (for
> exaple, one of my drivers uses it to decide where to set the rx FIFO
> threshold).

Sure, it could be left for driver consumption.

Regards,
Peter Hurley

