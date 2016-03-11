From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] tty: serial: sc16is7xx: implemented our own oneshot-like
 handling
Date: Fri, 11 Mar 2016 12:21:51 +0100
Message-ID: <20160311112151.GA15693@linutronix.de>
References: <1457692476-19082-1-git-send-email-sean.nyekjaer@prevas.dk>
 <56E29FBA.1060306@prevas.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-serial@vger.kernel.org, Josh Cartwright <joshc@ni.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-rt-users@vger.kernel.org, Jon Ringle <jringle@gridpoint.com>,
	Thomas Gleixner <tglx@linutronix.de>
To: Sean =?utf-8?Q?Nyekj=C3=A6r?= <sean.nyekjaer@prevas.dk>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:36865 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660AbcCKLV5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 11 Mar 2016 06:21:57 -0500
Content-Disposition: inline
In-Reply-To: <56E29FBA.1060306@prevas.dk>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Sean Nyekj=C3=A6r | 2016-03-11 11:36:42 [+0100]:

>Waiting for other comments before fixing :-)

You could start by writting a changelog stating why you think this chan=
ge
is a good idea instead leaving it empty.

>/Sean

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
