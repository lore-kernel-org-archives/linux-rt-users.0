From: Denis Borisevich <dennisfen@gmail.com>
Subject: Re:
Date: Fri, 25 Jun 2010 16:10:51 +0400
Message-ID: <AANLkTikBlzopP41m9_dv51V1YtS-Y6axCr7L5rJZ2EcD@mail.gmail.com>
References: <3E7FA6409BDA204EA3CF733DE7E0B0E10326B20A@CARACALQ005.caracal01.greenstream.priv>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: "Simpson, John (UK) (Contractor)" <john.simpson@mbda-systems.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:11536 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755829Ab0FYMLM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 25 Jun 2010 08:11:12 -0400
Received: by ey-out-2122.google.com with SMTP id 9so709639eyd.5
        for <linux-rt-users@vger.kernel.org>; Fri, 25 Jun 2010 05:11:11 -0700 (PDT)
In-Reply-To: <3E7FA6409BDA204EA3CF733DE7E0B0E10326B20A@CARACALQ005.caracal01.greenstream.priv>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Jun 25, 2010 at 4:04 PM, Simpson, John (UK) (Contractor)
<john.simpson@mbda-systems.com> wrote:
> I'm attempting to run a vanilla 2.6.18 from kernel.org patched with
> 2.6.18-rt7 (third party RPMs dictate this version) . Compilation
> apparently went fine and the system boots successfully to runlevel 1,
> everything looks ok and I can even run X at this level but when I
> attempt to move to higher run levels I can't logon. =C2=A0For level 2=
 there's
> a login and password prompt, for level 3 there's a login but no passw=
ord
> prompt. This is true for any user. =C2=A0The system then just sits th=
ere
> occasionally producing the following "mptscsih: ioc0: attempting task
> abort! ....." plus similar stuff related to mptscsih.
>
> Running with the original kernel (a Centos 2.6.18) everything's fine.
>
> Does this ring any bells with anyone?

Hi, John!
Just a general idea:
Have a look at init scripts for the runlevels you have tried to start
your system with and find the differencies. After that try to disable
services that are not actual to runlevel 1 and enable them one by one
to find out which of them prevents your system from booting.

--
Denis

> John
>
> ********************************************************************
> This email and any attachments are confidential to the intended recip=
ient and may also be privileged. If you are not the intended recipient =
please delete it from your system and notify the sender. You should not=
 copy it or use it for any purpose nor disclose or distribute its conte=
nts to any other person.
>
> MBDA UK Limited, a company registered in England and Wales, registrat=
ion number 3144919 whose registered office is at Six Hills Way, Stevena=
ge, Hertfordshire, SG1 2DA, England.
> ********************************************************************
>
> _____________________________________________________________________=
_
> This email has been scanned by the MessageLabs Email Security System.
> For more information please visit http://www.messagelabs.com/email
> _____________________________________________________________________=
_
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
