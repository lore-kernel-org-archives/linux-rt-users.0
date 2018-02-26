Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail-ot0-f181.google.com ([74.125.82.181]:35058 "EHLO
        mail-ot0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751507AbeBZTzM (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 26 Feb 2018 14:55:12 -0500
Received: by mail-ot0-f181.google.com with SMTP id p8so1413009otf.2
        for <linux-rt-users@vger.kernel.org>; Mon, 26 Feb 2018 11:55:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <7e7f456f-17b9-ae40-5586-fa676db0d202@pengutronix.de>
References: <CADJaPTADCHOgHJYJYkaR0pboqNZH_jH_zY0vWAzMxp1NBLTDcA@mail.gmail.com>
 <AM5PR03MB296341BA74D9A542E92E34E9D6CC0@AM5PR03MB2963.eurprd03.prod.outlook.com>
 <20180226094604.7biqg57c4xq2ugao@linutronix.de> <7e7f456f-17b9-ae40-5586-fa676db0d202@pengutronix.de>
From: Diana Burgess <diana@peloton-tech.com>
Date: Mon, 26 Feb 2018 11:55:11 -0800
Message-ID: <CADJaPTC57W-3E8u+0xsAGFVFMm_9nge8sXf2Fdt=-qM_kOKMsw@mail.gmail.com>
Subject: Re: peak_pciefd 0000:06:00.0 can1: can_put_echo_skb: BUG! echo_skb is occupied!
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, =?UTF-8?Q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.com>, Philipp Schrader <philipp@peloton-tech.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>

On Mon, Feb 26, 2018 at 2:34 AM, Marc Kleine-Budde <mkl@pengutronix.de> wro=
te:
> On 02/26/2018 10:46 AM, Sebastian Andrzej Siewior wrote:
>> On 2018-02-23 08:46:36 [+0000], St=C3=A9phane Grosjean wrote:
>>> We've pushed a patch to fix a potential issue around the handling of th=
e echo frames. It has been included in 4.15. Are you able to build and run =
this version of the Kernel?
>>
>> top posting and long lines.
>> Could you please quote the patches which you assume should fix this
>> behaviour and whether or not they are tagged stable?
>
> 91785de6f94b can: peak/pcie_fd: fix potential bug in restarting tx queue
>
> Marc
>
> --
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
>

That patch is part of my branch already so it does not fix this bug.

Also 4.15 is not part of rt-devel yet so I did not try to build and run tha=
t
version.

Thanks,

--=20
Diana Burgess
