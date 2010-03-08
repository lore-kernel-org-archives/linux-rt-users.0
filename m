From: Carsten Emde <Carsten.Emde@osadl.org>
Subject: Re: [PATCH] cyclictest: Use symbolic names for scheduling policy
Date: Mon, 08 Mar 2010 14:01:08 +0100
Message-ID: <4B94F514.5090605@osadl.org>
References: <1268011104-22451-1-git-send-email-jkacur@redhat.com>	 <1268011104-22451-3-git-send-email-jkacur@redhat.com>	 <4B94B6E1.2060400@osadl.org> <520f0cf11003080448o64b6f8b1nd43be217dcc8fcad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Clark Williams <williams@redhat.com>,
	rt-users <linux-rt-users@vger.kernel.org>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:38502 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753549Ab0CHNK0 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Mar 2010 08:10:26 -0500
In-Reply-To: <520f0cf11003080448o64b6f8b1nd43be217dcc8fcad@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi John,

>> [..]
>> We need to adapt the help message accordingly.
> Hmnn, not sure if I like this one. The message is not perfect as it
> stands, but I don't think this is an improvement.
> The code seems to parse, fifo, rr, and other.
> Internally the numbers are as specified, but we're not parsing them anyway.
The original help message says:

-y POLI  --policy=POLI     policy of realtime thread (1:FIFO, 2:RR)
                           format: --policy=fifo(default) or --policy=rr

This *could* be understood that "-y 2" would be a legal way to specify
SCHED_RR, but it is not. Shouldn't we at least remove the "(1:FIFO,
2:RR)" part?

	Carsten.
