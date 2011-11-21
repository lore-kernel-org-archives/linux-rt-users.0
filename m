From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] 3.2-rc1-rt1 - Compile errors also for rc1 vanilla
Date: Mon, 21 Nov 2011 12:30:57 -0500
Message-ID: <1321896657.20742.16.camel@frodo>
References: <alpine.LFD.2.02.1111132213220.2694@ionos>
	 <201111141014.06906.tim.sander@hbm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	John Kacur <jkacur@redhat.com>
To: Tim Sander <tim.sander@hbm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.124]:35473 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752116Ab1KURbA (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 Nov 2011 12:31:00 -0500
In-Reply-To: <201111141014.06906.tim.sander@hbm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2011-11-14 at 10:14 +0100, Tim Sander wrote:
> Hi Thomas
>=20
> > I'm pleased to announce the 3.2-rc1-rt1 release.
> Thanks for that.
> =20
> > It's a straight forward port of the 3.0-rt patch queue, which reduc=
ed
> > the patch size by more than 25% from 807k to 580k. The diffstat cha=
nge
> > is:
> >=20
> >  429 files changed, 10118 insertions(+), 3000 deletions(-)
> >  318 files changed,  8871 insertions(+), 1858 deletions(-)
> >=20
> > Thanks to all who helped polishing patches and bringing them mainli=
ne!
> >=20
> >=20
> > The test results on my reference machine are in the 3.0-rt ballpark
> > and I have not seen any frightening explosions so far.
>=20
> Well it seems as if  this guy which wanted to remove rcu finally succ=
eded ;-)
> I can't select a rcu subsystem?

Is this just an issue in 3.2-rt, or did you see this issue in the 3.0-r=
t
release too. I used your attached config and crossed compiled with arm:

$ /usr/local/gcc-4.5.2-nolibc/arm-unknown-linux-gnueabi/bin/arm-unknown=
-linux-gnueabi-gcc --version
arm-unknown-linux-gnueabi-gcc (GCC) 4.5.2

and it finished fine with 3.0-rt, but when I compiled against both
3.2-rt1 and 3.2-rt3, I got the same error:

arch/arm/mach-imx/built-in.o: In function `imx31_soc_init':
/work/rt/rt.git/arch/arm/mach-imx/mm-imx3.c:186: undefined reference to=
 `mx31_revision'
make[1]: *** [.tmp_vmlinux1] Error 1
make: *** [sub-make] Error 2

Which is not the error you saw. I'm curious to what I did wrong.

Thanks,

-- Steve


> ----------------------
> target: kernel.compile
> ----------------------
>=20
> cd /home/sander/speedy/trunk/ptx/platform-pmx-one/build-target/linux-=
linux && PATH=3D/home/sander/speedy/trunk/ptx/platform-pmx-one/sysroot-
> cross/bin:/home/sander/speedy/trunk/ptx/platform-pmx-one/sysroot-cros=
s/sbin:$PATH KCONFIG_NOTIMESTAMP=3D1 make \
>                 -j16 HOSTCC=3Dgcc ARCH=3Darm CROSS_COMPILE=3Darm-1136=
jfs-linux-gnueabi- INSTALL_MOD_PATH=3D/home/sander/speedy/trunk/ptx/pla=
tform-pmx-one/packages/linux-linux=20
> PTX_KERNEL_DIR=3D/home/sander/speedy/trunk/ptx/platform-pmx-one/build=
-target/linux-linux CONFIG_DEBUG_SECTION_MISMATCH=3Dy=20
> DEPMOD=3D/home/sander/speedy/trunk/ptx/platform-pmx-one/sysroot-cross=
/sbin/arm-1136jfs-linux-gnueabi-depmod uImage "modules"
> make[1]: Entering directory `/home/sander/speedy/trunk/ptx/kernel/lin=
ux'
> scripts/kconfig/conf --silentoldconfig Kconfig
> make[1]: Leaving directory `/home/sander/speedy/trunk/ptx/kernel/linu=
x'
> make[1]: Entering directory `/home/sander/speedy/trunk/ptx/kernel/lin=
ux'
>   CHK     include/linux/version.h
>   CHK     include/generated/utsrelease.h
> make[2]: `include/generated/mach-types.h' is up to date.
>   CC      arch/arm/kernel/asm-offsets.s
> In file included from include/linux/mm_types.h:15:0,
>                  from include/linux/sched.h:64,
>                  from arch/arm/kernel/asm-offsets.c:13:
> include/linux/rcupdate.h:223:2: error: #error "Unknown RCU implementa=
tion specified to kernel configuration"
> make[2]: *** [arch/arm/kernel/asm-offsets.s] Error 1
> make[1]: *** [prepare0] Error 2
> make[1]: Leaving directory `/home/sander/speedy/trunk/ptx/kernel/linu=
x'
> make: *** [/home/sander/speedy/trunk/ptx/platform-pmx-one/state/kerne=
l.compile] Error 2
>=20
>=20
> When trying to select the rcu in the menuconfig it is not selectable =
:-(.
>=20
> This is on freescale arm i.xm35 platform with local modifications for=
 our own platform.
>=20
> Havent tried to compile 3.2-rc1 without preempt but that fails with t=
he following error:
> ----------------------
> target: kernel.compile
> ----------------------
>=20
> cd /home/sander/speedy/trunk/ptx/platform-pmx-one/build-target/linux-=
linux && PATH=3D/home/sander/speedy/trunk/ptx/platform-pmx-one/sysroot-
> cross/bin:/home/sander/speedy/trunk/ptx/platform-pmx-one/sysroot-cros=
s/sbin:$PATH KCONFIG_NOTIMESTAMP=3D1 make \
>                 -j16 HOSTCC=3Dgcc ARCH=3Darm CROSS_COMPILE=3Darm-1136=
jfs-linux-gnueabi- INSTALL_MOD_PATH=3D/home/sander/speedy/trunk/ptx/pla=
tform-pmx-one/packages/linux-linux=20
> PTX_KERNEL_DIR=3D/home/sander/speedy/trunk/ptx/platform-pmx-one/build=
-target/linux-linux CONFIG_DEBUG_SECTION_MISMATCH=3Dy=20
> DEPMOD=3D/home/sander/speedy/trunk/ptx/platform-pmx-one/sysroot-cross=
/sbin/arm-1136jfs-linux-gnueabi-depmod uImage "modules"
> make[1]: Entering directory `/home/sander/speedy/trunk/ptx/kernel/lin=
ux'
>   CHK     include/linux/version.h
>   CHK     include/generated/utsrelease.h
> make[2]: `include/generated/mach-types.h' is up to date.
>   CALL    scripts/checksyscalls.sh
> <stdin>:1562:2: warning: #warning syscall process_vm_readv not implem=
ented
> <stdin>:1566:2: warning: #warning syscall process_vm_writev not imple=
mented
>   CHK     include/generated/compile.h
>   CC      arch/arm/plat-mxc/iomux-v3.o
>   CC      arch/arm/plat-mxc/ulpi.o
>   CC      arch/arm/plat-mxc/avic.o
>   CC      arch/arm/plat-mxc/audmux-v2.o
>   CC      arch/arm/plat-mxc/devices/platform-fec.o
>   CC      arch/arm/plat-mxc/devices/platform-flexcan.o
>   CC      arch/arm/plat-mxc/devices/platform-fsl-usb2-udc.o
>   CC      arch/arm/plat-mxc/devices/platform-gpio-mxc.o
>   CC      arch/arm/plat-mxc/devices/platform-imx2-wdt.o
> arch/arm/plat-mxc/avic.c:154:39: error: expected '=3D', ',', ';', 'as=
m' or '__attribute__' before 'avic_handle_irq'
> arch/arm/plat-mxc/avic.c:53:12: warning: 'avic_saved_mask_reg' define=
d but not used
> make[2]: *** [arch/arm/plat-mxc/avic.o] Error 1
> make[2]: *** Waiting for unfinished jobs....
>=20
> Will there be still some consolidation for the 3.0 kernel. I really w=
as hoping that the rt kernel still remains a little longer=20
> on 3.0 since this seems to be a longer maintained kernel version for =
various groups?
>=20
> Best regards
> Tim
>=20
> please ignore the noise below, added automatically by mailserver:
>=20
> Hottinger Baldwin Messtechnik GmbH, Im Tiefen See 45, 64293 Darmstadt=
, Germany | www.hbm.com=20
>=20
> Registered as GmbH (German limited liability corporation) in the comm=
ercial register at the local court of Darmstadt, HRB 1147 =20
> Company domiciled in Darmstadt | CEO: Andreas Huellhorst | Chairman o=
f the board: James Charles Webster
>=20
> Als Gesellschaft mit beschraenkter Haftung eingetragen im Handelsregi=
ster des Amtsgerichts Darmstadt unter HRB 1147=20
> Sitz der Gesellschaft: Darmstadt | Geschaeftsfuehrung: Andreas Huellh=
orst | Aufsichtsratsvorsitzender: James Charles Webster
>=20
> The information in this email is confidential. It is intended solely =
for the addressee. If you are not the intended recipient, please let me=
 know and delete this email.
>=20
> Die in dieser E-Mail enthaltene Information ist vertraulich und ledig=
lich f=C3=BCr den Empfaenger bestimmt. Sollten Sie nicht der eigentlich=
e Empfaenger sein, informieren Sie mich bitte kurz und loeschen diese E=
-Mail.


--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
