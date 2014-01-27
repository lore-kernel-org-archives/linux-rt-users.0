From: =?iso-8859-1?Q?Sami_Pietik=E4inen?= <Sami.Pietikainen@wapice.com>
Subject: RE: Crash in TCP/IP stack
Date: Mon, 27 Jan 2014 07:20:27 +0000
Message-ID: <EBD2DE4ADA47B94E831AED12A4B0CADA844C338D@edb1.wapice.localdomain>
References: <EBD2DE4ADA47B94E831AED12A4B0CADA76D06990@edb1.wapice.localdomain>
 <20140124125639.GC10264@linutronix.de> <20140125114455.GA16350@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"Jouko Haapaluoma" <jouko.haapaluoma@wapice.com>
To: Nicholas Mc Guire <der.herr@hofr.at>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wapice.fi ([81.209.51.2]:46801 "EHLO brando.wapice.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750895AbaA0HUc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 27 Jan 2014 02:20:32 -0500
In-Reply-To: <20140125114455.GA16350@opentech.at>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>No test/confirmation for v3.6 though - if needed I can give it a spin

>thx!
>hofrat

I have been using the fix with 3.6.9-rt21 kernel (Atmel SAMA5D35) for a=
 couple of weeks now, and have not encountered the issue. This kernel I=
 am using is, however, from Atmel linux4sam github repository so it is =
not 100% mainline.

BR,
Sami Pietik=E4inen

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
