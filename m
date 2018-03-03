Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail-oi0-f47.google.com ([209.85.218.47]:36522 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964973AbeCCBhe (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 2 Mar 2018 20:37:34 -0500
Received: by mail-oi0-f47.google.com with SMTP id u73so8393501oie.3
        for <linux-rt-users@vger.kernel.org>; Fri, 02 Mar 2018 17:37:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180227085851.2qivugzwmmcd64am@linutronix.de>
References: <CADJaPTADCHOgHJYJYkaR0pboqNZH_jH_zY0vWAzMxp1NBLTDcA@mail.gmail.com>
 <AM5PR03MB296341BA74D9A542E92E34E9D6CC0@AM5PR03MB2963.eurprd03.prod.outlook.com>
 <20180226094604.7biqg57c4xq2ugao@linutronix.de> <7e7f456f-17b9-ae40-5586-fa676db0d202@pengutronix.de>
 <CADJaPTC57W-3E8u+0xsAGFVFMm_9nge8sXf2Fdt=-qM_kOKMsw@mail.gmail.com> <20180227085851.2qivugzwmmcd64am@linutronix.de>
From: Diana Burgess <diana@peloton-tech.com>
Date: Fri, 2 Mar 2018 17:37:33 -0800
Message-ID: <CADJaPTD_cLYxV37oBZjryWPs9X5qFVmWpphBqR6ZOUkOve+-og@mail.gmail.com>
Subject: Re: peak_pciefd 0000:06:00.0 can1: can_put_echo_skb: BUG! echo_skb is occupied!
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, =?UTF-8?Q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.com>, Philipp Schrader <philipp@peloton-tech.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>

On Tue, Feb 27, 2018 at 12:58 AM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> On 2018-02-26 11:55:11 [-0800], Diana Burgess wrote:
>> That patch is part of my branch already so it does not fix this bug.
>>
>> Also 4.15 is not part of rt-devel yet so I did not try to build and run that
>> version.
> about that. The tree you were using is not updated (is EOL) so I suggest
> to upgrade to 4.14-RT. This may not fix your bug but you get a kernel
> with stable/security updates.
>
> You mentioned that you use -RT and you see this problem only with the
> peak card. You never mentioned if this also happens often or rarely or
> if this happens once you disable RT and you keep doing what you are
> doing.
>
>>
>> Thanks,
>>
>
> Sebastian

I've upgraded to 4.14-RT and tried with and without RT. Using RT I see the
bug approximately every 45s (though it is not consistent). This time between
bugs increases when not using RT, but does not go away.

-- 
Diana Burgess
