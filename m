From: Sujit K M <sjt.kar@gmail.com>
Subject: Re: Problem with function select on kernel 2.6.29.6-rt23
Date: Mon, 21 Sep 2009 14:53:43 +0530
Message-ID: <921ca19c0909210223x74d371a9g720986748b9a4ffc@mail.gmail.com>
References: <4AA8D958.5000508@hedrich-winders.com>
	 <4AB3E21A.8060206@hedrich-winders.com>
	 <921ca19c0909200320i5e6948f5k749a67b2df59ecc9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: mell@hedrich-winders.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pz0-f196.google.com ([209.85.222.196]:51899 "EHLO
	mail-pz0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755389AbZIUJXk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 Sep 2009 05:23:40 -0400
Received: by pzk34 with SMTP id 34so2354934pzk.22
        for <linux-rt-users@vger.kernel.org>; Mon, 21 Sep 2009 02:23:44 -0700 (PDT)
In-Reply-To: <921ca19c0909200320i5e6948f5k749a67b2df59ecc9@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

this seems to be normal functionality.

As quoted from

http://linux.die.net/man/2/select

(ii)
select() may update the timeout argument to indicate how much time was
left. pselect() does not change this argument.



On Sun, Sep 20, 2009 at 3:50 PM, Sujit K M <sjt.kar@gmail.com> wrote:
> Hi,
>
> One thing at the onset I would like you to check is that what happens
> to the program when the loop
> count is made more like 1000/10,000/100000 - 1 Million/10 Million.
> Does the Time Graph Increase.
> Try Plotting the Difference with actual time start. Try Making Use of
> Some scripting language like TCL/TK.
>
> There is some info regarding the select system call. I think it is
> pertaining to this problem.
> http://linux.die.net/man/2/syscalls. Basically It is an Optimization
> that the Current Kernels Look Into.
>
> Thanks,
> Sujit
>
> On Sat, Sep 19, 2009 at 1:10 AM, J=FCrgen Mell <mell@hedrich-winders.=
com> wrote:
>> Meanwhile I have dug a little deeper into this problem. The problem
>> occurs under the following conditions:
>> - the BIOS clock must be slow
>> - the NTP daemon is used to adjust the system time
>> The problem can be reproduced on real hardware as well as on a virtu=
al
>> machine running under VMware. Set the BIOS clock back about ten minu=
tes
>> against the 'real' time. Then start the NTP daemon and then run the
>> little test program:
>>
>> #include <stdio.h>
>> #include <stdlib.h>
>> #include <time.h>
>> #include <errno.h>
>> #include <sys/select.h>
>>
>> int main(int argc, char *argv[])
>> {
>> =A0 time_t t;
>> =A0 struct timeval timeout;
>> =A0 int i;
>> =A0 int ret;
>>
>> =A0 t =3D time (NULL);
>> =A0 printf ("Current time before =3D %s", ctime (&t));
>>
>> =A0 for (i =3D 0; i < 20; i++)
>> =A0 {
>> =A0 =A0 =A0timeout.tv_sec =A0=3D 1;
>> =A0 =A0 =A0timeout.tv_usec =3D 0;
>>
>> =A0 =A0 =A0if ((ret =3D select (FD_SETSIZE, NULL, NULL, NULL, &timeo=
ut)) < 0)
>> =A0 =A0 =A0{
>> =A0 =A0 =A0 =A0 printf ("select returned %d, errno =3D %d\n", ret, e=
rrno);
>> =A0 =A0 =A0 =A0 return EXIT_FAILURE;
>> =A0 =A0 =A0}
>> =A0 }
>> =A0 t =3D time (NULL);
>> =A0 printf ("Current time after =3D %s", ctime (&t));
>> =A0 return EXIT_SUCCESS;
>> }
>>
>> On a virtual machine under VMware I got the following result after s=
ome
>> minutes of system run time:
>>
>> hws@cwc-vmware:/home/hws > /space/software/select_test/debug/src/sel=
ect_test
>> Current time before =3D Fri Sep 18 20:05:51 2009
>> Current time after =3D Fri Sep 18 20:06:11 2009
>> hws@cwc-vmware:/home/hws > /space/software/select_test/debug/src/sel=
ect_test
>> Current time before =3D Fri Sep 18 20:14:29 2009
>> Current time after =3D Fri Sep 18 20:14:33 2009
>> hws@cwc-vmware:/home/hws > /space/software/select_test/debug/src/sel=
ect_test
>> Current time before =3D Fri Sep 18 20:14:57 2009
>> Current time after =3D Fri Sep 18 20:14:57 2009
>> hws@cwc-vmware:/home/hws > /space/software/select_test/debug/src/sel=
ect_test
>> Current time before =3D Fri Sep 18 20:15:20 2009
>> Current time after =3D Fri Sep 18 20:15:40 2009
>> hws@cwc-vmware:/home/hws >
>>
>> Normally, the time distance between 'before' and 'after' should be 2=
0
>> seconds as in the first and last run of the program. For the second =
run
>> the time difference is only 4 seconds and for the third run it is ev=
en zero.
>>
>> On the real hardware I have also some other time-related issues when=
 the
>> problem occurs. Keyboard input will often 'bounce' - key presses are
>> detected two or more times and some delay times are prolonged (!). I
>> could not yet reproduce this in the virtual machine.
>>
>> The problem will not always occur immediately after the system is
>> started but it may take several minutes until the first effects occu=
r. I
>> have not tested this issue with other kernels yet but I will do so
>> during the weekend.
>>
>> Are there any ideas what to do about this (beside buying a better BI=
OS
>> clock)? I would really like to have the NTP daemon running to keep t=
he
>> system time accurate, but somehow it seems to effect wait queues in =
the
>> kernel pretty badly.
>>
>> Bye,
>> =A0 =A0 =A0 =A0 =A0 J=FCrgen
>>
>> J=FCrgen Mell schrieb:
>>> Hi,
>>>
>>> I have an application which connects via a network socket to a serv=
er
>>> running on the same machine (IP 127.0.0.1) This application uses th=
e
>>> function 'select' to wait for new data from the server or until a t=
wo
>>> seconds timeout. This works well until there is network traffic on =
the
>>> external network interfaces (eth* or WLAN). When there is network
>>> traffic on the external interfaces, the select function does not wa=
it
>>> anymore but it returns with a return code of zero, indicating not d=
ata
>>> available on the socket. This happens nearly immediately (after 8 t=
o 9
>>> microseconds) and not after the specified two seconds interval. The
>>> timeout parameter of select is updated accordingly (it shows eg. 1 =
s
>>> 999991 us).
>>> Up to now I could not test this with another kernel but I will try =
to
>>> do it this afternoon. Are there any known problems with select? Is
>>> there any way to circumvent this?
>>>
>>> Any help would be greatly appreciated!
>>>
>>> =A0 =A0 =A0 =A0J=FCrgen
>>>
>>
>> --
>> J=FCrgen Mell (Software-Entwicklung) =A0 =A0 =A0 mell@hedrich-winder=
s.com
>> Tel.: =A0+49-511-762-18226 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 http://ww=
w.hedrich-winding.com
>> FAX : =A0+49-511-762-18225
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
>> Steuernr.: 020/235/20110 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USt-IdNr.: =
DE 258258279
>> --------------------------------------------------------------------=
--------
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-rt-u=
sers" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
>
>
> --
> -- Sujit K M
>
> blog(http://kmsujit.blogspot.com/)
>



--=20
-- Sujit K M

blog(http://kmsujit.blogspot.com/)
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
