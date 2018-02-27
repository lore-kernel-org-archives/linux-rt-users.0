Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from Galois.linutronix.de ([146.0.238.70]:45716 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752143AbeB0I6z (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 27 Feb 2018 03:58:55 -0500
Date: Tue, 27 Feb 2018 09:58:51 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: peak_pciefd 0000:06:00.0 can1: can_put_echo_skb: BUG! echo_skb
 is occupied!
Message-ID: <20180227085851.2qivugzwmmcd64am@linutronix.de>
References: <CADJaPTADCHOgHJYJYkaR0pboqNZH_jH_zY0vWAzMxp1NBLTDcA@mail.gmail.com>
 <AM5PR03MB296341BA74D9A542E92E34E9D6CC0@AM5PR03MB2963.eurprd03.prod.outlook.com>
 <20180226094604.7biqg57c4xq2ugao@linutronix.de>
 <7e7f456f-17b9-ae40-5586-fa676db0d202@pengutronix.de>
 <CADJaPTC57W-3E8u+0xsAGFVFMm_9nge8sXf2Fdt=-qM_kOKMsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADJaPTC57W-3E8u+0xsAGFVFMm_9nge8sXf2Fdt=-qM_kOKMsw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Diana Burgess <diana@peloton-tech.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, =?utf-8?B?U3TDqXBoYW5l?= Grosjean <s.grosjean@peak-system.com>, Philipp Schrader <philipp@peloton-tech.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>

On 2018-02-26 11:55:11 [-0800], Diana Burgess wrote:
> That patch is part of my branch already so it does not fix this bug.
> 
> Also 4.15 is not part of rt-devel yet so I did not try to build and run that
> version.
about that. The tree you were using is not updated (is EOL) so I suggest
to upgrade to 4.14-RT. This may not fix your bug but you get a kernel
with stable/security updates.

You mentioned that you use -RT and you see this problem only with the
peak card. You never mentioned if this also happens often or rarely or
if this happens once you disable RT and you keep doing what you are
doing.

> 
> Thanks,
> 

Sebastian
