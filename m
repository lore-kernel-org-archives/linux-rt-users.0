From: Sujit K M <sjt.kar@gmail.com>
Subject: Re: Problem with function select on kernel 2.6.29.6-rt23
Date: Thu, 10 Sep 2009 17:03:19 +0530
Message-ID: <921ca19c0909100433s2cad9e6asc6b3a77a7e03aa1a@mail.gmail.com>
References: <4AA8D958.5000508@hedrich-winders.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: mell@hedrich-winders.com, linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-px0-f176.google.com ([209.85.216.176]:46708 "EHLO
	mail-px0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751510AbZIJLki convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 10 Sep 2009 07:40:38 -0400
Received: by pxi6 with SMTP id 6so16420pxi.21
        for <linux-rt-users@vger.kernel.org>; Thu, 10 Sep 2009 04:40:41 -0700 (PDT)
In-Reply-To: <4AA8D958.5000508@hedrich-winders.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Could you Check the sort of load that your server machine is able to
take. The site you would be looking at is
http://www.petefreitag.com/item/689.cfm.
I think if the network is rejecting the select call, As the socket is
not getting created. Other wise it would wait to the required 2 Second
limit set by you.
Also are you sure of the bind part of the socket creation. Making it
threaded is an option.

Thanks,
Sujit

On Thu, Sep 10, 2009 at 4:17 PM, J=FCrgen Mell <mell@hedrich-winders.co=
m> wrote:
> Hi,
>
> I have an application which connects via a network socket to a server
> running on the same machine (IP 127.0.0.1) This application uses the
> function 'select' to wait for new data from the server or until a two
> seconds timeout. This works well until there is network traffic on th=
e
> external network interfaces (eth* or WLAN). When there is network tra=
ffic on
> the external interfaces, the select function does not wait anymore bu=
t it
> returns with a return code of zero, indicating not data available on =
the
> socket. This happens nearly immediately (after 8 to 9 microseconds) a=
nd not
> after the specified two seconds interval. The timeout parameter of se=
lect is
> updated accordingly (it shows eg. 1 s 999991 us).
> Up to now I could not test this with another kernel but I will try to=
 do it
> this afternoon. Are there any known problems with select? Is there an=
y way
> to circumvent this?
>
> Any help would be greatly appreciated!
>
> =A0 =A0 =A0 J=FCrgen
>
> --
> J=FCrgen Mell (Software-Entwicklung) =A0 =A0 =A0 mell@hedrich-winders=
=2Ecom
> Tel.: =A0+49-511-762-18226 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 http://www=
=2Ehedrich-winding.com
> FAX : =A0+49-511-762-18225
> Mobil: +49-160-7428156
> ---------------------------------------------------------------------=
-------
> HEDRICH winding systems GmbH
> An der Universit=E4t 2 (im PZH)
> D-30823 Garbsen (GERMANY)
> ---------------------------------------------------------------------=
-------
> Gesch=E4ftsf=FChrer: Karsten Adam
> Handelsregister: Wetzlar, HRB 4768
> Steuernr.: 020/235/20110 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USt-IdNr.: D=
E 258258279
> ---------------------------------------------------------------------=
-------
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
-- Sujit K M

blog(http://kmsujit.blogspot.com/)
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
