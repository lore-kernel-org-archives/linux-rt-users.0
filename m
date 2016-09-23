From: "Hardik A Gohil (WMSC-HW)" <hardik@willowglen.asia>
Subject: Re: Network Issue
Date: Fri, 23 Sep 2016 10:55:59 +0800
Message-ID: <CAGiFfw4tQ_qjbnh+VRVUU4t6wtLsCw1t2PhWTshhE334YxS2Fg@mail.gmail.com>
References: <CAGiFfw4o2c1f=pR+gKkVYAoHQ7V8ywLXu-_g9ahWSZoAoSD7tA@mail.gmail.com>
 <20160908061920.msefkdj4nk3exzpr@pengutronix.de> <CAGiFfw64YmXt7-dRG-_UM+nZ9R8VznqThiWhDxMVJtXvnKBwSQ@mail.gmail.com>
 <20160914112614.afmbzxbgufz455u5@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: linux-rt-users@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:34839 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751125AbcIWC4C (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 22 Sep 2016 22:56:02 -0400
Received: by mail-io0-f181.google.com with SMTP id m186so105503534ioa.2
        for <linux-rt-users@vger.kernel.org>; Thu, 22 Sep 2016 19:56:00 -0700 (PDT)
In-Reply-To: <20160914112614.afmbzxbgufz455u5@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

I am found the problem in driver.

I am using debug by printing method.

for normal transmission dev_queue_xmit (buffer queue to tx to network
device) and then cpsw_tx_handler (Transmit handler).

when it hangs Transmit handler is not getting called after queued into buff=
er.

Please help me to solve the issue.

On Wed, Sep 14, 2016 at 7:26 PM, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Wed, Sep 14, 2016 at 03:51:28PM +0800, Hardik A Gohil (WMSC-HW) wrote:
>> On Thu, Sep 8, 2016 at 2:19 PM, Uwe Kleine-K=C3=B6nig
>> <u.kleine-koenig@pengutronix.de> wrote:
>> > Hello,
>> >
>> > On Thu, Sep 08, 2016 at 09:49:14AM +0800, Hardik A Gohil (WMSC-HW) wro=
te:
>> >> I am working on Linux 3.2.0.
>> >
>> > Wow, you're still developing on a kernel that is 4.5 years old and
>> > you're not even taking the stable updates.
>>
>> since we did development with phyCORE-AM335x-PD13.1.2 which is using 3.2=
 kernel.
>> we have already completed production and it wont be a easy task to
>> shift to 4. series
>
> Consider it a development step to update to a newer kernel. This allows
> you to test if the problem exists there, too, fix it and then being able
> to backport it. Note all this doesn't force you to upgrade your machines
> in the field.
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|



--=20
--=20
Regards,
Hardik A Gohil


WILLOWGLEN MSC BERHAD (462648-V)
 NO 17 JALAN 2/149B, TAMAN SRI ENDAH,
 BANDAR BARU SRI PETALING,
 57000 KUALA LUMPUR, MALAYSIA
 TEL +603 90571228  FAX +603 90571218
  WILLOWGLEN.COM.MY
