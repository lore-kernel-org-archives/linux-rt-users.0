From: John Kacur <jkacur@redhat.com>
Subject: Re: Best gcc flags?
Date: Fri, 22 Jan 2010 23:09:41 +0100
Message-ID: <520f0cf11001221409t2eda34e6kae393afde012d6fc@mail.gmail.com>
References: <5bdc1c8b1001221054g406baa9cp226a478be7342c0e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: RT <linux-rt-users@vger.kernel.org>
To: Mark Knecht <markknecht@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:2280 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752789Ab0AVWJm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Jan 2010 17:09:42 -0500
Received: by ey-out-2122.google.com with SMTP id d26so423185eyd.19
        for <linux-rt-users@vger.kernel.org>; Fri, 22 Jan 2010 14:09:41 -0800 (PST)
In-Reply-To: <5bdc1c8b1001221054g406baa9cp226a478be7342c0e@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Jan 22, 2010 at 7:54 PM, Mark Knecht <markknecht@gmail.com> wro=
te:
> Hi,
> =A0 I've got a new Intel Core i5-661 machine that I'm loading Gentoo
> on. I wonder if anyone here has any strong opinion son the best gcc
> options for this sort of machine and specifically what makes for the
> best rt performance?
>

AFAIK, there are no -rt specific requirements for gcc, just use what yo=
u
would normally use.

John
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
