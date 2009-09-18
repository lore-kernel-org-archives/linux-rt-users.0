From: =?ISO-8859-15?Q?J=FCrgen_Mell?= <mell@hedrich-winders.com>
Subject: Re: Problem with function select on kernel  2.6.29.6-rt23
Date: Fri, 18 Sep 2009 21:40:10 +0200
Message-ID: <4AB3E21A.8060206@hedrich-winders.com>
References: <4AA8D958.5000508@hedrich-winders.com>
Reply-To: mell@hedrich-winders.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from dispoweb.ifw.uni-hannover.de ([130.75.23.4]:59620 "EHLO
	ketschua.hedrich-winders.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754018AbZIRTkI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 18 Sep 2009 15:40:08 -0400
Received: from [192.168.158.6] (akira.hws-net.hedrich.com [192.168.158.6])
	by ketschua.hedrich-winders.com (Postfix) with ESMTP id 73529169282
	for <linux-rt-users@vger.kernel.org>; Fri, 18 Sep 2009 21:40:10 +0200 (CEST)
In-Reply-To: <4AA8D958.5000508@hedrich-winders.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Meanwhile I have dug a little deeper into this problem. The problem
occurs under the following conditions:
- the BIOS clock must be slow
- the NTP daemon is used to adjust the system time
The problem can be reproduced on real hardware as well as on a virtual
machine running under VMware. Set the BIOS clock back about ten minutes
against the 'real' time. Then start the NTP daemon and then run the
little test program:

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <errno.h>
#include <sys/select.h>

int main(int argc, char *argv[])
{
   time_t t;
   struct timeval timeout;
   int i;
   int ret;

   t =3D time (NULL);
   printf ("Current time before =3D %s", ctime (&t));

   for (i =3D 0; i < 20; i++)
   {
      timeout.tv_sec  =3D 1;
      timeout.tv_usec =3D 0;

      if ((ret =3D select (FD_SETSIZE, NULL, NULL, NULL, &timeout)) < 0=
)
      {
         printf ("select returned %d, errno =3D %d\n", ret, errno);
         return EXIT_FAILURE;
      }
   }
   t =3D time (NULL);
   printf ("Current time after =3D %s", ctime (&t));
   return EXIT_SUCCESS;
}

On a virtual machine under VMware I got the following result after some
minutes of system run time:

hws@cwc-vmware:/home/hws > /space/software/select_test/debug/src/select=
_test
Current time before =3D Fri Sep 18 20:05:51 2009
Current time after =3D Fri Sep 18 20:06:11 2009
hws@cwc-vmware:/home/hws > /space/software/select_test/debug/src/select=
_test
Current time before =3D Fri Sep 18 20:14:29 2009
Current time after =3D Fri Sep 18 20:14:33 2009
hws@cwc-vmware:/home/hws > /space/software/select_test/debug/src/select=
_test
Current time before =3D Fri Sep 18 20:14:57 2009
Current time after =3D Fri Sep 18 20:14:57 2009
hws@cwc-vmware:/home/hws > /space/software/select_test/debug/src/select=
_test
Current time before =3D Fri Sep 18 20:15:20 2009
Current time after =3D Fri Sep 18 20:15:40 2009
hws@cwc-vmware:/home/hws >

Normally, the time distance between 'before' and 'after' should be 20
seconds as in the first and last run of the program. For the second run
the time difference is only 4 seconds and for the third run it is even =
zero.

On the real hardware I have also some other time-related issues when th=
e
problem occurs. Keyboard input will often 'bounce' - key presses are
detected two or more times and some delay times are prolonged (!). I
could not yet reproduce this in the virtual machine.

The problem will not always occur immediately after the system is
started but it may take several minutes until the first effects occur. =
I
have not tested this issue with other kernels yet but I will do so
during the weekend.

Are there any ideas what to do about this (beside buying a better BIOS
clock)? I would really like to have the NTP daemon running to keep the
system time accurate, but somehow it seems to effect wait queues in the
kernel pretty badly.

Bye,
           J=FCrgen

J=FCrgen Mell schrieb:
> Hi,
>
> I have an application which connects via a network socket to a server
> running on the same machine (IP 127.0.0.1) This application uses the
> function 'select' to wait for new data from the server or until a two
> seconds timeout. This works well until there is network traffic on th=
e
> external network interfaces (eth* or WLAN). When there is network
> traffic on the external interfaces, the select function does not wait
> anymore but it returns with a return code of zero, indicating not dat=
a
> available on the socket. This happens nearly immediately (after 8 to =
9
> microseconds) and not after the specified two seconds interval. The
> timeout parameter of select is updated accordingly (it shows eg. 1 s
> 999991 us).
> Up to now I could not test this with another kernel but I will try to
> do it this afternoon. Are there any known problems with select? Is
> there any way to circumvent this?
>
> Any help would be greatly appreciated!
>
>        J=FCrgen
>

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
