From: =?UTF-8?Q?Sean_Nyekj=c3=a6r?= <sean.nyekjaer@prevas.dk>
Subject: Re: [PATCH] tty: serial: sc16is7xx: implemented our own oneshot-like
 handling
Date: Fri, 11 Mar 2016 12:29:45 +0100
Message-ID: <56E2AC29.1060607@prevas.dk>
References: <1457692476-19082-1-git-send-email-sean.nyekjaer@prevas.dk>
 <56E29FBA.1060306@prevas.dk> <20160311112151.GA15693@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <linux-serial@vger.kernel.org>, Josh Cartwright <joshc@ni.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<linux-rt-users@vger.kernel.org>,
	Jon Ringle <jringle@gridpoint.com>,
	Thomas Gleixner <tglx@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail01.prevas.se ([62.95.78.3]:48470 "EHLO mail01.prevas.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751534AbcCKL3s (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 11 Mar 2016 06:29:48 -0500
In-Reply-To: <20160311112151.GA15693@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On 2016-03-11 12:21, Sebastian Andrzej Siewior wrote:
> * Sean Nyekj=C3=A6r | 2016-03-11 11:36:42 [+0100]:
>
>> Waiting for other comments before fixing :-)
> You could start by writting a changelog stating why you think this ch=
ange
> is a good idea instead leaving it empty.
Cool down a bit ;-)

It's left empty because I have been encouraged by Josh and Jakub to mak=
e=20
this PATCH.
I have not seen any problems after simply dropping the IRQ_ONESHOT flag=
,=20
but they proposed this fix.

>> /Sean
> Sebastian
/Sean
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
