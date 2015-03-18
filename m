From: Joakim Hernberg <jhernberg@alchemy.lu>
Subject: Re: [ANNOUNCE] 3.18.9-rt5
Date: Wed, 18 Mar 2015 10:56:28 +0100
Message-ID: <20150318105628.19ac6d74@balder.valhalla.alchemy.lu>
References: <20150316210146.GG28130@linutronix.de>
	<20150318100817.73a5e32a@archlinux>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt users <linux-rt-users@vger.kernel.org>
To: Ralf Mardorf <ralf.mardorf@alice-dsl.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailsafe.webbplatsen.se ([94.247.172.109]:30003 "EHLO
	mailsafe.webbplatsen.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933181AbbCRJ4i (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 18 Mar 2015 05:56:38 -0400
In-Reply-To: <20150318100817.73a5e32a@archlinux>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 18 Mar 2015 10:08:17 +0100
Ralf Mardorf <ralf.mardorf@alice-dsl.net> wrote:

> The status of rtirq reports one IRQ with a "cryptic" name.
> I'm still using rtirq 20130402, not the current version 20150216, but
> the version of rtirq seems not to be the culprit.

This seems to be an upstream change.  I see the same for the AHCI
controllers on the 2 systems I've checked so far.  The same thing
happens on the archlinux distro kernel (3.18.6). 

Suppose the change has been done to be able to distinguish one
controller from another on systems having more than one AHCI
controller.  In fact I would personally be happy if some way was found
to do the same for all the USB hubs.

-- 

   Joakim
