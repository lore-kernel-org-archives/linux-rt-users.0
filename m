From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: How can I disable VHCI support ?
Date: Tue, 17 Feb 2015 18:19:21 +0100
Message-ID: <20150217171921.GW26177@linutronix.de>
References: <60762.90.32.177.45.1420561634.squirrel@webmail.etud.univ-ubs.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: Vegara Dorian <vegara.e1300478@etud.univ-ubs.fr>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:44444 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895AbbBQRTX (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 17 Feb 2015 12:19:23 -0500
Content-Disposition: inline
In-Reply-To: <60762.90.32.177.45.1420561634.squirrel@webmail.etud.univ-ubs.fr>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Vegara Dorian | 2015-01-06 17:27:14 [+0100]:

>Hello,
Hi,

>I'm trying to patch my Linux with RT Linux 3.14.25. The installation has
>been successfully done, but problems appeared when I typed this command :
>
>" make modules_install ".
>
>The error message is : Module 'hci_vhci' has devname (vhci) but lacks
>major and minor information. Ignoring.
>
>How can I fix this bug ? I don't want Bluetooth. So I think I can disable
>VHCI.
This does not look -RT related or serious. Have you tried asking google?
I bet that you are not the first one with this message.

>Thanks a lot,
>Best regards
>
>Dorian VEGARA

Sebastian
