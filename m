Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from Galois.linutronix.de ([146.0.238.70]:43488 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752218AbeBZJqI (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 26 Feb 2018 04:46:08 -0500
Date: Mon, 26 Feb 2018 10:46:05 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: peak_pciefd 0000:06:00.0 can1: can_put_echo_skb: BUG! echo_skb
 is occupied!
Message-ID: <20180226094604.7biqg57c4xq2ugao@linutronix.de>
References: <CADJaPTADCHOgHJYJYkaR0pboqNZH_jH_zY0vWAzMxp1NBLTDcA@mail.gmail.com>
 <AM5PR03MB296341BA74D9A542E92E34E9D6CC0@AM5PR03MB2963.eurprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <AM5PR03MB296341BA74D9A542E92E34E9D6CC0@AM5PR03MB2963.eurprd03.prod.outlook.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: =?utf-8?B?U3TDqXBoYW5l?= Grosjean <s.grosjean@peak-system.com>
Cc: Diana Burgess <diana@peloton-tech.com>, Philipp Schrader <philipp@peloton-tech.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>

On 2018-02-23 08:46:36 [+0000], Stéphane Grosjean wrote:
> We've pushed a patch to fix a potential issue around the handling of the echo frames. It has been included in 4.15. Are you able to build and run this version of the Kernel?

top posting and long lines.
Could you please quote the patches which you assume should fix this
behaviour and whether or not they are tagged stable?

> Regards,

Sebastian
