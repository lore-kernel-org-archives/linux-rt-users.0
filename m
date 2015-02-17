From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: problem ethernet board
Date: Tue, 17 Feb 2015 15:12:10 +0100
Message-ID: <20150217141210.GQ26177@linutronix.de>
References: <3b2a-54774480-23-329ce480@51794959>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: Braud Caroline <Caroline.Braud@univ-lille1.fr>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:43870 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753256AbbBQOMM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 17 Feb 2015 09:12:12 -0500
Content-Disposition: inline
In-Reply-To: <3b2a-54774480-23-329ce480@51794959>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Braud Caroline | 2014-11-27 16:34:31 [+0100]:

>Hello,
Hi,

>I have installed RT kernel from:
> http://pengutronix.de/software/linux-rt/debian_en.html
>
>But I have the same problem as this guy (ethernet controller is not working): 
>http://www.spinics.net/lists/linux-rt-users/msg07478.html
>
>except that I'm not using an amd architecture but an Intel one ...
>
>Any idea on how and/or where to get the good headers ?
Are the hints in the thread helping? I would guess the kernel is old and
does not support the network card yet.

>Thanks in advance,
>CB

Sebastian
