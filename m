From: =?ISO-8859-1?Q?J=FCrgen_Mell?= <mell@hedrich-winders.com>
Subject: Re: Problem with function select on kernel 2.6.29.6-rt23
Date: Thu, 10 Sep 2009 13:50:58 +0200
Message-ID: <4AA8E822.5090909@hedrich-winders.com>
References: <4AA8D958.5000508@hedrich-winders.com> <921ca19c0909100433s2cad9e6asc6b3a77a7e03aa1a@mail.gmail.com>
Reply-To: mell@hedrich-winders.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Sujit K M <sjt.kar@gmail.com>, linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from dispoweb.ifw.uni-hannover.de ([130.75.23.4]:50723 "EHLO
	ketschua.hedrich-winders.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755502AbZIJLu4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 10 Sep 2009 07:50:56 -0400
In-Reply-To: <921ca19c0909100433s2cad9e6asc6b3a77a7e03aa1a@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thanks for your reply! The machine is not loaded very much (CPU load=20
below 30%) . ANY network traffic, which is not even directed to the=20
server process on the machine will cause the problem, eg. just a copy=20
operation which copies the  Linux kernel source from a SMB server to th=
e=20
local disk.
The application program has established the socket connection. 'bind'=20
has completed without problems. It is then running in a loop where it=20
calls 'select' to wait for new data, reads the data if any is available=
,=20
processes it and then repeats these steps.

Bye,
          J=FCrgen


Sujit K M wrote:
> Could you Check the sort of load that your server machine is able to
> take. The site you would be looking at is
> http://www.petefreitag.com/item/689.cfm.
> I think if the network is rejecting the select call, As the socket is
> not getting created. Other wise it would wait to the required 2 Secon=
d
> limit set by you.
> Also are you sure of the bind part of the socket creation. Making it
> threaded is an option.
>
> Thanks,
> Sujit
>
> On Thu, Sep 10, 2009 at 4:17 PM, J=FCrgen Mell <mell@hedrich-winders.=
com> wrote:
>  =20
>> Hi,
>>
>> I have an application which connects via a network socket to a serve=
r
>> running on the same machine (IP 127.0.0.1) This application uses the
>> function 'select' to wait for new data from the server or until a tw=
o
>> seconds timeout. This works well until there is network traffic on t=
he
>> external network interfaces (eth* or WLAN). When there is network tr=
affic on
>> the external interfaces, the select function does not wait anymore b=
ut it
>> returns with a return code of zero, indicating not data available on=
 the
>> socket. This happens nearly immediately (after 8 to 9 microseconds) =
and not
>> after the specified two seconds interval. The timeout parameter of s=
elect is
>> updated accordingly (it shows eg. 1 s 999991 us).
>> Up to now I could not test this with another kernel but I will try t=
o do it
>> this afternoon. Are there any known problems with select? Is there a=
ny way
>> to circumvent this?
>>
>> Any help would be greatly appreciated!
>>
>>       J=FCrgen
>>
>> --
>> J=FCrgen Mell (Software-Entwicklung)       mell@hedrich-winders.com
>> Tel.:  +49-511-762-18226                 http://www.hedrich-winding.=
com
>> FAX :  +49-511-762-18225
>> Mobil: +49-160-7428156
>> --------------------------------------------------------------------=
--------
>> HEDRICH winding systems GmbH
>> An der Universit=E4t 2 (im PZH)
>> D-30823 Garbsen (GERMANY)
>> --------------------------------------------------------------------=
--------
>> Gesch=E4ftsf=FChrer: Karsten Adam
>> Handelsregister: Wetzlar, HRB 4768
>> Steuernr.: 020/235/20110                 USt-IdNr.: DE 258258279
>> --------------------------------------------------------------------=
--------
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-rt-u=
sers" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>    =20
>
>
>
>  =20


--=20
J=FCrgen Mell (Software-Entwicklung)       mell@hedrich-winders.com
Tel.:  +49-511-762-18226                 http://www.hedrich-winding.com
=46AX :  +49-511-762-18225
Mobil: +49-160-7428156
-----------------------------------------------------------------------=
-----
HEDRICH winding systems GmbH
An der Universit=E4t 2 (im PZH)
D-30823 Garbsen (GERMANY)
-----------------------------------------------------------------------=
-----
Gesch=E4ftsf=FChrer: Karsten Adam
Handelsregister: Wetzlar, HRB 4768
Steuernr.: 020/235/20110                 USt-IdNr.: DE 258258279
-----------------------------------------------------------------------=
-----=20


--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
