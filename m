From: =?ISO-8859-1?Q?J=FCrgen_Mell?= <mell@hedrich-winders.com>
Subject: Re: Problem with function select on kernel 2.6.29.6-rt23
Date: Mon, 21 Sep 2009 11:58:00 +0200
Message-ID: <4AB74E28.7020901@hedrich-winders.com>
References: <4AA8D958.5000508@hedrich-winders.com>	 <4AB3E21A.8060206@hedrich-winders.com>	 <921ca19c0909200320i5e6948f5k749a67b2df59ecc9@mail.gmail.com> <921ca19c0909210223x74d371a9g720986748b9a4ffc@mail.gmail.com>
Reply-To: mell@hedrich-winders.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Sujit K M <sjt.kar@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from dispoweb.ifw.uni-hannover.de ([130.75.23.4]:54071 "EHLO
	ketschua.hedrich-winders.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752717AbZIUJ56 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 Sep 2009 05:57:58 -0400
In-Reply-To: <921ca19c0909210223x74d371a9g720986748b9a4ffc@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

No, I do not think that this is intentional. Some lines later, you will=
 find

"Some code calls *select*() with all three sets empty, /n/ zero, and a=20
non-NULL /timeout/ as a fairly portable way to sleep with subsecond=20
precision."

This cannot make any sense, if I have to call select several times to=20
get the full delay period. The overhead for calling the function severa=
l=20
times is significant. I have modified the test program according to you=
r=20
proposal to run the loop 2000 times with 10000 us delay and get -=20
depending on the speed of the computer - times between 22 and 24 second=
s=20
total.

I understand that the timeout argument of select is updated when select=
=20
returns after one of the monitored file descriptors is ready for the=20
selected operation.

I have tested this issue now with the kernel 2.6.31-rt11 and got a new=20
problem: this time select does not abort prematurely any more but now=20
each second of computer time is about three seconds in reality (the=20
computer clock is extremely slow). NTP is running.

Somehow fiddling with NTP causes very strange side effects...

Bye,
           J=FCrgen

Sujit K M schrieb:
> this seems to be normal functionality.
>
> As quoted from
>
> http://linux.die.net/man/2/select
>
> (ii)
> select() may update the timeout argument to indicate how much time wa=
s
> left. pselect() does not change this argument.
>
>
>
> On Sun, Sep 20, 2009 at 3:50 PM, Sujit K M <sjt.kar@gmail.com> wrote:
>  =20
>> Hi,
>>
>> One thing at the onset I would like you to check is that what happen=
s
>> to the program when the loop
>> count is made more like 1000/10,000/100000 - 1 Million/10 Million.
>> Does the Time Graph Increase.
>> Try Plotting the Difference with actual time start. Try Making Use o=
f
>> Some scripting language like TCL/TK.
>>
>> There is some info regarding the select system call. I think it is
>> pertaining to this problem.
>> http://linux.die.net/man/2/syscalls. Basically It is an Optimization
>> that the Current Kernels Look Into.
>>
>> Thanks,
>> Sujit
>>
>> On Sat, Sep 19, 2009 at 1:10 AM, J=FCrgen Mell <mell@hedrich-winders=
=2Ecom> wrote:
>>    =20
>>> Meanwhile I have dug a little deeper into this problem. The problem
>>> occurs under the following conditions:
>>> - the BIOS clock must be slow
>>> - the NTP daemon is used to adjust the system time
>>> The problem can be reproduced on real hardware as well as on a virt=
ual
>>> machine running under VMware. Set the BIOS clock back about ten min=
utes
>>> against the 'real' time. Then start the NTP daemon and then run the
>>> little test program:
>>>
>>> #include <stdio.h>
>>> #include <stdlib.h>
>>> #include <time.h>
>>> #include <errno.h>
>>> #include <sys/select.h>
>>>
>>> int main(int argc, char *argv[])
>>> {
>>>   time_t t;
>>>   struct timeval timeout;
>>>   int i;
>>>   int ret;
>>>
>>>   t =3D time (NULL);
>>>   printf ("Current time before =3D %s", ctime (&t));
>>>
>>>   for (i =3D 0; i < 20; i++)
>>>   {
>>>      timeout.tv_sec  =3D 1;
>>>      timeout.tv_usec =3D 0;
>>>
>>>      if ((ret =3D select (FD_SETSIZE, NULL, NULL, NULL, &timeout)) =
< 0)
>>>      {
>>>         printf ("select returned %d, errno =3D %d\n", ret, errno);
>>>         return EXIT_FAILURE;
>>>      }
>>>   }
>>>   t =3D time (NULL);
>>>   printf ("Current time after =3D %s", ctime (&t));
>>>   return EXIT_SUCCESS;
>>> }
>>>
>>> On a virtual machine under VMware I got the following result after =
some
>>> minutes of system run time:
>>>
>>> hws@cwc-vmware:/home/hws > /space/software/select_test/debug/src/se=
lect_test
>>> Current time before =3D Fri Sep 18 20:05:51 2009
>>> Current time after =3D Fri Sep 18 20:06:11 2009
>>> hws@cwc-vmware:/home/hws > /space/software/select_test/debug/src/se=
lect_test
>>> Current time before =3D Fri Sep 18 20:14:29 2009
>>> Current time after =3D Fri Sep 18 20:14:33 2009
>>> hws@cwc-vmware:/home/hws > /space/software/select_test/debug/src/se=
lect_test
>>> Current time before =3D Fri Sep 18 20:14:57 2009
>>> Current time after =3D Fri Sep 18 20:14:57 2009
>>> hws@cwc-vmware:/home/hws > /space/software/select_test/debug/src/se=
lect_test
>>> Current time before =3D Fri Sep 18 20:15:20 2009
>>> Current time after =3D Fri Sep 18 20:15:40 2009
>>> hws@cwc-vmware:/home/hws >
>>>
>>> Normally, the time distance between 'before' and 'after' should be =
20
>>> seconds as in the first and last run of the program. For the second=
 run
>>> the time difference is only 4 seconds and for the third run it is e=
ven zero.
>>>
>>> On the real hardware I have also some other time-related issues whe=
n the
>>> problem occurs. Keyboard input will often 'bounce' - key presses ar=
e
>>> detected two or more times and some delay times are prolonged (!). =
I
>>> could not yet reproduce this in the virtual machine.
>>>
>>> The problem will not always occur immediately after the system is
>>> started but it may take several minutes until the first effects occ=
ur. I
>>> have not tested this issue with other kernels yet but I will do so
>>> during the weekend.
>>>
>>> Are there any ideas what to do about this (beside buying a better B=
IOS
>>> clock)? I would really like to have the NTP daemon running to keep =
the
>>> system time accurate, but somehow it seems to effect wait queues in=
 the
>>> kernel pretty badly.
>>>
>>> Bye,
>>>           J=FCrgen
>>>
>>> J=FCrgen Mell schrieb:
>>>      =20
>>>> Hi,
>>>>
>>>> I have an application which connects via a network socket to a ser=
ver
>>>> running on the same machine (IP 127.0.0.1) This application uses t=
he
>>>> function 'select' to wait for new data from the server or until a =
two
>>>> seconds timeout. This works well until there is network traffic on=
 the
>>>> external network interfaces (eth* or WLAN). When there is network
>>>> traffic on the external interfaces, the select function does not w=
ait
>>>> anymore but it returns with a return code of zero, indicating not =
data
>>>> available on the socket. This happens nearly immediately (after 8 =
to 9
>>>> microseconds) and not after the specified two seconds interval. Th=
e
>>>> timeout parameter of select is updated accordingly (it shows eg. 1=
 s
>>>> 999991 us).
>>>> Up to now I could not test this with another kernel but I will try=
 to
>>>> do it this afternoon. Are there any known problems with select? Is
>>>> there any way to circumvent this?
>>>>
>>>> Any help would be greatly appreciated!
>>>>
>>>>        J=FCrgen
>>>>
>>>>        =20
>>> --
>>> J=FCrgen Mell (Software-Entwicklung)       mell@hedrich-winders.com
>>> Tel.:  +49-511-762-18226                 http://www.hedrich-winding=
=2Ecom
>>> FAX :  +49-511-762-18225
>>> Mobil: +49-160-7428156
>>> -------------------------------------------------------------------=
---------
>>> HEDRICH winding systems GmbH
>>> An der Universit=E4t 2 (im PZH)
>>> D-30823 Garbsen (GERMANY)
>>> -------------------------------------------------------------------=
---------
>>> Gesch=E4ftsf=FChrer: Karsten Adam
>>> Handelsregister: Wetzlar, HRB 4768
>>> Steuernr.: 020/235/20110                 USt-IdNr.: DE 258258279
>>> -------------------------------------------------------------------=
---------
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-rt-=
users" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>      =20
>>
>> --
>> -- Sujit K M
>>
>> blog(http://kmsujit.blogspot.com/)
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
