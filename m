From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: Kenrel panic with 3.18.7-rt2 - Was: Kenrel panic with 3.18.7-rt2
 - rootfs at MMC
Date: Mon, 16 Mar 2015 09:22:13 -0400
Message-ID: <20150316132212.GE21256@windriver.com>
References: <20150306174336.2eb1fea9@archlinux>
 <20150306174700.29fc83bf@archlinux>
 <CAP=VYLofi0bYu5Lk+cnxyZ3upv2xueDDvHbO9B4Q8CgxpL0CGA@mail.gmail.com>
 <20150313162658.756416ec@archlinux>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Ralf Mardorf <ralf.mardorf@alice-dsl.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:57059 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753164AbbCPNVx (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 16 Mar 2015 09:21:53 -0400
Content-Disposition: inline
In-Reply-To: <20150313162658.756416ec@archlinux>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

[Re: Kenrel panic with 3.18.7-rt2 - Was: Kenrel panic with 3.18.7-rt2 - rootfs at MMC] On 13/03/2015 (Fri 16:26) Ralf Mardorf wrote:

> On Fri, 13 Mar 2015 10:26:39 -0400, Paul Gortmaker wrote:
> >unless you can capture some of the log with a camera
> 
> Hi,
> 
> in the meanwhile I noticed that 3.14.28-rt25 works on my machine and
> 3.14.34-rt31 already doesn't work on my machine.

Not a lot changed in there ; mostly stable merges, so if you could test
the interim points, that might give a clue as to what happened.

> 
> Can I send a pic as attachment or should I paste a link?

Not sure the list will pass through an attachment that isn't just a
plain text patch or similar; you might need a link instead.

P.
--

> 
> Regards,
> Ralf
