From: Daniel Bristot de Oliveira <daniel@bristot.me>
Subject: Re: cyclictest versus custom SPI based system
Date: Wed, 13 Jan 2016 16:36:30 -0200
Message-ID: <5696992E.703@bristot.me>
References: <AF04265A3FC2B144B9892F621A394E13D5C0B43F@tethys>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Julio Cruz Barroso <julio.cruz@smartmatic.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtpi-sp-248.kinghost.net ([177.185.201.248]:52735 "EHLO
	smtpi-sp-248.kinghost.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933018AbcAMSxc (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 13 Jan 2016 13:53:32 -0500
In-Reply-To: <AF04265A3FC2B144B9892F621A394E13D5C0B43F@tethys>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On 01/13/2016 03:06 PM, Julio Cruz Barroso wrote:
> This could be related with the priority of the SPI (spi0)?
In this case the thread spi0 has PRI of 20 with a nice of 0 [3].

Hi Julio,

You must run SPI's IRQ thread on a real-time policy:priority. For
instance, chrt -p -f 50 $(pidof spi0).

I used work with an ARM processor running kernel-rt on both master and
slave side of a SPI bus, and it worked fine when using threaded IRQ.

If you continue facing long latencies, you can use the (big hammer)
IRQF_NO_THREAD flag on SPI's IRQ handler registry. This will force the
SPI handler to run as a traditional - non threaded - IRQ handler.

I did it on a very special case of a 200MHz ARM running kernel-rt on the
slave side of a SPI bus. As it was on the slave side, any additional
overhead (like the scheduling overhead of the threaded handler) was
impacting on master's side performance, that was a very busy DSP (ADBF
@500Mhz). It worked fine! But the SPI's IRQ was the "highest priority"
task, on a very controlled env.

-- Daniel
