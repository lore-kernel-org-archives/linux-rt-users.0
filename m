From: Forconi <forconi@wavecomm.it>
Subject: Re: Cyclictest compile error when cross compiling for AT91SAM9260
Date: Thu, 27 Sep 2012 08:23:30 +0000 (UTC)
Message-ID: <205356936.3972629.1348734210351.JavaMail.root@zmail.sgconsulting.it>
References: <506358B9.7020007@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: frank rowand <frank.rowand@am.sony.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from zmail.sgconsulting.it ([174.143.207.116]:49514 "EHLO
	zmail.sgconsulting.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750990Ab2I0ITS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 27 Sep 2012 04:19:18 -0400
In-Reply-To: <506358B9.7020007@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,=20
I made a cleanup and a fresh clone of the git repository.

This is what I get running make:

$ make CC=3Darm-unknown-linux-gnu-gcc
src/pi_tests/pip_stress.c:240:2: error: #error _POSIX_THREAD_PROCESS_SH=
ARED is not defined
src/pi_tests/pi_stress.c:78:2: error: #error "Can't run this test witho=
ut PI Mutex support"
arm-unknown-linux-gnu-gcc -D VERSION_STRING=3D0.84 -c src/cyclictest/cy=
clictest.c -D_GNU_SOURCE -Wall -Wno-nonnull -Isrc/include -O2
src/cyclictest/cyclictest.c: In function 'timerthread':
src/cyclictest/cyclictest.c:700: warning: implicit declaration of funct=
ion 'pthread_setaffinity_np'
arm-unknown-linux-gnu-gcc -D VERSION_STRING=3D0.84 -c src/lib/rt-utils.=
c -D_GNU_SOURCE -Wall -Wno-nonnull -Isrc/include -O2
arm-unknown-linux-gnu-gcc -D VERSION_STRING=3D0.84 -c src/lib/error.c -=
D_GNU_SOURCE -Wall -Wno-nonnull -Isrc/include -O2
arm-unknown-linux-gnu-gcc -D VERSION_STRING=3D0.84 -c src/lib/rt-get_cp=
u.c -D_GNU_SOURCE -Wall -Wno-nonnull -Isrc/include -O2
ar rcs librttest.a rt-utils.o error.o rt-get_cpu.o
arm-unknown-linux-gnu-gcc -D_GNU_SOURCE -Wall -Wno-nonnull -Isrc/includ=
e -O2  -o cyclictest cyclictest.o librttest.a -lrt -lpthread -lrttest -=
L.=20
cyclictest.o: In function `timerthread':
cyclictest.c:(.text+0x17ac): undefined reference to `pthread_setaffinit=
y_np'
collect2: ld returned 1 exit status
make: *** [cyclictest] Error 1

It seems that the pthread_setaffinity_np is missing in pthread library =
(maybe I have an old lib?)


----- Messaggio originale -----
Da: "Frank Rowand" <frank.rowand@am.sony.com>
A: "Forconi" <forconi@wavecomm.it>
Cc: linux-rt-users@vger.kernel.org
Inviato: Mercoled=C3=AC, 26 settembre 2012 21:34:17
Oggetto: Re: Cyclictest compile error when cross compiling for AT91SAM9=
260

On 09/26/12 02:26, Forconi wrote:
> Hi,=20
> I have compiled and installed an RT_PREEMPT patched kernel (2.6.33.7-=
rt29) on a AT91SAM9260 board.
> I'd like to test latencies using cyclictest software (obtained from g=
it repository).

Is the git repository:

   git.kernel.org/pub/scm/linux/kernel/git/clrkwllms/rt-tests.git

with current version:

   commit 857cdd5320ce1f293f5dbcbec79cc8fe22b0bebf
   Date:   Wed May 9 09:38:00 2012 -0500

> My cross compile environment is gcc-4.2.3 with glibc-2.3.3 (obtained =
from the producer of the board).
>=20
> This is the error I get when I try to compile:
>=20
> $ make CROSS_COMPILE=3Darm-unknown-linux-gnu- librttest.a=20
> arm-unknown-linux-gnu-gcc -D VERSION_STRING=3D0.84 -c src/lib/rt-util=
s.c -D_GNU_SOURCE -Wall -Wno-nonnull -Isrc/include -O2

That is somewhat surprising (unless you have modified the makefile).  I=
f I
try that same command (but the proper CROSS_COMPILE value for my cross
tools), the cross gcc is not picked up.  But your example is clearly us=
ing
your cross gcc.  I instead use:

   make CC=3D"${CROSS_COMPILE}gcc"

where CROSS_COMPILE is set for my cross tools:

  $ echo ${CROSS_COMPILE}
  arm-sony-linux-gnueabi-thumb2-

Everything builds ok, no need to make librttest.a and cyclictest indivi=
dually.

I point out all of the above, because it does not seem like you have th=
e
same source that I have, so I'm reluctant to dig any further.


> arm-unknown-linux-gnu-gcc -D VERSION_STRING=3D0.84 -c src/lib/error.c=
 -D_GNU_SOURCE -Wall -Wno-nonnull -Isrc/include -O2
> arm-unknown-linux-gnu-gcc -D VERSION_STRING=3D0.84 -c src/lib/rt-get_=
cpu.c -D_GNU_SOURCE -Wall -Wno-nonnull -Isrc/include -O2
> ar rcs librttest.a rt-utils.o error.o rt-get_cpu.o
>=20
> $ make CROSS_COMPILE=3Darm-unknown-linux-gnu- cyclictest
> arm-unknown-linux-gnu-gcc -D VERSION_STRING=3D0.84 -c src/cyclictest/=
cyclictest.c -D_GNU_SOURCE -Wall -Wno-nonnull -Isrc/include -O2
> In file included from /opt/glomation/gcc-4.2.3-glibc-2.3.3/bin/../lib=
/gcc/arm-unknown-linux-gnu/4.2.3/../../../../arm-unknown-linux-gnu/sys-=
include/sys/sysinfo.h:25,
>                  from src/cyclictest/cyclictest.c:34:
> /opt/glomation/gcc-4.2.3-glibc-2.3.3/bin/../lib/gcc/arm-unknown-linux=
-gnu/4.2.3/../../../../arm-unknown-linux-gnu/sys-include/linux/kernel.h=
:716:2: warning: #warning Attempt to use kernel headers from user space=
, see http:
> In file included from /opt/glomation/gcc-4.2.3-glibc-2.3.3/bin/../lib=
/gcc/arm-unknown-linux-gnu/4.2.3/../../../../arm-unknown-linux-gnu/sys-=
include/sys/resource.h:25,
>                  from src/cyclictest/cyclictest.c:37:
> /opt/glomation/gcc-4.2.3-glibc-2.3.3/bin/../lib/gcc/arm-unknown-linux=
-gnu/4.2.3/../../../../arm-unknown-linux-gnu/sys-include/bits/resource.=
h:35: error: expected identifier before numeric constant
> src/cyclictest/cyclictest.c: In function 'timerthread':
> src/cyclictest/cyclictest.c:703: warning: implicit declaration of fun=
ction 'pthread_setaffinity_np'
> make: *** [cyclictest.o] Error 1
>=20
>=20
>=20
> Thank you for any suggestions and help.
>=20
> Regards,
> Samuele Forconi.



--=20
Ing. Samuele Forconi
Responsabile Sviluppo SW
WaveComm S.r.l.
Sede legale: Via Donizetti 25, 53011 Castellina in Chianti (SI)
Sede operativa: Loc. Belvedere - Ingresso 2, 53034 Colle Val d'Elsa (SI=
)
Phone: (39) 0577 043101
=46ax: (39) 0577 043101
Mobile: (39) 347 5899717
Skype: samueleforconi
E-mail: forconi@wavecomm.it
URL: www.wavecomm.it

_______________________________________________________________________=
______________________

Ai sensi del D. Lgs. n.196 del 30/06/2003, questo messaggio ed ogni suo=
 allegato sono confidenziali e ad uso esclusivo del destinatario, il qu=
ale =C3=A8 l'unico autorizzato ad usarlo, copiarlo e, sotto la propria =
responsabilit=C3=A0, diffonderlo. Se il ricevente non =C3=A8 il destina=
tario diretto del presente messaggio, =C3=A8 pregato di contattare l'or=
iginario mittente e di cancellare questo messaggio ed ogni suo allegato=
 dal sistema di posta. Se il ricevente non =C3=A8 il destinatario diret=
to del presente messaggio, sono vietati l'uso, la riproduzione, e la st=
ampa di questo messaggio e di ogni suo allegato, nonch=C3=A9 la diffusi=
one del loro contenuto a qualsiasi altro soggetto.

=46or the D. Lgs. n.196 of 30/06/2003, this message and any attachment =
are confidential and privileged for the the recipient identified above,=
 who only may use, copy and, under his/her responsibility, further diss=
eminate it. If you are not the intended recipient, please contact the s=
ender and delete this message and any attachment from your system. If y=
ou are not the intended recipient you must not use, copy or print this =
message or attachment or disclose the contents to any other person.
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
